% Selection implemented with roulette wheel
function [best,bestGen,parent] = roulette_selection(pop)
[popsize, chromLen] = size(pop);
%% FITNESS + PENALTY FUNCTIONs
distance_sum = zeros(popsize,1);
fitness = zeros(popsize,1);
penalty = zeros(popsize,1);
for i = 1:popsize
    distance_sum(i) = total_dis(pop(i,:));
    if check_dis(pop(i,:),1000)
        penalty(i,1) = -0.5/(distance_sum(i).^2);
    end
        fitness(i,1) = 1/(distance_sum(i).^2);
        fitness(i,1) = fitness(i,1) + penalty(i,1);
end
%% EXTRACT BEST INDIVIDUAL
[~,best_factor] = max(fitness);
best = distance_sum(best_factor);
bestGen = pop(best_factor,:);
%% ROULETTE SELECTION
% probability of each individual calculated according to fitness
p = fitness/sum(fitness);
% chromosome selected viewed as its index in pop (chrom_indices)
chrom_indices = zeros(1,popsize);
acc = cumsum(p);
parent = zeros(popsize,chromLen);
% Selection using roulette wheel
for i = 1:length(p)
    rand_num = rand * acc(end);
    for j = 1:length(acc)
        if acc(j) >= rand_num
            chrom_indices(1,i) = j;
            break;
        end
    end
    parent(i,:) = pop(chrom_indices(i),:);
end
end
