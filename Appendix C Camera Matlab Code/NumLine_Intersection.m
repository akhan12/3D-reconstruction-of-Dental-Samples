function [ numeri,analytical,err,avg ] = NumLine_Intersection(limit1,limit2,ptsperline,ptscurve,plt)
%num points is the number of lines
%the format of the line would be that each row of the line is for a
%particular line


numpts=25;
x_r_freehand=linspace(limit1,limit2,ptscurve);
y_r_freehand=x_r_freehand.^2;
if plt==1
plot(x_r_freehand,y_r_freehand);
hold
end
linex=zeros(numpts,ptsperline);
liney=zeros(numpts,ptsperline);

m=-6;
c=5;
syms x
x_analytical=zeros(numpts,1);
y_analytical=zeros(numpts,1);
y_li=zeros(numpts,1);
for i=1:numpts
al=x.^2-(m*x)-(i*c);
solution=double(solve(al));
solution=max(solution);
x_analytical(i)=solution;
y_analytical(i)=solution.^2;
y_li(i)=m*solution+(i*c);
linex(i,:)=linspace(limit1,limit2,ptsperline);
liney(i,:)=(m*linex(i,:))+(i*c);
if plt==1
plot(linex(i,:),liney(i,:))
end
end
analytical=[x_analytical,y_analytical,y_li];


numvals=length(x_r_freehand);
x_r=zeros(numpts,1);
y_r=zeros(numpts,1);
euclid=zeros(1,numvals);
smll_euclid=zeros(ptsperline,2);

%numerical find the intersection of the line and freehand
for i=1:numpts
    for j=1:ptsperline
        for k=1:numvals
            euclid(k)=norm(([linex(i,j),liney(i,j)]-[x_r_freehand(k),y_r_freehand(k)]));
        end
      [va,ind]=  min(euclid);
      smll_euclid(j,:)=[va,ind];
    end
  [~,ind]=min(smll_euclid(:,1));
  x_r(i)=x_r_freehand(smll_euclid(ind,2));
  y_r(i)=y_r_freehand(smll_euclid(ind,2));
end
numeri=[x_r,y_r];
err=analytical(:,1:2)-numeri;
avg=abs(err);
avg=sum(avg,1);
avg=avg/numpts;
end

