function sum = total_dis(array,distance)

sum = 0;
for i = 2:length(array)
    sum = sum + distance(array(i),array(i-1));
end
sum = sum + distance(array(end),array(1));