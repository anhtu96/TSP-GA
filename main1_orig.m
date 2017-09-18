tic
clc;
clear;
distance = [ 0      730 640 840 800 430 380 1010;
             730  0     710 1040 500 300 540 470;
             640  710 0     1420 1050 600 920  1160;
             840  1040 1420 0     740 950 570  900;
             800  500 1050 740 0     520 460  200
             430  300 600 950 520 0     390  690;
             380  540 920 570 460 390 0      660;
             1010 470 1160 900 200 690 690  0];
len = length(distance);
popsize = 200;
iteration = 50;
distance_sum = zeros(popsize,1);
p = zeros(popsize,1);
pc = 0.9;
pm = 0.01;

 for i = 1:popsize
     pop(i,:) = randperm(len);
 end
best_distance = 0;


for cnt = 1:iteration
    for i = 1:popsize
        distance_sum(i) = total_dis(pop(i,:),distance);
        fitness(i,1) = 1/distance_sum(i)^2;
    end
    p = fitness/sum(fitness);
    selected_mat = roulette_selection(p);
    for i = 1:popsize
        parent(i,:) = pop(selected_mat(i),:);
    end
    %crossover
    for i = 1:(popsize/2)
        offspring(i*2-1,:) = parent(i*2-1,:);
        offspring(i*2,:) = parent(i*2,:);
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

    % mutation
    for i = 1:popsize
        if rand <= pm
            rand_pos = randperm(8,2);
            tmp = offspring(i,rand_pos(1));
            offspring(i,rand_pos(1)) = offspring(i,rand_pos(2));
            offspring(i,rand_pos(2)) = tmp;
        end
        distance_sum(i) = total_dis(offspring(i,:),distance);
    end
    [total_dis_tmp position_tmp] = min(distance_sum);
    if ((total_dis_tmp < best_distance) || (best_distance == 0))
        best_distance = total_dis_tmp;
        best_path = offspring(position_tmp,:);
    end
    pop = offspring;
    pop(1,:) = best_path;
end
disp('Best path is: '); best_path
fprintf('Distance of that path: %dkm\n',best_distance);
toc