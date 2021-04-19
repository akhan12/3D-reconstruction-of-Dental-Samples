function  [stor_edge_axis,stor_edge_trans,stor_edge_rot,testpoints]=InnerReconstruction2(gradintercepts,angles,varargin )
%Calculate the outer surface of tooth
%y_limits is the limits of search where y_limit 1 is the upper part of the
%image that is the lower row
%gradintercepts is an nx2 matrix
%n is the number of input images
%y_limits of incisor is 76 and 770
%Y inner limits is 234 and 770 of incisor
n=nargin-2;

y_limits=zeros(1,2);
y_limits(1)=234;
y_limits(2)=770;

num_cols=abs(y_limits(1)-y_limits(2))+1;
canal_format=varargin{1};
%variable to store edge points plus the point of the axis
stor_edge_axis=zeros(num_cols,3,2);
stor_edge_axis(:,1:2,1)=canal_format(:,:,1);
stor_edge_axis(:,1:2,2)=canal_format(:,:,2);
   
 for im=1:2 
     count=1;
    for y=y_limits(1):y_limits(2)
        %finding the x value at a particular y limit
        orig_untrans=(y-gradintercepts(im,2))/gradintercepts(im,1);
       
        %storing the value in the matrix
        stor_edge_axis(count,3,im)=orig_untrans;
       count=count+1;
    end
 end
%reference angles to the positive x axis
x_angles=270-angles;
%calculating gradients from angles
gradients=tand(x_angles);


%performing shifts
%format is x1 x2 y1 y2
[y_rows,~,~]=size(stor_edge_axis);
stor_edge_trans=zeros(y_rows,4,2);
for i=1:2
    for y=1:y_rows
        stor_edge_trans(y,1,i)=stor_edge_axis(y,1,i)-stor_edge_axis(y,3,i);
        stor_edge_trans(y,2,i)=stor_edge_axis(y,2,i)-stor_edge_axis(y,3,i);
        stor_edge_trans(y,3,i)=-100;
        stor_edge_trans(y,4,i)=-100;
    end
end
%performing rotation of 90 degrees and leaving zero intact
stor_edge_rot=zeros(y_rows,4,2);
for y=1:y_rows
    stor_edge_rot(y,1,1)=stor_edge_trans(y,1,1);
    stor_edge_rot(y,2,1)=stor_edge_trans(y,2,1);
    stor_edge_rot(y,3,1)=-100;
    stor_edge_rot(y,4,1)=-100;
    %90 degrees
    stor_edge_rot(y,1,2)=-100;
    stor_edge_rot(y,2,2)=-100;
    stor_edge_rot(y,3,2)=-stor_edge_trans(y,1,2);
    stor_edge_rot(y,4,2)=-stor_edge_trans(y,2,2);
end

%performing rotation of the rest
if n>2
for i=3:n
    angl=x_angles(i-2);
    one_two=-100*sind(angl);
    two_two=-100*cosd(angl);
    one_one_co=cosd(angl);
    two_one_co=-sind(angl);
    for y=1:y_rows
        stor_edge_rot(y,1,i)=stor_edge_trans(y,1,i)*one_one_co+one_two;
        stor_edge_rot(y,3,i)=stor_edge_trans(y,1,i)*two_one_co+two_two;
        stor_edge_rot(y,2,i)=stor_edge_trans(y,2,i)*one_one_co+one_two;
        stor_edge_rot(y,4,i)=stor_edge_trans(y,2,i)*two_one_co+two_two;
    end
end
end
%Testing using only 0 and 90 degree samples
testpoints=zeros(y_rows,2,4);
for y=1:y_rows
    if stor_edge_axis(y,1,1)==0||stor_edge_axis(y,2,1)==0||stor_edge_axis(y,1,2)==0||stor_edge_axis(y,2,2)==0
        testpoints(end,:,:)=[];
    else
        testpoints(y,1,1)=stor_edge_rot(y,1,1);
        testpoints(y,2,1)=stor_edge_rot(y,3,2);
        testpoints(y,1,2)=stor_edge_rot(y,2,1);
        testpoints(y,2,2)=stor_edge_rot(y,3,2);
        testpoints(y,1,3)=stor_edge_rot(y,1,1);
        testpoints(y,2,3)=stor_edge_rot(y,4,2);
        testpoints(y,1,4)=stor_edge_rot(y,2,1);
        testpoints(y,2,4)=stor_edge_rot(y,4,2);
    end
end
end

