function [ XYZ ] = threedPoints_ginput2(T)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here T=62.57mm
if T==0
    T=62.57;
end
load 3dpoints_function.mat;
l=input('Please enter name of left picture: ','s');
left=imread(l);
r=input('Please enter name of right picture: ','s');
right=imread(r);
imshow(left);
%zoom='no';
%while strcmp(zoom,'no')
 %   zoom=input('Is it zoomed in enough: ','s');
%end
[x_l y_l]=ginput2;
%zoom='no';
[numpts,~]=size(x_l);
imshow(right);
%while strcmp(zoom,'no')
  %  zoom=input('Is it zoomed in enough: ','s');
%end
[x_r, ~]=ginput2;
[numptsr,~]=size(x_r);
if numpts~=numptsr
    disp('Number of points for each image is different');
end
[XYZ]=Z_position_matrix(x_l',y_l',x_r',T,fc(1),cc,1);
plotpoints(XYZ);
pl_lines=input('Plot lines? ','s');
if strcmp(pl_lines,'yes')
    line_adam_matrix(XYZ);
end
calcdist=input('Calculate distance: ','s');
if strcmp(calcdist,'y')
    Distance2(XYZ)
end
stringvtk(XYZ)

end

