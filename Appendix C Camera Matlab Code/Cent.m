function [ center normal ] = Cent( points )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%compute vectors where first point is reference points
vec1=points(:,2)-points(:,1);
vec2=points(:,3)-points(:,1);
normal=cross(vec1,vec2);

%caculate midpoints
midpoint1=(vec1./2)+points(:,1);
midpoint2=(vec2./2)+points(:,1);

%find rotation and translation rotate points as indicated in notes
%note: i don't know how axelrot calculates the translation, but it
%apparently calculates the correct rotation further investigation to be
%done
[rot1,trans1]=AxelRot(90,normal,midpoint1);
trans1=midpoint1;
temp1=points(:,1)-trans1;
temp1=rot1*temp1;
temp1=temp1+trans1;

[rot2,trans2]=AxelRot(90,normal,midpoint2);
trans2=midpoint2;
temp2=points(:,1)-trans2;
temp2=rot2*temp2;
temp2=temp2+trans2;

%find the vector for line 1
perp_line_1=temp1-midpoint1;
perp_line_2=temp2-midpoint2;

%setting up simultaneous equations
right_hand=midpoint2-midpoint1;
coeff=[perp_line_1(1),-perp_line_2(1);perp_line_1(2),-perp_line_2(2)];

tv=(inv(coeff))*[right_hand(1);right_hand(2)];
midpoint1+(tv(1).*perp_line_1)
center=midpoint2+(tv(2).*perp_line_2);
end

