function [ canal_format,canal_format3d ] = InnerReconstruction( canalzero,canalninty,gradintercepts,angles )
%Function that calculates the points of the canal
% It has to round the values of and sort it before
%217 and 790 and 574 values
% y values go from 217-25+1 i.e 193 to 193+574-1
%[size_rows,~]=size(canal);

%y_limits of incisor is 76 and 770
%Y inner limits is 234 and 770 of incisor
% which leads to 
ylim=[234 770];
numr=abs(ylim(2)-ylim(1))+1;
canal_zround=round(canalzero);
canal_nround=round(canalninty);
canal_format=zeros(numr,2,2);

%initialize outlier matrices
outlier_z=zeros(numr,1);
outlier_n=zeros(numr,1);
for i=ylim(1):ylim(2)
    %remember to deal with zero handling
    index_zero=find(canal_zround(:,2)==i);
    index_ninty=find(canal_nround(:,2)==i);
    %put them into canal_format
    %first by putting all the indexed values into a matrix
    %then sorting that matrix 2 find the minimum and maximum
    sz_z=size(index_zero);
    sz_nin=size(index_ninty);
    temp_z=zeros(sz_z(1),1);
    temp_nin=zeros(sz_nin(1),1);
    
    for inz=1:sz_z(1)
        temp_z(inz)=canal_zround(index_zero(inz),1);
    end
    for inn=1:sz_nin(1)
        temp_nin(inn)=canal_nround(index_ninty(inn),1);
    end
    %now finding minimum and maximmum values
    minz=min(temp_z);
    maxz=max(temp_z);
    minn=min(temp_nin);
    maxn=max(temp_nin);
    [tz,~]=size(minz);
    [tn,~]=size(minn);
    %check if nothing is found that is size wil be zero
    
    if tz~=0 && i~=ylim(1)
    canal_format(i-ylim(1),1,1)=minz;
    canal_format(i-ylim(1),2,1)=maxz;
    end
    
    if tn~=0 && i~=ylim(1)
    canal_format(i-ylim(1),1,2)=minn;
    canal_format(i-ylim(1),2,2)=maxn;
    end
    
    %dealing with outliers, determining which side they are to lie as well
    %as interpolating the other side of the matrix
    %can't do it in the main for loop so log the indices 
    if sz_z(1)==1
        outlier_z(i-ylim(1))=1;
    end
    
    if sz_nin(1)==1
        outlier_n(i-ylim(1))=1;
    end
    
end
size(canal_format)
%interpolating zeros, define outliers as the indices that only have one
%value and are on the wrong side
%note about find....if the matrix is a row matrix and nothing is found then
%it will be 1x0 and if it is a column vector it will be 0x1
%don't forget if the countdown yields no values such as if the indices is
%one and there is nothing below and if it is the last index and their is
%nothing above
outlier_indiceszero=find(outlier_z);
[outrz,~]=size(outlier_indiceszero);
for i=1:outrz
    countdown=1;
    countup=1;
    %storing values to find average
    for j=outlier_indiceszero(i)-1:-1:1
        if canal_format(j,1,1)==0||canal_format(j,2,1)==0||(canal_format(j,1,1)==canal_format(j,2,1))
        else 
            countdownvals(countdown,1)=canal_format(j,1,1);
            countdownvals(countdown,2)=canal_format(j,2,1);
            countdown=countdown+1;
        end
    end
    
    for k=outlier_indiceszero(i)+1:numr
        if canal_format(k,1,1)==0||canal_format(k,2,1)==0
        else
            countupvals(countup,1)=canal_format(k,1,1);
            countupvals(countup,2)=canal_format(k,2,1);
            countup=countup+1;
        end
    end
    %storing values to find averages above or no averages lol
    %incase old values are still present since the memory isn't
    %preallocated
    diff1=abs(countdownvals(1,1)-canal_format(outlier_indiceszero(i),1,1));
    diff2=abs(countdownvals(1,2)-canal_format(outlier_indiceszero(i),2,1));
    %checking differences to see which side singleton belongs
    if diff1>diff2
        canal_format(outlier_indiceszero(i),1,1)=countdownvals(1,1);
    else 
        canal_format(outlier_indiceszero(i),2,1)=countdownvals(1,2);
    end
    
    
    
    clear countdownvals countupvals
end
%place holder for the ninty canal version
%place holder for the ninty canal version
%place holder for the ninty canal version
%palce holder for the ninty canal version
%place holder for the ninty canal version

canal_format=Singleton(outlier_n,canal_format,2,numr);

for i=1:numr
    if canal_format(i,1,1)==0
        for j=(i-1):-1:1
            if canal_format(j,1,1)~=0
                canal_format(i,1,1)=canal_format(j,1,1);
                break;
            end
        end
        %if the search down didn't yield any results
        if canal_format(i,1,1)==0
            for k=(i+1):numr
                if canal_format(k,1,1)~=0
                    canal_format(i,1,1)=canal_format(k,1,1);
                   break;
                end
            end
        end
    end
    
    if canal_format(i,2,1)==0
        for j=(i-1):-1:1
            if canal_format(j,2,1)~=0
                canal_format(i,2,1)=canal_format(j,2,1);
                break;
            end
        end
        %if the search down didn't yield any results
        if canal_format(i,2,1)==0
            for k=(i+1):numr
                if canal_format(k,2,1)~=0
                    canal_format(i,2,1)=canal_format(k,2,1);
                   break;
                end
            end
        end
    end
end

canal_format=Zero_average(canal_format,2,numr);

%removing last set of outliers
%that is the bad ones that do not belong to the zero criteria neither the
%singletons

for i=1:numr
    %left side and right side individually
    cdown=1;
    cup=1;
    cdownvalues(1,:)=[9999,9999];
    cupvalues(1,:)=[9999,9999];
    for j=(i-1):-1:(i-3)
        if j>0
        cdownvalues(cdown,:)=canal_format(j,:,1);
        cdown=cdown+1;
        end
    end  
    for k=(i+1):(i+3)
        if k<numr+1
        cupvalues(cup,:)=canal_format(k,:,1);
        cup=cup+1;
        end
    end
    %calculating averages
    if cdownvalues(1,1)~=9999&&cupvalues(1,1)~=9999
    valuestotal=[cdownvalues;cupvalues];
    elseif cdownvalues(1,1)==9999
        valuestotal=cupvalues;
    elseif cupvalues(1,1)==9999
         valuestotal=cdownvalues;
    end
    [rows,~]=size(valuestotal);
    averages=sum(valuestotal,1)/rows;
    %using average to determine if value belongs
    diff=abs(averages-canal_format(i,:,1));
    if diff(1)>7 &&i~=1
        canal_format(i,1,1)=canal_format(i-1,1,1);
    end
    
    if diff(2)>7 &&i~=1
        canal_format(i,2,1)=canal_format(i-1,2,1);
    end
    
    clear cdownvalues cupvalues 
end


canal_format=Outlier_FinalStep(canal_format,2,numr);
%separate them like the outer one

[~,~,~,canal_format3d]=InnerReconstruction2(gradintercepts,angles,canal_format);
end

