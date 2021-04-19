function [ intercep2 ] = bisector( image,vslopeint )
%finding the axis of rotation
%use plane vector to find vslopeint of the left side
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
solutn=mat_coeff\[-vslopeint(2);-perp_intercept];
midpoint=0.5*([x;y]+solutn);

intercep2=zeros(1,2);
intercep2(1)=midpoint(2)-(gradient*midpoint(1));
%drawing lines for illustration
y1=vslopeint(2);
y2=(876*vslopeint(1))+vslopeint(2);
imshow(image);
hold
line([0 876],[y1 y2]);
hold;
%calculating rightmost line
r_intercept=y-(gradient*x);
intercep2(2)=r_intercept;
y1=r_intercept;
y2=(876*vslopeint(1))+r_intercept;
line([0 876],[y1 y2]);
%plotting middle line
y1=intercep2(1);
y2=(876*vslopeint(1))+intercep2(1);
line([0 876],[y1 y2]);
end

