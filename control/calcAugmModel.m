n=5;
%         A_2=[A_d,B_ed*[zeros(1,n-1),1];zeros(n,size(A_d,1)),G];
B_2=[B_d;zeros(n,1)];
Q_2=zeros(size(Q,1)+n);
Q_2(1:size(Q,1),1:size(Q,1))=Q;
%         [K_d,~,~]=dlqr(A_2,B_2,Q_2,10^(-4),[]);
K_const=dlqr(A_d,B_d,Q,10^(-4),[]);
% y_0=zeros(43,1);
y_2=zeros(imax,40+n);
y_van=zeros(imax,40);
T_end=100;
dt=0.02;
t=0:dt:T_end;
imax=length(t);
distrb=zeros(imax,1);
for i=1:1:imax
    distrb(i,1)=elCentroData(2,min(i,size(elCentroData,2)));
end
% distrb=(elCentroData(2,:))';
N=17;
S=45;
for i=2:1:imax
    %             disp(i);
    ytemp=(y_2(i-1,:))';
    G=AR( distrb(max(1,i-N):i)', n);
    %     disp(G);
    A_2=[A_d,B_ed*[zeros(1,n-1),1];zeros(n,size(A_d,1)),G];
    %     [K_d,~,~]=dlqr(A_2,B_2,Q_2,10^(-4),[]);
    K_d=lqr_discr_finite(A_2,B_2,Q_2,10^(-4),S);
    u=-K_d*ytemp;
    if i<N
        u=-K_const*ytemp(1:40);
    end
    ytemp2=zeros(40+n,1);
    ytemp2(1:40)=A_d*ytemp(1:40)+B_d*u+B_ed*distrb(i,1);
    %     (A_2-B_2*K_d)*ytemp;
    
    ytemp2(end-n+1:end)=zeros(n,1);
    f=distrb(max(1,i-n+1):i);
    ytemp2(end-length(f)+1:end)=f;
    y_2(i,:)=ytemp2';
    y_van(i,:)=((A_d-B_d*K_const)*(y_van(i-1,:))'+B_ed*distrb(i,1))';
    
end

plot(t,y_van(:,[1,10,20]),'-b',t,y_2(:,[1,10,20]),'-r');

Ja=costFunction(t,y_2(:,1:40),Q);
Javan=costFunction(t,y_van(:,1:40),Q);
Ja/Javan