function [ image_rot,uninterpol ] = Manual_arb_rotate(image,theta,rot_point)
%Rotate image at an arbitrary point
% and also interpolate black values
%rot_point i got from plane_vector
[y, x]=size(image);
image_rot=zeros(y,x);
theta=-theta;
rotation=[cosd(theta) -sind(theta) 0;sind(theta) cosd(theta) 0;0 0 1];
%trans=[1 0 rot_point(1);0 1 rot_point(2);0 0 1];
%trans_neg=[1 0 -rot_point(1);0 1 -rot_point(2);0 0 1];
rot_trans=[1 0 rot_point(1);0 1 rot_point(2);0 0 1]*rotation*[1 0 -rot_point(1);0 1 -rot_point(2);0 0 1];

for i=1:y
    for j=1:x
        co=rot_trans*[j; i; 1];
        if co(1)<=x && co(1)>=1 && co(2)<=y && co(2)>=1
            co=round(co);
            image_rot(co(2),co(1))=image(i,j);
        end
    end
end
uninterpol=image_rot;
uninterpol=uint8(uninterpol);
%average of black pixels
%pad values
masksize=10;
padsz=masksize/2;
pad_image=padarray(image_rot,padsz,'replicate');
[py px]=size(pad_image);
for i=(padsz+1):(py-padsz)
    for j=(padsz+1):(px-padsz)
        if pad_image(i,j)==0
            row_index_l=i-padsz;
            row_index_h=i+padsz;
            column_index_l=j-padsz;
            column_index_h=j+padsz;
            conv_matrix=pad_image(row_index_l:row_index_h,column_index_l:column_index_h);
            conv_kernel=ones(11,11);
            conv_kernel(6,6)=0;
            interp_element=conv_matrix.*conv_kernel;
            interp_element=sum(interp_element);
            interp_element=sum(interp_element);
            pad_image(i,j)=interp_element/120;
            
        end
    end
end
pad_image=pad_image(:,padsz+1:end-padsz);
pad_image=pad_image(padsz+1:end-padsz,:);
image_rot=pad_image;
image_rot=uint8(image_rot);
end

