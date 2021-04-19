function Rotated_Points = Recurs(Ordered_List,Coordinates_List,Image_Pair,Points)
%Recurs is a function which finds the rotated points recursively
% ordered_list is a nxk matrix where n is the number of image pairs
% k is the maximum number of points (number of visible points + 
% (max points - number of visible points)
%Coorindates_list is the calibration coordinates nxkx3 same order as
%Ordered_list
%Image_Pair is which image pair that is being rotated
%Points is the points that need to be rotated
%check for duplicate amount of matches?

[~, clm]=size(Ordered_List);
Num_Matches=zeros(1,Image_Pair-1);
for i=Image_Pair-1:-1:1
    for j=1:clm
        chk_elem=Ordered_List(Image_Pair,j);
        for m=1:clm
            elem=Ordered_List(i,m);
            if chk_elem==0 || elem==0
            elseif chk_elem==elem
                Num_Matches(i)=Num_Matches(i)+1;
            end
        end
    end
end
[nmatches, ind]=max(Num_Matches);
%matrix of calibration points that are to be rotated, they are not
%reordered
ind
mat_calib1=Ordered_List(Image_Pair,:);
mat_calib2=Ordered_List(ind,:);
mat_coordin1=Coordinates_List(Image_Pair,:,:);
mat_coordin1=[mat_coordin1(:,:,1);mat_coordin1(:,:,2);mat_coordin1(:,:,3)];

mat_coordin2=Coordinates_List(ind,:,:);
mat_coordin2=[mat_coordin2(:,:,1);mat_coordin2(:,:,2);mat_coordin2(:,:,3)];
fmat_coordin1=zeros(3,nmatches);
fmat_coordin2=zeros(3,nmatches);
b=1;

    for j=1:clm
        mc1=mat_calib1(j);
        for m=1:clm
            mc2=mat_calib2(m);
            if mc1==0 || mc2==0
            elseif mc1==mc2
                fmat_coordin1(:,b)=mat_coordin1(:,j);
                fmat_coordin2(:,b)=mat_coordin2(:,m);
                b=b+1;
            end
        end
    end
%note in this case fmat1 is the points to be rotated and fmat2 is the
%reference points
fmat_coordin1;
fmat_coordin2;
newPoints=Numerical_Rotation(fmat_coordin2,[fmat_coordin1,Points],nmatches,ind);

%delete fmat from newpoints
for i=1:nmatches
    
    newPoints(:,1)=[];
end
if ind~=1
Rotated_Points=Recurs(Ordered_List,Coordinates_List,ind,newPoints);
    
else 
    Rotated_Points=newPoints;
end
end

