function [ x y z ] = line_adam( co1,co2)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
alpha=0:0.05:1;
x=(alpha*co1(1))+((1-alpha)*co2(1));
y=(alpha*co1(2))+((1-alpha)*co2(2));
z=(alpha*co1(3))+((1-alpha)*co2(3));

end

