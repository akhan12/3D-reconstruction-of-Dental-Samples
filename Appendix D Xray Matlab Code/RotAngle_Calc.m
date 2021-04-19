function [ rot_angle ] = RotAngle_Calc( image,vslopeint,intercepts,under_90 )
%Calculates the angle of rotation
amplitu = 161.5383;
angle_dist=Perp_distance(image,vslopeint,intercepts);
rot_angle=asind(angle_dist/amplitu);
if under_90~=1
    rot_angle=180-rot_angle;
end
end

