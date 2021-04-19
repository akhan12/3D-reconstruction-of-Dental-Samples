function [ canal_format ] = Outlier_FinalStep( canal_format,ninty,numr)
%ninty ==2 determines ninty and 1 tells it it is zero
for i=1:numr
    %left side and right side individually
    cdown=1;
    cup=1;
    cdownvalues(1,:)=[9999,9999];
    cupvalues(1,:)=[9999,9999];
    for j=(i-1):-1:(i-3)
        if j>0
        cdownvalues(cdown,:)=canal_format(j,:,ninty);
        cdown=cdown+1;
        end
    end  
    for k=(i+1):(i+3)
        if k<numr+1
        cupvalues(cup,:)=canal_format(k,:,ninty);
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
    diff=abs(averages-canal_format(i,:,ninty));
    if diff(1)>=4
        canal_format(i,1,ninty)=canal_format(i-1,1,ninty);
    end
    
    if diff(2)>=4
        canal_format(i,2,ninty)=canal_format(i-1,2,ninty);
    end
    
    clear cdownvalues cupvalues 
end

end

