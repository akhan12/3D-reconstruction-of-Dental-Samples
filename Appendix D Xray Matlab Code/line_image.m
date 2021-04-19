function line_image(image,slopeint )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[~,endx]=size(image);
y1=slopeint(2);
y2=(endx*slopeint(1))+slopeint(2);
imshow(image);
hold
line([0 endx],[y1 y2]);

end

