function [ XYZ,T_y ] = threedPoints_Spline(T,numpts,Alone,tysup )
%UNTITLED2 Summary of this function goes here
%tysup if Ty ws calculated before
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

%{
zoom_epi='no';
imshow(left);
while strcmp(zoom_epi,'no')
    zoom_epi=input('Is it zoomed in enough: ','s');
end
[x_epi_l y_epi_l]=ginput(1)

zoom_epi='no';
imshow(right);
while strcmp(zoom_epi,'no')
    zoom_epi=input('Is it zoomed in enough: ','s');
end
[x_epi_r y_epi_r]=ginput(1)
%}
M=[fc(1) 0 cc(1);0 fc(2) cc(2);0 0 1];
M_inv=inv(M);
M_inv_T=transpose(M_inv);
syms Ty;
Trans=[0 0 Ty;0 0 -T;-Ty T 0];
%{
func=M_inv_T*Trans*(M_inv);
func=func*[x_epi_l;y_epi_l;1];
func=[x_epi_r y_epi_r 1]*func;
T_y=solve(func)
%}
T_y=tysup;
%normal routine
if Alone==0
zoom='no';

imshow(left);
while strcmp(zoom,'no')
    zoom=input('Is it zoomed in enough: ','s');
end
%[x_init y_init]=ginput(1);
%text(x_init,y_init,'1');



%[x_l y_l]=ginput(numpts);
%replace ginputhere
%[~,yminmax]=ginput(2);
h=imfreehand('closed',false);
left_co=getPosition(h);
x_l_freehand=left_co(:,1);
y_l_freehand=left_co(:,2);
%yleft_min=min(yminmax);
%yleft_max=min(yminmax);
%search for number of points now
yleft_min=min(y_l_freehand);
yleft_max=max(y_l_freehand);
y_search=linspace(yleft_min,yleft_max,numpts);

numvals=length(x_l_freehand);
x_l=zeros(numpts,1);
y_l=zeros(numpts,1);
diff=zeros(1,numvals);
for i=1:numpts
    for j=1:numvals
        diff(j)=abs(y_l_freehand(j)-y_search(i));
    end
    [~,index]=min(diff);
    x_l(i)=x_l_freehand(index);
    y_l(i)=y_l_freehand(index);
end



%max_l=max(x_l);
%minx_l=min(x_l);
%yy_left=spline(x_l,y_l,linspace(minx_l,max_l,40));

%hold
%plot(linspace(minx_l,max_l,40),yy_left);

%calculating spline curves for left
%using a line instead of a spline
%{
numptsline=100;
xl_line=zeros(1,((numpts-1)*numptsline)-(numpts-2));
yl_line=zeros(1,((numpts-1)*numptsline)-(numpts-2));
for i=1:(numpts-1)
    xtemp=linspace(x_l(i),x_l(i+1),numptsline);
    ytemp=linspace(y_l(i),y_l(i+1),numptsline);
    if i<(numpts-1)
        xtemp(end)=[];
        ytemp(end)=[];
        len=length(xtemp);
        indbegin=(len*(i-1))+1;
        indend=len*i;
       
    else
        len=length(xtemp);
        indbegin=((len-1)*(i-1))+1;
        indend=((len-1)*i)+1;
    end
     xl_line(indbegin:indend)=xtemp;
     yl_line(indbegin:indend)=ytemp;
end

figure(1)
hold
plot(xl_line,yl_line)
%}
for i=1:numpts;
    text(x_l(i),y_l(i),num2str(i),'fontsize',5)
end
zoom='no';
figure;
imshow(right);
x_r=zeros(numpts,1);
y_r=zeros(numpts,1);
z_ornot=input('Multiple zoom?','s');
%creating number of lines by number of points and 
ptsperline=800;
linex=zeros(numpts,ptsperline);
liney=zeros(numpts,ptsperline);


[xlims,~]=ginput(2);
xlims=xlims

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
    wye_1=[xlims(1) y1 1]*epiplane*[x_l(j);y_l(j);1];
    wye_2=[xlims(2) y2 1]*epiplane*[x_l(j);y_l(j);1];
    ye_1=solve(wye_1)
    ye_2=solve(wye_2)
    %line([0 4320],[ye_1 ye_2]);
    linex(j,:)=linspace(xlims(1),xlims(2),ptsperline);
    liney(j,:)=linspace(double(ye_1),double(ye_2),ptsperline);
    plot(linex(j,:),liney(j,:))
    end
    while strcmp(zoom,'no')
    zoom=input('Is it zoomed in enough: ','s');
    end
h2=imfreehand('closed',false);
right_co=getPosition(h2);
end

x_r_freehand=right_co(:,1);
y_r_freehand=right_co(:,2);



numvals=length(x_r_freehand);
x_r=zeros(numpts,1);
y_r=zeros(numpts,1);
euclid=zeros(1,numvals);
smll_euclid=zeros(ptsperline,2);

%numerical find the intersection of the line and freehand
for i=1:numpts
    for j=1:ptsperline
        for k=1:numvals
            euclid(k)=norm(([linex(i,j),liney(i,j)]-[x_r_freehand(k),y_r_freehand(k)]));
        end
      [va,ind]=  min(euclid);
      smll_euclid(j,:)=[va,ind];
    end
  [~,ind]=min(smll_euclid(:,1));
  x_r(i)=x_r_freehand(smll_euclid(ind,2));
  y_r(i)=y_r_freehand(smll_euclid(ind,2));
end
%spline for right side
%ppright=spline(x_r,y_r);

%using a line instead of a spline
%{
numptsline=100;
xr_line=zeros(1,((numpts-1)*numptsline)-(numpts-2));
yr_line=zeros(1,((numpts-1)*numptsline)-(numpts-2));
for i=1:(numpts-1)
    xtemp=linspace(x_r(i),x_r(i+1),numptsline);
    ytemp=linspace(y_r(i),y_r(i+1),numptsline);
    if i<(numpts-1)
        xtemp(end)=[];
        ytemp(end)=[];
        len=length(xtemp);
        indbegin=(len*(i-1))+1;
        indend=len*i;
       
    else
        len=length(xtemp);
        indbegin=((len-1)*(i-1))+1;
        indend=((len-1)*i)+1;
    end
     xr_line(indbegin:indend)=xtemp;
     yr_line(indbegin:indend)=ytemp;
end
figure(2)
hold
plot(xr_line,yr_line)
%}
[x_l,y_l];
[x_r,y_r];
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
