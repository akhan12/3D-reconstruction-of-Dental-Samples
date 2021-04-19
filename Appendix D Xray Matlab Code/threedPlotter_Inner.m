function test= threedPlotter_Inner( Points,file_name)
%three dimensional array of points
%x values are 1st and y values second
%Z values are the index of row index
%217 and 790 and 574 values
% y values go from 217-25+1 i.e 193 to 193+574-1
%[size_rows,~]=size(canal);

%y_limits of incisor is 76 and 770
%Y inner limits is 234 and 770 of incisor
innerstart=234;
outerstart=76;
starting=innerstart-outerstart;
[z,~,~]=size(Points);
%plot3(Points(:,1,1),Points(:,2,1),1:z,Points(:,1,2),Points(:,2,2),1:z,Points(:,1,3),Points(:,2,3),1:z,Points(:,1,4),Points(:,2,4),1:z)
midx=(Points(:,1,1)+Points(:,1,2))/2;
midy=(Points(:,2,1)+Points(:,2,3))/2;
Points2=zeros(size(Points));
%{
Points2(:,1,1)=midx;
Points2(:,2,1)=Points(:,2,1);
Points2(:,1,2)=midx;
Points2(:,2,2)=Points(:,2,3);
Points2(:,1,3)=Points(:,1,1);
Points2(:,2,3)=midy;
Points2(:,1,4)=Points(:,1,2);
Points2(:,2,4)=midy;
%}

Points2(:,1,2)=midx;
Points2(:,2,2)=Points(:,2,1);
Points2(:,1,4)=midx;
Points2(:,2,4)=Points(:,2,3);
Points2(:,1,3)=Points(:,1,1);
Points2(:,2,3)=midy;
Points2(:,1,1)=Points(:,1,2);
Points2(:,2,1)=midy;
%plot3(Points2(:,1,1),Points2(:,2,1),1:z,Points2(:,1,2),Points2(:,2,2),1:z,Points2(:,1,3),Points2(:,2,3),1:z,Points2(:,1,4),Points2(:,2,4),1:z)
%plot3(Points2(1,1,1),Points2(1,2,1),1,'.',Points2(1,1,2),Points2(1,2,2),1,'.',Points2(1,1,3),Points2(1,2,3),1,'.',Points2(1,1,4),Points2(1,2,4),1,'.')
%hold
%plot3(Points(1,1,1),Points(1,2,1),1,'.',Points(1,1,2),Points(1,2,2),1,'.',Points(1,1,3),Points(1,2,3),1,'.',Points(1,1,4),Points(1,2,4),1,'.')
%plot3(Points(2,1,1),Points(2,2,1),1,'.',Points(2,1,2),Points(2,2,2),1,'.',Points(2,1,3),Points(2,2,3),1,'.',Points(2,1,4),Points(2,2,4),1,'.')
test=[Points2(1,1,1),Points2(1,1,2),Points2(1,1,3),Points2(1,1,4);Points2(1,2,1),Points2(1,2,2),Points2(1,2,3),Points2(1,2,4)];

%figure
%hold
%using cubic spline
%{
for i=1:30:z
x = pi*[0:.5:2]; 
y = [0,Points2(i,1,1),Points2(i,1,2),Points2(i,1,3),Points2(i,1,4),Points2(i,1,1),0; 
     1,Points2(i,2,1),Points2(i,2,2) Points2(i,2,3),Points2(i,2,4),Points2(i,2,1),1];
pp = spline(x,y);
yy = ppval(pp, linspace(0,2*pi,35));
[rows,cols]=size(yy);
z_co=i*ones(1,cols);
plot3(yy(1,:),yy(2,:),z_co);
end
axis equal
%}
%using ellipses

figure(3)

Cente=[midx,midy];
a=abs(Points(:,1,1)-Points(:,1,2));
a=a/2;
b=abs(Points(:,2,1)-Points(:,2,3));
b=b/2;
numpoints=100;
xpoints=zeros(z,numpoints);
ypoints=zeros(z,2*numpoints);
%Ply writer
fname=strcat(file_name,'.ply');
fileId=fopen(fname,'w');
fprintf(fileId,'ply\n');
fprintf(fileId,'format ascii 1.0\n');
sz=numpoints*z*2;
fprintf(fileId,'element vertex %d\n',sz);
fprintf(fileId,'property float x\nproperty float y\nproperty float z\nelement face %d\nproperty list uchar int vertex_index\nend_header\n',0);

for i=1:z
    xpoints(i,:)=linspace(Points(i,1,1),Points(i,1,2),numpoints);
    %first part of ellipse equation
    x_implic=((xpoints(i,:)-Cente(i,1))./a(i)).^2;
    right_hand1=1-x_implic;
    right_hand2=(b(i)^2)*right_hand1;
    square_rt=sqrt(right_hand2);
    %y_pos=square_rt+Cente(i,2);
    y_pos=square_rt;
    ypoints(i,:)=[y_pos,fliplr(-y_pos)]+Cente(i,2);
    ypoints_1(i,:)=y_pos+Cente(i,2);
    ypoints_2(i,:)=fliplr(-y_pos)+Cente(i,2);
    zee=i*ones(1,numpoints*2);
    
    xpoints2(i,:)=fliplr(xpoints(i,:));
    xdat=[xpoints(i,:),fliplr(xpoints(i,:))];
    
    if mod(i,50)==0
        %ypoints(i,:);
        %[xpoints(i,:),fliplr(xpoints(i,:))];
    plot3([xpoints(i,:),fliplr(xpoints(i,:))],ypoints(i,:),zee,'.')
    end
end
%axis equal
%xpoints=[xpoints,fliplr(xpoints)]

%{
interpos_1x=(xpoints(:,1)+xpoints(:,2))/2;
interpos_2x=(xpoints(:,end)+xpoints(:,end-1))/2;

interpos_1y=(ypoints_1(:,1)+ypoints_1(:,2))/2;
interpos_2y=(ypoints_1(:,end)+ypoints_1(:,end-1))/2;


interneg_1x=(xpoints2(:,1)+xpoints2(:,2))/2;
interneg_2x=(xpoints2(:,end)+xpoints2(:,end-1))/2;

interneg_1y=(ypoints_2(:,1)+ypoints_2(:,2))/2;
interneg_2y=(ypoints_2(:,end)+ypoints_2(:,end-1))/2;

%concat x and y
xpoints=[xpoints(:,1),interpos_1x,xpoints(:,2:(end-1)),interpos_2x,xpoints2(:,1),interneg_1x,xpoints2(:,2:(end-1)),interneg_2x];
ypoints=[ypoints_1(:,1),interpos_1y,ypoints_1(:,2:(end-1)),interpos_2y,ypoints_2(:,1),interneg_1y,ypoints_2(:,2:(end-1)),interneg_2y];
[te,intercols]=size(xpoints)
size(ypoints)
for i=1:z
    zee=i*ones(1,intercols);
    plot3(xpoints(i,:),ypoints(i,:),zee,'.','MarkerSize',0.5)
end
axis equal
%}
[xpoints,ypoints]=Xray_interpolator(xpoints,xpoints2,ypoints_1,ypoints_2,3);
Xray_Ply_inner(xpoints,ypoints,file_name,starting);



end