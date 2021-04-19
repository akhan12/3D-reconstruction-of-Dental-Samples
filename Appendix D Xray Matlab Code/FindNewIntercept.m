function [ cropintercept,middleright ] = FindNewIntercept( image,vslopeint,intercepts )
%finds the new intercept of cropped image using the same gradient
zoom='no';
imshow(image)
while strcmp(zoom,'no')
    zoom=input('Is it zoom enough? ','s');
end
[x,y]=ginput(1)
cropintercept=y-(vslopeint(1)*x);
differ=cropintercept-vslopeint(2);
middleright=intercepts+[differ,differ];
end

