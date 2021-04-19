function [ XYZ ] = threedPoints(T,numpts )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here T=62.57mm
% or T=68.51mm
if T==0
    T=62.57;
end
load 3dpoints_function.mat;
l=input('Please enter name of left picture: ','s');
left=imread(l);
r=input('Please enter name of right picture: ','s');
right=imread(r);
imshow(left);
zoom='no';
while strcmp(zoom,'no')
    zoom=input('Is it zoomed in enough: ','s');
end
[x_init y_init]=ginput(1);
text(x_init,y_init,'1');
[x_l y_l]=ginput(numpts);
zoom='no';
figure;
imshow(right);
for i=1:numpts
    hold on;
    figure(2);line([0 4320],[y_l(i) y_l(i)]);

end
while strcmp(zoom,'no')
    zoom=input('Is it zoomed in enough: ','s');
end
[x_r, y_r]=ginput(numpts);

showpts=input('Do you want to show points on images? ','s');
if strcmp(showpts,'yes')||strcmp(showpts,'y')
    imshow(left);
    hold on
    for i=1:numpts
        text(x_l(i),y_l(i),num2str(i),'Fontsize',6);
        hold on
    end
    temp=input('Exit','s');
    imshow(right);
    for i=1:numpts
        text(x_r(i),y_r(i),num2str(i),'Fontsize',6);
        hold on
    end
end
close(figure);
[XYZ]=Z_position_matrix(x_l',y_l',x_r',T,fc(1),cc,1);

plotpoints(XYZ);
axis equal;

pl_lines=input('Plot lines? ','s');
if strcmp(pl_lines,'yes')||strcmp(pl_lines,'y')
    line_adam_matrix(XYZ);
end

calcdist=input('Calculate distance: ','s');
if strcmp(calcdist,'y')||strcmp(calcdist,'yes')
    Distance2(XYZ)
end
stringvtk(XYZ)

end

