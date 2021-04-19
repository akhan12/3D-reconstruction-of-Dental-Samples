function Rot_points= Numerical_Rotation( points1,points2,refpoints,ind)
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
err_euc=0;

for theta=0:0.01:360
    
Rot=[cosd(theta),0,sind(theta);0,1,0;-sind(theta),0,cosd(theta)];
Rotpoints=Rot*T_all_points;
Rotpoints=Rotpoints+tpoints;
if theta==0
    temp=Rotpoints;
    err_prev=sum(abs(temp(:,1:refpoints)-points1(:,1:refpoints)),1);
    err_prev(1)=[];
    final_teta=theta;
    %using euclid
    err_euclid_prev=Rotpoints(:,1:refpoints)-points1(:,1:refpoints);
    err_euclid_prev(:,1)=[];
    err_euclid_prev=err_euclid_prev.^2;
    err_euclid_prev=sum(err_euclid_prev,1);
    err_euclid_prev=sqrt(err_euclid_prev);
    continue
end
Rotpoints(:,1:refpoints)-points1(:,1:refpoints);
err_current=sum(abs(Rotpoints(:,1:refpoints)-points1(:,1:refpoints)),1);
err_current(1)=[];
%using euclidean
err_euclid_current=Rotpoints(:,1:refpoints)-points1(:,1:refpoints);
err_euclid_current(:,1)=[];
err_euclid_current=err_euclid_current.^2;
err_euclid_current=sum(err_euclid_current,1);
err_euclid_current=sqrt(err_euclid_current);
%err_prev(1)=[];
min(err_current);
min(err_prev);
if sum(err_current)<sum(err_prev)
    temp=Rotpoints;
    err_prev=err_current;
    err_euclid_prev=err_euclid_current;
    final_teta=theta;
end
sum(err_current);
sum(err_prev);
%plotpoints([points1,Rotpoints]);
if theta==360
    Rot_points=temp;
    ERROR1=err_prev;
    err_euc=err_euclid_prev;
end

%erro(j,:)=sum(abs(Rotpoints-points1),1);



%hold on;
end
ERO=sum(ERROR1)/(numpts-1)
err_euc=sum(err_euc)/(numpts-1)
npt=numpts-1
if ind==1
plotpoints([points1,Rot_points]);

end
%erro(73,:)=[];
%[x,y]=min(erro)
%x(1)=100000;
%[x ind]=min(x);
%ind=y(ind)
end

