function  Xray_Ply_inner( xpoints,ypoints,file_name,starting )
%x ray ply writer
%introduce limits to deal with canal
fname=strcat(file_name,'.ply');
fileId=fopen(fname,'w');
fprintf(fileId,'ply\n');
fprintf(fileId,'format ascii 1.0\n');
[rows, columns]=size(xpoints);
sz=0;
intervals=5;
for i=1:intervals:rows
    sz=sz+1;
end
sz=sz*columns;
%sz=rows*columns;
fprintf(fileId,'element vertex %d\n',sz);
fprintf(fileId,'property float x\nproperty float y\nproperty float z\nelement face %d\nproperty list uchar int vertex_index\nend_header\n',0);
%another part of ply_writer
for i=1:intervals:rows
  
    for j=1:columns
        fprintf(fileId,'%f %f %f\n',xpoints(i,j),i+starting,ypoints(i,j));
    end
end
fclose(fileId);
end

