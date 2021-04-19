function [ Rotpoints ] = rotation_y( co,theta,origin)
%Right handed rotation counterclockwise about the y axis
%origin=[24.021984229900280;0;71.558039877665777];
%origin=[-22.069366681;0;69.2319];
%origin = [  -32.8476
  %   0
  %     67.4053];
%origin=[-32.7732,0,67.6633];
[~,numpts]=size(co);
tpoints=zeros(3,numpts);
for i=1:numpts 
    tpoints(:,i)=origin
end
T_all_points=co-tpoints;
Rot=[cosd(theta),0,sind(theta);0,1,0;-sind(theta),0,cosd(theta)];
Rotpoints=Rot*T_all_points;
Rotpoints=Rotpoints+tpoints;

end

