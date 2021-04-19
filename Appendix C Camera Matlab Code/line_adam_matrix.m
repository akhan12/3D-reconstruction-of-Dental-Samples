function [ line ] = line_adam_matrix( XYZ)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
alpha=0:0.0001:1;
[~, numpts]=size(XYZ);
for i=1:(numpts-1)
co1=XYZ(:,i);
co2=XYZ(:,i+1);
x=(alpha*co1(1))+((1-alpha)*co2(1));
y=(alpha*co1(2))+((1-alpha)*co2(2));
z=(alpha*co1(3))+((1-alpha)*co2(3));
plot3(z,x,y);
hold on
end
end

