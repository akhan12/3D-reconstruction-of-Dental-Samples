[x,y,z] = cylinder(5,10000);

plot(x(1,:),y(1,:))
axis equal
y=-5:0.001:5;
size(y)
x=(zeros(size(y)));
hold on
plot(x,y)
plot(y,x)
plot(5*ones(size(y)),y)

plot(y,5*ones(size(y)))
plot(y,-5*ones(size(y)))
plot(-5*ones(size(y)),y)
[xpos,ypos,~]=line_adam([6;6;0],[-6;-6;0]);
plot(xpos,ypos)
plot(xpos,-ypos)

plot(xpos+(5*cosd(45)*ones(size(xpos))),ypos+(5*cosd(45)*ones(size(xpos))))
plot(xpos+(5*cosd(45)*ones(size(xpos))),-ypos+(5*cosd(45)*ones(size(xpos))))
plot(xpos+(-5*cosd(45)*ones(size(xpos))),-ypos+(-5*cosd(45)*ones(size(xpos))))
plot(xpos+(-5*cosd(45)*ones(size(xpos))),ypos+(5*cosd(45)*ones(size(xpos))))
plot(xpos+(5*cosd(45)*ones(size(xpos))),ypos+(-5*cosd(45)*ones(size(xpos))))




[x30,y30,~]=line_adam([6*cosd(30);6*sind(30);0],[-6*cosd(30);-6*sind(30);0]);
plot(x30,y30)
[x60,y60,~]=line_adam([6*cosd(60);6*sind(60);0],[-6*cosd(60);-6*sind(60);0]);
plot(x60,y60)
plot(-x60,y60)
plot(-x30,y30)
plot(-x60+5*cosd(30)*ones(size(x60)),y60+5*sind(30)*ones(size(x60)))
plot(-x60-5*cosd(30)*ones(size(x60)),y60-5*sind(30)*ones(size(x60)))
plot(-x30+5*cosd(60)*ones(size(x60)),y30+5*sind(60)*ones(size(x60)))
plot(-x30-5*cosd(60)*ones(size(x60)),y30-5*sind(60)*ones(size(x60)))

plot(x30-5*cosd(60)*ones(size(x60)),y30+5*sind(60)*ones(size(x60)))
plot(x30+5*cosd(60)*ones(size(x60)),y30-5*sind(60)*ones(size(x60)))

plot(x60-5*cosd(30)*ones(size(x60)),y60+5*sind(30)*ones(size(x60)))
plot(x60+5*cosd(30)*ones(size(x60)),y60-5*sind(30)*ones(size(x60)))

