function [fig] = plotpoints( XYZ )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[~, numpts]=size(XYZ);
for i=1:numpts
    fig=plot3(XYZ(3,i),XYZ(1,i),XYZ(2,i),'Marker','.','Markersize',6);
    hold on
end
daspect([1 1 1])
end

