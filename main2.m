clc;
clear;
distance = [ 0      0.730 0.640 0.840 0.800 0.430 0.380 1.010;
             0.730  0     0.710 1.040 0.500 0.300 0.540 0.470;
             0.640  0.710 0     1.420 1.050 0.600 0.920  1.160;
             0.840  1.040 1.420 0     0.740 0.950 0.570  0.900;
             0.800  0.500 1.050 0.740 0     0.520 0.460  0.200
             0.430  0.300 0.600 0.950 0.520 0     0.390  0.690;
             0.380  0.540 0.920 0.570 0.460 0.390 0      0.660;
             1.010  0.470 1.160 0.900 0.200 0.690 0.690  0];
len = length(distance);
popsize = 200;
iteration = 200;
distance_sum = zeros(popsize,1);
p = zeros(popsize,1);
pc = 0.9;
pm = 0.01;

 for i = 1:popsize
     pop(i,:) = randperm(len);
     distance_sum(i) = total_dis(pop(i,:));
     fitness(i,1) = 1/distance_sum(i);
 end
p = fitness/sum(fitness);
[~,best_factor] = min(distance_sum);
best_distance = distance_sum(best_factor);
best_path = pop(best_factor,:);

crossover_mat = roulette_selection(p);
for i = 1:popsize
    parent(i,:) = pop(crossover_mat(i),:);
end
for cnt = 1:iteration
    %crossover
    for i = 1:(popsize/2)
        offspring(i*2-1,:) = parent(i*2-1,:);
        offspring(i*2,:) = parent(i*2,:);
        if (rand <= pc)
            cross_point = randi([2 6]);
            m = setdiff(parent(i*2,:),parent(i*2-1,1:cross_point),'stable');
            n = setdiff(parent(i*2-1,:),parent(i*2,1:cross_point),'stable');
            offspring(i*2-1,(cross_point + 1):len) =  m;
            offspring(i*2,(cross_point + 1):len) = n;
        end
    end

    % mutation
    for i = 1:popsize
        if rand <= pm
            rand_pos = randperm(8,2);
            tmp = offspring(i,rand_pos(1));
            offspring(i,rand_pos(1)) = offspring(i,rand_pos(2));
            offspring(i,rand_pos(2)) = tmp;
        end
        distance_sum(i) = total_dis(offspring(i,:));
    end
    [total_dis_tmp position_tmp] = min(distance_sum);
    if total_dis_tmp < best_distance
        best_distance = total_dis_tmp;
        best_path = offspring(position_tmp,:);
    end
    parent = offspring;
    parent(1,:) = best_path;
end
disp('Best path is: '); disp(best_path);
fprintf('Distance of that path: %fkm\n',best_distance);