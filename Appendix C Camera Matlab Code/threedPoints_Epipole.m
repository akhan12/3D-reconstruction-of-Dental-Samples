function [ XYZ,T_y,pixeldiff ] = threedPoints_Epipole(T,numpts,Alone )
%UNTITLED2 Summary of this function goes here
%alone is is calculating epipoles alone
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
%epipolar plane calculation
zoom_epi='no';
imshow(left);
while strcmp(zoom_epi,'no')
    zoom_epi=input('Is it zoomed in enough: ','s');
end
[x_epi_l ,y_epi_l]=ginput(1);

zoom_epi='no';
imshow(right);
while strcmp(zoom_epi,'no')
    zoom_epi=input('Is it zoomed in enough: ','s');
end
[x_epi_r, y_epi_r]=ginput(1);
pixeldiff=y_epi_l-y_epi_r;
M=[fc(1) 0 cc(1);0 fc(2) cc(2);0 0 1];
M_inv=inv(M);
M_inv_T=transpose(M_inv);
syms Ty;
Trans=[0 0 Ty;0 0 -T;-Ty T 0];
func=M_inv_T*Trans*(M_inv);
func=func*[x_epi_l;y_epi_l;1];
func=[x_epi_r y_epi_r 1]*func;
T_y=solve(func);
T_y=double(T_y);
%normal routine
if Alone==0
zoom='no';

imshow(left);
while strcmp(zoom,'no')
    zoom=input('Is it zoomed in enough: ','s');
end
%[x_init y_init]=ginput(1);
%text(x_init,y_init,'1');
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
epiplane=subs(M_inv_T*Trans*(M_inv),Ty,T_y)
if strcmp(z_ornot,'yes')
for i=1:numpts
    figure(2);
    imshow(right);
    syms y1 y2
    wye_1=[0 y1 1]*epiplane*[x_l(i);y_l(i);1];
    wye_2=[4320 y2 1]*epiplane*[x_l(i);y_l(i);1];
    ye_1=solve(wye_1)
    ye_2=solve(wye_2)
    line([0 4320],[ye_1 ye_2]);
    
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
     syms y1 y2
    wye_1=[0 y1 1]*epiplane*[x_l(j);y_l(j);1];
    wye_2=[4320 y2 1]*epiplane*[x_l(j);y_l(j);1];
    ye_1=solve(wye_1)
    ye_2=solve(wye_2)
    line([0 4320],[ye_1 ye_2]);

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
else XYZ=0;
end
end

