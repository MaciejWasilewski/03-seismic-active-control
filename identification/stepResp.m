[A,B1,B2,B3]=buildingModel([x11log(1)*ones(1,20),x11log(2)*ones(1,20),x11log(3)*ones(1,20)],b);

a=0.00000;
u1=1;
u2=0;
[t,y]=ode45(@(t,y)(A*y+B1*u1+B2*u2+B3*a),[0,125],zeros(40,1));