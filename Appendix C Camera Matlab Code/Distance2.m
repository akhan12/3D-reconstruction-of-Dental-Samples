function [ Distance ] = Distance2( XYZ )
%DISTANCE Summary of this function goes here
%   Detailed explanation goes here
%xd=(x1-x2)^2;
%yd=(y1-y2)^2;
%zd=(z1-z2)^2;
%distance = sqrt(xd+yd+zd);
[~,numpts]=size(XYZ);
Distance=zeros(1,numpts-1);
co_1=zeros(3,1);
co_2=zeros(3,1);
for i=1:(numpts-1)
    co_1=XYZ(:,i);
    co_2=XYZ(:,i+1);
    co_d=co_1-co_2;
co_d_s=co_d.^2;
Distance(i)=sqrt((sum(co_d_s)));
end


end

