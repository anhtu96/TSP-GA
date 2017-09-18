clear; clc;
%% distance table
distance = [ 0      730 640 840 800 430 380 1010;
             730  0     710 1040 500 300 540 470;
             640  710 0     1420 1050 600 920  1160;
             840  1040 1420 0     740 950 570  900;
             800  500 1050 740 0     520 460  200
             430  300 600 950 520 0     390  690;
             380  540 920 570 460 390 0      660;
             1010 470 1160 900 200 690 690  0];
len = length(distance);
%% INITIALIZATION
popsize = 100;
iteration = 1000;
stopPoint = 0;
% check if there is no improvement over generations
stall = 0;
max_stallGeneration = 100;
% offspring
offspring = zeros(popsize,8);
% crossover probability
pc = 0.9;
% mutation probability
pm = 0.02;
% matrix holds all population
pop = zeros(popsize,len);
% distance and fitness matrix
fitness = zeros(popsize,1);
distance_sum = zeros(popsize,1);
best_distance = 0;
% randomize population
for i = 1:popsize
    pop(i,:) = randperm(len);
end
for i = 1:popsize
     distance_sum(i) = total_dis(pop(i,:));
     fitness(i,1) = 1/distance_sum(i)^2;
end
%% SUPERLOOP
% SUPERLOOP contains 3 phases
% - Selection
% - Reproduction
% - Evaluation
% additionnal there is a termination testing phase

for cnt = 1:iteration
    %% Selection
    [~,~,parent] = roulette_selection(pop);
    plot(cnt,best_distance,'--gs','LineWidth',2,'MarkerSize',2);
    hold on;
    %% Reproduction
    % Reproduction default offspring = parent
    offspring = parent;
    % Crossover
     for i = 1:(popsize/2)
         if (rand <= pc)
             cross_point = randi([2 6]);
             for j = 1:cross_point
                 m = find(offspring(i*2-1,:)==parent(i*2,j),1);
                 if (m > j)
                     offspring(i*2-1,m) = offspring(i*2-1,j);
                 end
                 offspring(i*2-1,j) = parent(i*2,j);
 
                 n = find(offspring(i*2,:)==parent(i*2-1,j),1);        
                 if (n > j)
                     offspring(i*2,n) = offspring(i*2,j);
                 end        
                 offspring(i*2,j) = parent(i*2-1,j);
             end
         end
     end


    % Mutation
    for i = 1:popsize
        if rand <= pm
            rand_pos = randperm(8,2);
            tmp = offspring(i,rand_pos(1));
            offspring(i,rand_pos(1)) = offspring(i,rand_pos(2));
            offspring(i,rand_pos(2)) = tmp;
        end
        distance_sum(i) = total_dis(offspring(i,:));
    end
    %% Evaluation
    [total_dis_tmp, position_tmp] = min(distance_sum);
    if ((total_dis_tmp < best_distance) || (best_distance == 0))
        best_distance = total_dis_tmp;
        best_path = offspring(position_tmp,:);
        stall = 0;
    else 
        stall = stall + 1;
    end
    pop = offspring;
    %% exit condition test
    if(stall >= max_stallGeneration)
        stopPoint = cnt;
        break;
    end
end
hold off;
%% RESULT
disp('Best path is: '); disp(best_path);
fprintf('Distance of that path: %dkm - Iteration: %d\r\n',best_distance,stopPoint);