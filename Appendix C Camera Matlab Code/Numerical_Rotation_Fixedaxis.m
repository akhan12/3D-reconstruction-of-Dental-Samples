function Rot_points= Numerical_Rotation_Fixedaxis( points1,points2,refpoints,ind)
%points1 is the points in the reference coordinate frame
%points2 is the points that are to be rotated
%refpoints is the number of points used that is from 1:refpoints
%ind if ind is 1 then u can plot, where ind is the index from Recurs

vect=points1(:,1)-points2(:,1);
temp=vect;
sz=size(points2);
for i=1:sz(2)
    vect(:,i)=temp;
end
p2_ref_p1=vect+points2;
phi=85.8;
thet=89.4;
 x=sind(phi)*cosd(thet);
        y=sind(phi)*sind(thet);
        z=cosd(phi);
        

%more general rotation y
%Right handed rotation counterclockwise about the y axis
%origin=[24.021984229900280;0;71.558039877665777];
%origin=[-22.069366681;0;69.2319];
%origin = [  -32.8476
  %   0
  %     67.4053];
origin=points1(:,1);
numpts=sz(2);
[~,numpts2]=size(points1);
tpoints=zeros(3,numpts);
for i=1:numpts 
    tpoints(:,i)=origin;
end
T_all_points=p2_ref_p1-tpoints;
j=1;
%erro=zeros(73,numpts);
ERROR1=0;
for theta=0:0.1:360
[Rot,~]=AxelRot(theta,[x y z],[0 0 0]);
Rotpoints=Rot*T_all_points;
Rotpoints=Rotpoints+tpoints;
if theta==0
    temp=Rotpoints;
    err_prev=sum(abs(temp(:,1:refpoints)-points1(:,1:refpoints)),1);
    err_prev(1)=[];
    final_teta=theta;
    continue
end

err_current=sum(abs(Rotpoints(:,1:refpoints)-points1(:,1:refpoints)),1);
err_current(1)=[];

%err_prev(1)=[];
min(err_current);
min(err_prev);
if sum(err_current)<sum(err_prev)
    temp=Rotpoints;
    
    err_prev=err_current;
    final_teta=theta;
end
%plotpoints([points1,Rotpoints]);

    if theta==360
    Rot_points=temp;
    ERROR1=err_prev;
    end

%erro(j,:)=sum(abs(Rotpoints-points1),1);


j=j+1;
%hold on;
end

if ind==1
plotpoints([points1,Rot_points])
ERO=sum(ERROR1)/(refpoints-1)
final_teta
end
%erro(73,:)=[];
%[x,y]=min(erro)
%x(1)=100000;
%[x ind]=min(x);
%ind=y(ind)
end


