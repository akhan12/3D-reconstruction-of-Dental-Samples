function M= Animat( trans,rot )
%function that animates the rotation 
[y_rows,~,n_images]=size(trans);
k=1;
for i=4:4
    for y=1:300
        %plot(trans(y,1,i),trans(y,3,i),'.',trans(y,2,i),trans(y,4,i),'.',rot(y,1,i),rot(y,3,i),'.',rot(y,2,i),rot(y,4,i),'.');
        plot(rot(y,1,i),rot(y,3,i),'.',rot(y,2,i),rot(y,4,i),'.');
        axis equal
        (rot(y,4,i)-rot(y,3,i))/(rot(y,2,i)-rot(y,1,i));
        -1/ans
        M(k)=getframe;
        k=k+1;
    end
    
end


end

