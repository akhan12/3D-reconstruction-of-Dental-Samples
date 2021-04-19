function [x,y,slopeint,vec] = plane_vector( image )
%% calculate the vectors of the circuit planes
imshow(image);
zoom='no';
while strcmp(zoom,'no')
   zoom= input('Is it zoomed enough? ','s');
    
end
[x,y]=ginput(10);
slopeint=polyfit(x,y,1);
vec=[1,slopeint(1)];
vec=vec/norm(vec);
line_image(image,slopeint)
end
