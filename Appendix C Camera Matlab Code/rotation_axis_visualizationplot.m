function rotation_axis_visualizationplot
for theta=0:45:360
    pause(3)
    for phi=0:15:90
    
		
        x=sind(phi)*cosd(theta);
        y=sind(phi)*sind(theta);
        z=cosd(phi);
        rot_vec=[x,y,z];
      
        quiver3(0,0,0,z,x,y)
		hold on
    end
end

end 