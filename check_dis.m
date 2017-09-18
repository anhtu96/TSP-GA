function [overRange] = check_dis(array,maxDistance)
%CHECK_DIS Summary of this function goes here
% Check if there aren't 2 consecutive points whose distances exceeed maxDistance
%   Detailed explanation goes here
x = [ 0      730 640 840 800 430 380 1010;
             730  0     710 1040 500 300 540 470;
             640  710 0     1420 1050 600 920  1160;
             840  1040 1420 0     740 950 570  900;
             800  500 1050 740 0     520 460  200
             430  300 600 950 520 0     390  690;
             380  540 920 570 460 390 0      660;
             1010 470 1160 900 200 690 690  0];
overRange = 0;
len = length(array);
for i=1:length(array)
    if i == 1
        pointA = array(len-1);
        pointB = array(len);
        pointC = array(1);
        distance = x(pointC,pointB) + x(pointB,pointA);
    elseif i == 2
        pointA = array(len);
        pointB = array(1);
        pointC = array(2);
        distance = x(pointC,pointB) + x(pointB,pointA);
    else
        pointA = array(i-2);
        pointB = array(i-1);
        pointC = array(i);
        distance = x(pointC,pointB) + x(pointB,pointA);
    end
    
    if distance > maxDistance
        overRange = 1;
        break;
    end
end
end

