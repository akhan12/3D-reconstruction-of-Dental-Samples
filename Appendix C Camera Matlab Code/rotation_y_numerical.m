function [ theta,min_error ] = rotation_y_numerical( refpoint,point,x,z )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[r,c]=size(x);
count=1;
count2=1;
for theta=0:1:360
    for i=1:c
        for j=1:r
            origin=[x(j,i);0;z(j,i)];
            rot=rotation_y(point,theta,origin);
            error(count)=norm(refpoint-rot);
            count=count+1;
        end
    end
    count=1;
    error2(count2)=min(error);
    count2=count2+1;
end
theta=0:1:360;
[min_error,ind]=min(error2)
theta=theta(ind);
end

