function Epipolar_Plotter(T,numpts,Ty )
%UNTITLED2 Summary of this function goes here
%remember Ty matrix
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
%{
for i=1:numpts
    if i==1
    line([0 4320],[y_line(1) y_line(1)]);
    else y_plot=(numpts-i)*increm;
        line([0 4320],[(y_line(1)+y_plot) (y_line(1)+y_plot)]);
    end
    
end
%}
for i=1:numpts
    
     y_plot=(i-1)*increm;
        line([0 4320],[(y_line(1)+y_plot) (y_line(1)+y_plot)]);
    
    
end
[x_l, y_l]=ginput(numpts);

for i=1:numpts;
    text(x_l(i),y_l(i),num2str(i),'fontsize',5)
end
zoom='no';
figure;
subplot(1,2,2);
imshow(right);
x_r=zeros(numpts,1);
y_r=zeros(numpts,1);

%epipolar plane
M=[fc(1) 0 cc(1);0 fc(2) cc(2);0 0 1];
M_inv=inv(M);
M_inv_T=transpose(M_inv);
Trans=[0 0 Ty;0 0 -T;-Ty T 0];
epiplane=M_inv_T*Trans*(M_inv)

z_ornot=input('Multiple zoom?','s');
if strcmp(z_ornot,'yes')
for i=1:numpts
    figure(2);
    imshow(right);
    syms y1 y2
    
    wye_1=[0 y1 1]*epiplane*[x_l(i);y_l(i);1];
    wye_2=[4320 y2 1]*epiplane*[x_l(i);y_l(i);1];
    ye_1=solve(wye_1);
    ye_2=solve(wye_2);
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
    figure(2);
    syms y1 y2;
    grad1=epiplane*[x_l(i);y_l(i);1];
    gradright=-(grad1(1)/grad1(2))
    wye_1=[0 y1 1]*epiplane*[x_l(j);y_l(j);1];
    wye_2=[4320 y2 1]*epiplane*[x_l(j);y_l(j);1];
    ye_1=solve(wye_1);
    ye_2=solve(wye_2);
    line([0 4320],[ye_1 ye_2]);
    end
    while strcmp(zoom,'no')
    zoom=input('Is it zoomed in enough: ','s');
    end
[x_r, y_r]=ginput(numpts)
end
subplot(1,2,1);
imshow(left);
hold on;

for j=1:numpts
    
    syms y1 y2;
    grad1=[x_r(j),y_r(j),1]*epiplane;
    gradleft=-(grad1(1)/grad1(2))
    wye_1=[x_r(j),y_r(j),1]*epiplane*[0; y1; 1];
    wye_2=[x_r(j),y_r(j),1]*epiplane*[4320;y2;1];
    ye_1=solve(wye_1);
    ye_2=solve(wye_2);
    line([0 4320],[ye_1 ye_2]);
end






end

