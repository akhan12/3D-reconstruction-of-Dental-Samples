function line_image_threshold(image)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
imshow(image,'InitialMagnification',100);
[y, x]=size(image);

hold
line([0 x],[25 25]);
hold
line([0 x],[790 790]);
hold
line([0 x],[217 217]);
end