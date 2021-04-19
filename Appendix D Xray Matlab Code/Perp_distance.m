function [ Distanc ] = Perp_distance( image,vslopeint,intercepts )
%Calculates perpendicular distance given a point and line
imshow(image);
zoom='no';
while strcmp(zoom,'no')
    zoom=input('Zoomed enough? ','s');
end
[x, y]=ginput(1);
%calculating perpendicular bisector
gradient=vslopeint(1);
gradient_perp=-1/gradient;
perp_intercept=y-(gradient_perp*x);

mat_coeff=[gradient -1;gradient_perp -1];
solutn=mat_coeff\[-intercepts(1);-perp_intercept];
vec=[x;y]-solutn;
Distanc=norm(vec);

end

