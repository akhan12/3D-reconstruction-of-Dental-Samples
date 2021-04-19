function [ XYZ ] = threedPointsLineLeft(T,numpts )
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

zoom='no';

imshow(left);
while strcmp(zoom,'no')
    zoom=input('Is it zoomed in enough: ','s');
end
%[x_init y_init]=ginput(1);
%text(x_init,y_init,'1');
[x_line,y_line]=ginput(2);
line_distance=abs(y_line(1)-y_line(2));
increm=line_distance/(numpts-1);
for i=1:numpts
    if i==1
    line([0 4320],[y_line(1) y_line(1)]);
    else y_plot=(numpts-i)*increm;
        line([0 4320],[(y_line(1)+y_plot) (y_line(1)+y_plot)]);
    end
    
end
[x_l y_l]=ginput(numpts);

for i=1:numpts;
    text(x_l(i),y_l(i),num2str(i),'fontsize',5)
end
zoom='no';
figure;
imshow(right);
x_r=zeros(numpts,1);
y_r=zeros(numpts,1);
z_ornot=input('Multiple zoom?','s');
if strcmp(z_ornot,'yes')
for i=1:numpts
    figure(2);
    imshow(right);
    line([0 4320],[y_l(i) y_l(i)]);
    
   while strcmp(zoom,'no')
    zoom=input('Is it zoomed in enough: ','s');
   end 
    
    [x_rinit, y_rinit]=ginput(1);
    x_r(i)=x_rinit;
    y_r(i)=y_rinit;
    zoom='no';
end
else
    for j=1:numpts
    hold on;
    figure(2);line([0 4320],[y_l(j) y_l(j)]);

    end
    while strcmp(zoom,'no')
    zoom=input('Is it zoomed in enough: ','s');
    end
[x_r, y_r]=ginput(numpts);
end



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

