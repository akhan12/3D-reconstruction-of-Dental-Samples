function [ imagetranslated ] = TranslateIM( image,slopeintref,slopeint)
%Translation in order to align the base lines

[y, x]=size(image);
imagetranslated=zeros(y,x);
ty=-round(slopeint(2)-slopeintref(2));
trans=[1 0 0;0 1 ty;0 0 1];


for i=1:y
    for j=1:x
        co=trans*[j; i; 1];
        if co(1)<=x && co(1)>=1 && co(2)<=y && co(2)>=1
            %co=round(co);
            imagetranslated(co(2),co(1))=image(i,j);
        end
    end
end
imagetranslated=uint8(imagetranslated);
end

