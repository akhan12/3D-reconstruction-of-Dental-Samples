function [Rotpoints,error,err_euclid] = NumericalRotation_General(Ref_points,PointstRotate,index)
%General Numerical Rotation regardless of the axis of rotation
%ref points is the points that will be referenced, pointsrotate is the
%points that are to be rotated into ref_points coordinate frame
% index is the index of the ref_points and the corresponding points in
% PointsRotate
%format index: top row index of Ref_points
%bottom row index of corresponding PointsRotate
[~,nmatchpoints]=size(index);

%first translation is too align the points
vec1=Ref_points(:,index(1,1));
vec2=PointstRotate(:,index(2,1));
vect=vec1-vec2;
[~,szptrot]=size(PointstRotate);
temp=zeros(3,szptrot);
for i=1:szptrot
    temp(:,i)=vect;
end
%first Translation vector
fTranslate=temp+PointstRotate;
origin=vec1;

%second translation to origin
for i=1:szptrot
    temp(:,i)=origin;
end
%second translation variable
secTrns=fTranslate-temp;
%initializing error variables
[~,szref]=size(Ref_points);
tempref=zeros(3,szref);
for i=1:szref
    tempref(:,i)=vec1;
end
er_refpts=Ref_points-tempref;
smallest_err=9999999999999;
best_rot=zeros(3,szptrot);
current_error=zeros(3,(nmatchpoints-1));
err_euclid_current=zeros(3,(nmatchpoints-1));
err_euclid=0;
%rotation and error checking
for theta=80:1:100
    
    for phi=35:1:50
        x=sind(phi)*cosd(theta);
        y=sind(phi)*sind(theta);
        z=cosd(phi);
        rot_vec=[x,y,z];
        for deg=130:1:150
        [rot,~]=AxelRot(deg,rot_vec,[0,0,0]);
        rot_temp=rot*secTrns;
        %error caculationg loop
        for i=2:nmatchpoints
            current_error(:,i-1)=rot_temp(:,index(2,i))-er_refpts(:,index(1,i));
            %eulidean error
            
            %err_euclid_current=current_error;
            %err_euclid_current(:,1)=[];
            %err_euclid_current=err_euclid_current.^2;
            %err_euclid_current=sum(err_euclid_current,1);
            %err_euclid_current=sqrt(err_euclid_current);
            
            %total_euclid=sum(err_euclid_current);
            
            
            %euclidean error
            
            test_r(:,i)=rot_temp(:,index(2,i));
            test_ref(:,i)=er_refpts(:,index(1,i));
        end
            %euclid
            err_euclid_current=current_error.^2;
            err_euclid_current=sum(err_euclid_current,1);
            err_euclid_current=sqrt(err_euclid_current);
            
            total_euclid=sum(err_euclid_current);
            %euclid
            average=sum(abs(current_error),1);
            average=sum(average)/(nmatchpoints-1);
            if average<smallest_err
                theta
                phi
                deg
                err_euclid=total_euclid
                smallest_err=average;
                best_rot=rot_temp;
                error=smallest_err
                
            
            end
        end
    end
end
Rotpoints=best_rot+temp;
end

