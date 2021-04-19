function [ XYZ ] = Z_position_matrix(left_point_transpose,y_left_point_transpose, right_point_transpose,T,focal_point,cc,right_co )
%Z_POSITION function that calculates the Z position of a 
%stereo pair of cameras, given the translation of the cameras
% and then image point 
%right_co==1 gives the correct orientation in a right handed system
Q=[1 0 0 -cc(1);0 1 0 -cc(2);0 0 0 focal_point;0 0 1/T 0];
columns=size(left_point_transpose);
row_4=ones(1,columns(2));
image_co=[left_point_transpose;y_left_point_transpose;(left_point_transpose-right_point_transpose);row_4];
XYZ=Q*image_co;

for i=1:columns(2)
    XYZ(:,i)=XYZ(:,i)/XYZ(4,i);
end
XYZ(4,:)=[];
%XYZ=XYZ/(XYZ(4));
%XYZ(4)=[];
if right_co==1
    XYZ(2,:)=-(XYZ(2,:));
    XYZ(1,:)=-(XYZ(1,:));
end
%Z=focal_point*T/(left_point-right_point);
%X=(left_point-(cc(1)))*Z/focal_point;
%Y=(y_left_point-(cc(2)))*Z/focal_point;
end

