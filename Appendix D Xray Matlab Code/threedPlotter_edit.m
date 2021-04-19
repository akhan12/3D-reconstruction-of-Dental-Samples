function test= threedPlotter_edit( Points,file_name)
%three dimensional array of points
%x values are 1st and y values second
%Z values are the index of row index
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
hold
%plot3(Points(1,1,1),Points(1,2,1),1,'.',Points(1,1,2),Points(1,2,2),1,'.',Points(1,1,3),Points(1,2,3),1,'.',Points(1,1,4),Points(1,2,4),1,'.')
test=[Points2(1,1,1),Points2(1,1,2),Points2(1,1,3),Points2(1,1,4);Points2(1,2,1),Points2(1,2,2),Points2(1,2,3),Points2(1,2,4)];

figure
hold
%using cubic spline
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
%using ellipses
figure
hold
Cente=[midx,midy];
a=abs(Points(:,1,1)-Points(:,1,2));
a=a/2;
b=abs(Points(:,2,1)-Points(:,2,3));
b=b/2;
numpoints=6;
sz=((34*numpoints)-4)*z*2;
xpoints=zeros(z,((34*numpoints)-4));
ypoints=zeros(z,((34*numpoints)-4)*2);


%Ply writer
fname=strcat(file_name,'.ply');
fileId=fopen(fname,'w');
fprintf(fileId,'ply\n');
fprintf(fileId,'format ascii 1.0\n');

fprintf(fileId,'element vertex %d\n',sz);
fprintf(fileId,'property float x\nproperty float y\nproperty float z\nelement face %d\nproperty list uchar int vertex_index\nend_header\n',0);


for i=1:z
    %new way to find the number of points
    x_divisionpoints=linspace(Points(i,1,1),Points(i,1,2),6);
    xpoints1=linspace(x_divisionpoints(1),x_divisionpoints(2),15*numpoints);
    xpoints2=linspace(x_divisionpoints(2),x_divisionpoints(3),1.5*numpoints);
    xpoints2(1)=[];
    xpoints3=linspace(x_divisionpoints(3),x_divisionpoints(4),numpoints);
    xpoints3(1)=[];
    xpoints4=linspace(x_divisionpoints(4),x_divisionpoints(5),1.5*numpoints);
    xpoints4(1)=[];
    xpoints5=linspace(x_divisionpoints(5),x_divisionpoints(6),15*numpoints);
    xpoints5(1)=[];
    horzcat(xpoints1,xpoints2,xpoints3,xpoints4,xpoints5);
    xpoints(i,:)=horzcat(xpoints1,xpoints2,xpoints3,xpoints4,xpoints5);
    %first part of ellipse equation
    x_implic=((xpoints(i,:)-Cente(i,1))./a(i)).^2;
    right_hand1=1-x_implic;
    right_hand2=(b(i)^2)*right_hand1;
    square_rt=sqrt(right_hand2);
    %y_pos=square_rt+Cente(i,2);
    y_pos=square_rt;
    ypoints(i,:)=[y_pos,fliplr(-y_pos)]+Cente(i,2);
    zee=i*ones(1,((34*numpoints)-4)*2);
    xdat=[xpoints(i,:),fliplr(xpoints(i,:))];
    %another part of ply_writer
    for j=1:2*numpoints
        fprintf(fileId,'%f %f %f\n',xdat(j),zee(j),ypoints(i,j));
    end
    if mod(i,50)==0
        %ypoints(i,:);
        %[xpoints(i,:),fliplr(xpoints(i,:))];
    plot3([xpoints(i,:),fliplr(xpoints(i,:))],ypoints(i,:),zee,'.')
    end
end
axis equal
xpoints=[xpoints,xpoints];
fclose(fileId);

end

