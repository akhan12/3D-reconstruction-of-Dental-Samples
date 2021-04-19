function newLinePlotter( Points)
%new line plotter using line function
[r,c]=size(Points);


for i=1:c
    if i<c
    line([Points(3,i),Points(3,i+1)],[Points(1,i),Points(1,i+1)],[Points(2,i),Points(2,i+1)])
    else
     line([Points(3,i),Points(3,1)],[Points(1,i),Points(1,1)],[Points(2,i),Points(2,1)]) 
    end
end


end

