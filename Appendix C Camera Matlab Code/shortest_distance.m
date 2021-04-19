function [ shortest_point index] = shortest_distance( linex, liney, linez, point )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[~,numpts]=size(linex);
index=1;
dist_small=0;
for i=1:numpts
    x=linex(i)-point(1);
    y=liney(i)-point(2);
    z=linez(i)-point(3);
    current_dist=x^2+y^2+z^2
    if i==1
        dist_small=current_dist;
    else
        if dist_small>current_dist
            index=i;
            dist_small=current_dist;
        end
    end
    
end
shortest_point=ones(1,3);
shortest_point(1)=linex(index);
shortest_point(2)=liney(index);
shortest_point(3)=linez(index);
end

