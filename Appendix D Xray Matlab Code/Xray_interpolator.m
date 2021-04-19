function [ xpoints,ypoints ] = Xray_interpolator( xpoints,xpoints2,ypoints_1,ypoints_2,num_inter)
%interpolates from end points num_interpolate specifies how many points 2
%interpolate from end points there number of additional columns are
%num_inter times 4

[rows,cols]=size(xpoints);
pos1x=zeros(rows,num_inter);
pos2x=zeros(rows,num_inter);
pos1y=zeros(rows,num_inter);
pos2y=zeros(rows,num_inter);
neg1x=zeros(rows,num_inter);
neg2x=zeros(rows,num_inter);
neg1y=zeros(rows,num_inter);
neg2y=zeros(rows,num_inter);
for i=1:num_inter
interpos_1x=(xpoints(:,i)+xpoints(:,i+1))/2;
interpos_2x=(xpoints(:,end-i+1)+xpoints(:,end-i))/2;

interpos_1y=(ypoints_1(:,i)+ypoints_1(:,i+1))/2;
interpos_2y=(ypoints_1(:,end-i+1)+ypoints_1(:,end-i))/2;


interneg_1x=(xpoints2(:,i)+xpoints2(:,i+1))/2;
interneg_2x=(xpoints2(:,end-i+1)+xpoints2(:,end-i))/2;

interneg_1y=(ypoints_2(:,i)+ypoints_2(:,i+1))/2;
interneg_2y=(ypoints_2(:,end-i+1)+ypoints_2(:,end-i))/2;

pos1x(:,i)=interpos_1x;
pos2x(:,i)=interpos_2x;
pos1y(:,i)=interpos_1y;
pos2y(:,i)=interpos_2y;
neg1x(:,i)=interneg_1x;
neg2x(:,i)=interneg_2x;
neg1y(:,i)=interneg_1y;
neg2y(:,i)=interneg_2y;
end
%concat x and y
xpoints=[xpoints(:,1),pos1x,xpoints(:,2:(end-1)),pos2x,xpoints2(:,1),neg1x,xpoints2(:,2:(end-1)),neg2x];
ypoints=[ypoints_1(:,1),pos1y,ypoints_1(:,2:(end-1)),pos2y,ypoints_2(:,1),neg1y,ypoints_2(:,2:(end-1)),neg2y];
[~,intercols]=size(xpoints);

for i=1:rows
    zee=i*ones(1,intercols);
    plot3(xpoints(i,:),ypoints(i,:),zee,'.','MarkerSize',0.5)
end
axis equal
end

