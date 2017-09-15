function mat = roulette_selection(array)
acc = cumsum(array);
for i = 1:length(array)
    rand_num = rand * acc(end);
    for j = 1:length(acc)
        if acc(j) >= rand_num
            mat(i) = j;
            break;
        end
    end
end