function   Arbitrary_Axis_PLot
%Wikipedia
%phi is theta in this function and theta is phi
figure
hold
plot3(1,1,0,'.');
for theta=0:90:359.9999
    
    for phi=0:30:90
        x=sind(phi)*cosd(theta);
        y=sind(phi)*sind(theta);
        z=cosd(phi);
        rot_vec=[x,y,z];
        norm(rot_vec);
        if phi~=90
        quiver3(1,1,1,x,y,z);
        elseif theta<180 &&theta>=0
            quiver3(1,1,1,x,y,z);
        end
        grid on
    end
end
axis equal
end

