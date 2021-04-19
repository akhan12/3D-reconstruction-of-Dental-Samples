function OutlinePlotter( points )
%Plot output of Outline Reconstruction
[y,~,n]=size(points);
for i=1:n
    plot(points(:,1,i),1:y);
    hold
    plot(points(:,2,i),1:y);
    plot(points(:,3,i),1:y);
    
    axis equal;
    if i<n
        figure;
    end
end

end

