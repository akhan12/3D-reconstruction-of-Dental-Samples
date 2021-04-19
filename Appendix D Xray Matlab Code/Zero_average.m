function [ canal_format ] = Zero_average( canal_format,ninty,numr )
%gets rid of zeros
%ninty =2 specifies it is the ninty canal and 1 is the zero canal
for i=1:numr
    if canal_format(i,1,ninty)==0
        for j=(i-1):-1:1
            if canal_format(j,1,ninty)~=0
                canal_format(i,1,ninty)=canal_format(j,1,ninty);
                break;
            end
        end
        %if the search down didn't yield any results
        if canal_format(i,1,ninty)==0
            for k=(i+1):numr
                if canal_format(k,1,ninty)~=0
                    canal_format(i,1,ninty)=canal_format(k,1,ninty);
                   break;
                end
            end
        end
    end
    
    if canal_format(i,2,ninty)==0
        for j=(i-1):-1:1
            if canal_format(j,2,ninty)~=0
                canal_format(i,2,ninty)=canal_format(j,2,ninty);
                break;
            end
        end
        %if the search down didn't yield any results
        if canal_format(i,2,ninty)==0
            for k=(i+1):numr
                if canal_format(k,2,ninty)~=0
                    canal_format(i,2,ninty)=canal_format(k,2,ninty);
                   break;
                end
            end
        end
    end
end

end

