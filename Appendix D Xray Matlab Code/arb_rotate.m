function [ rot_image ] = arb_rotate( image,theta,rot_point )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
theta=-theta;
rotation=[cosd(theta) -sind(theta) 0;sind(theta) cosd(theta) 0;0 0 1];
trans=[1 0 rot_point(1);0 1 rot_point(2);0 0 1];
trans_neg=[1 0 -rot_point(1);0 1 -rot_point(2);0 0 1];
rot_trans=[1 0 rot_point(1);0 1 rot_point(2);0 0 1]*rotation*[1 0 -rot_point(1);0 01 -rot_point(2);0 0 1];
htransform=maketform('projective',trans);
rot_image=imtransform(image,htransform);

end