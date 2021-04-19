function ply_write( file_name,points)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fname=strcat(file_name,'.ply');
fileId=fopen(fname,'w');
fprintf(fileId,'ply\n');
fprintf(fileId,'format ascii 1.0\n');
sz=size(points);
fprintf(fileId,'element vertex %d\n',sz(2));
fprintf(fileId,'property float x\nproperty float y\nproperty float z\nelement face %d\nproperty list uchar int vertex_index\nend_header\n',0);
for i=1:sz(2)
    fprintf(fileId,'%f %f %f\n',points(1,i),points(2,i),points(3,i));
end

fclose(fileId);
end

