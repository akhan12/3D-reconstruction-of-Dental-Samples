function  Surf_Plotter( lines )
[r,c]=size(lines);
x=zeros(1,c);
y=zeros(1,c);
z=zeros(1,c);
for i=1:c
    x(i)=lines(1,i);
    y(i)=lines(2,i);
    z(i)=lines(3,i);
end
plot3(x,y,z)

end

