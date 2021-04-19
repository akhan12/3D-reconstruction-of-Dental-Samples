function [ canal_format ] = Singleton(outlier_z,canal_format,ninty,numr)
%ninty is 2 and zero is one
outlier_indiceszero=find(outlier_z);
[outrz,~]=size(outlier_indiceszero);
for i=1:outrz
    countdown=1;
    countup=1;
    %storing values to find average
    for j=outlier_indiceszero(i)-1:-1:1
        if canal_format(j,1,ninty)==0||canal_format(j,2,ninty)==0||(canal_format(j,1,ninty)==canal_format(j,2,ninty))
        else 
            countdownvals(countdown,1)=canal_format(j,1,ninty);
            countdownvals(countdown,2)=canal_format(j,2,ninty);
            countdown=countdown+1;
        end
    end
    
    for k=outlier_indiceszero(i)+1:numr
        if canal_format(k,1,ninty)==0||canal_format(k,2,ninty)==0
        else
            countupvals(countup,1)=canal_format(k,1,ninty);
            countupvals(countup,2)=canal_format(k,2,ninty);
            countup=countup+1;
        end
    end
    %storing values to find averages above or no averages lol
    %incase old values are still present since the memory isn't
    %preallocated
    diff1=abs(countdownvals(1,1)-canal_format(outlier_indiceszero(i),1,ninty));
    diff2=abs(countdownvals(1,2)-canal_format(outlier_indiceszero(i),2,ninty));
    %checking differences to see which side singleton belongs
    if diff1>diff2
        canal_format(outlier_indiceszero(i),1,ninty)=countdownvals(1,1);
    else 
        canal_format(outlier_indiceszero(i),2,ninty)=countdownvals(1,2);
    end
    
    
    
    clear countdownvals countupvals
end
end

