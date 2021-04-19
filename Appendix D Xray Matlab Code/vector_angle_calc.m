function [ angles ] = vector_angle_calc( vec )
%calculates the vectors given points
%also the angles with the first vector
[row,~]=size(vec);

for i=2:row
    
    angles(i-1)=acosd(dot(vec(1,:),vec(i,:)));
    %because of ambiguity and establishing a convention
    if vec(1,2)>vec(i,2)
        angles(i-1)=-angles(i-1);
    end

end

end

