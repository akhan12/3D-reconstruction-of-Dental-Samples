function [ angles ] = vector_angle_calcnew( vec )
%calculates the vectors given points
%also the angles with the first vector
[row,~]=size(vec);

for i=1:row
    angles(i)=acosd(dot([1 0],vec(i,:)));
    if 0>vec(i,2)
        angles(i)=-angles(i);
    end

end

end

