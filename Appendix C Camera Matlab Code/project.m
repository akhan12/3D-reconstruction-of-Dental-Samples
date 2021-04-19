 line([-50 50],[400 400],[50 50])
line([-50 50],[400 400],[50 50])
line([-50 50],[400 400],[-50 -50])
line([50 50],[400 400],[-50 50])
line([-50 -50],[400 400],[-50 50])



line([-5 5],[390 390],[5 5])
line([-5 5],[390 390],[-5 -5])
line([-5 -5],[390 390],[-5 5])
line([5 5],[390 390],[-5 5])
ratio=200/390;

line([-5*ratio 5*ratio],[ratio*390 ratio*390],[5*ratio 5*ratio])
line([-5*ratio 5*ratio],[ratio*390 ratio*390],[-5*ratio -5*ratio])
line([-5*ratio -5*ratio],[ratio*390 ratio*390],[-5*ratio 5*ratio])
line([5*ratio 5*ratio],[ratio*390 ratio*390],[-5*ratio 5*ratio])
ratio=100/390;
line([-5*ratio 5*ratio],[ratio*390 ratio*390],[5*ratio 5*ratio])
line([-5*ratio 5*ratio],[ratio*390 ratio*390],[-5*ratio -5*ratio])
line([-5*ratio -5*ratio],[ratio*390 ratio*390],[-5*ratio 5*ratio])
line([5*ratio 5*ratio],[ratio*390 ratio*390],[-5*ratio 5*ratio])
%{
line([5 5],[380 380],[-5 5])
line([-5 -5],[380 380],[-5 5])
line([5 -5],[380 380],[5 5])
line([-5 5],[380 380],[5 5])
line([-5 5],[380 380],[-5 -5])
line([-5 -5],[380 390],[-5 -5])
line([-5 -5],[380 390],[5 5])
line([5 5],[380 390],[5 5])
line([5 5],[380 390],[-5 -5])
%}
ratio=400/390;
hold
line([-5*ratio 5*ratio],[ratio*390 ratio*390],[5*ratio 5*ratio],'color','green')
line([-5*ratio 5*ratio],[ratio*390 ratio*390],[-5*ratio -5*ratio],'color','green')
line([-5*ratio -5*ratio],[ratio*390 ratio*390],[-5*ratio 5*ratio],'color','green')
line([5*ratio 5*ratio],[ratio*390 ratio*390],[-5*ratio 5*ratio],'color','green')
plot3(-5*ratio,400,-5*ratio,'.','color','green');
plot3(5*ratio,400,-5*ratio,'.','color','green');
plot3(-5*ratio,400,5*ratio,'.','color','green');
plot3(5*ratio,400,5*ratio,'.','color','green');
line([0 ratio*5],[0 400],[0 ratio*5])
line([0 ratio*-5],[0 400],[0 ratio*-5])
line([0 ratio*-5],[0 400],[0 ratio*5])
line([0 ratio*5],[0 400],[0 ratio*-5])
axis equal