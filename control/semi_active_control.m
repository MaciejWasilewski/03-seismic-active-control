%semi-active control of building
xall=zeros(1,3+40);
tic;
le=size(xall,1);
for i=1:1:le
    x0=2*rand(40,1)-1;
    x0=x0/norm(x0);
    P=lyap((A+sum(B,3))', Q);
    [t0, y0]=ode45(@(t, y)passive(t, y, A, B, Q), [0, 50], [x0;0]);
    [t2, y2]=ode45(@(t, y)semi_active(t, y, A, B, Q,P), [0, 50], [x0;0]);
    [t1, y1]=ode45(@(t, y)semi_active(t, y, A, B, Q,Q), [0, 50], [x0;0]);
    disp((le-i)*toc/i);
    xall(i, :)=[x0',y0(end, end), y1(end, end), y2(end, end)];
end
function dydt=passive(t, y, A, B, Q)
y2=y(1:end-1);
dydt=[(A+sum(B,3))*y2;y2'*Q*y2];
end

function dydt=semi_active(t, y, A, B, Q, P)
y2=y(1:end-1);
B2=zeros(40,40,19);
for i=1:1:size(B,3)
    B2(:,:,i)=-sign(y2'*P*B(:,:,i)*y2)*B(:,:,i);
end
dydt=[(A+sum(B2,3))*y2;y2'*Q*y2];
end
