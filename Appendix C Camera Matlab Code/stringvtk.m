function [ stringv ] = stringvtk( XYZ )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[~,numpts]=size(XYZ);
for i=1:numpts
    if i==1
        stringv='{';
    end
    s =sprintf('{%0.5f,%0.5f,%0.5f},',XYZ(1,i),XYZ(2,i),XYZ(3,i));
     if i==numpts
         s =sprintf('{%0.5f,%0.5f,%0.5f}}',XYZ(1,i),XYZ(2,i),XYZ(3,i));
         stringv=strcat(stringv,s);
     else stringv=strcat(stringv,s);
    end
    
   
end

end

