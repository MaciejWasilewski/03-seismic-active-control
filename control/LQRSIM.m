tempdt=0.01;
elCentroCont=@(t)interp1(elCentroData(1, :), elCentroData(2, :), t, 'spline',0);
[A_d, B_d, D_d]=contToDiscr(A, B(:, 1:20), B(:, 21), tempdt);
% Q=1/2*[K, zeros(20,40);zeros(20),M,zeros(20);zeros(20,60)];
% R=4*eye(20);
KDLQR=dlqr(A_d, B_d, Q, R);
[~,Ld,~]=kalman(ss(A_d,[B_d,D_d],C,zeros(20,21),-1),0.0000001*eye(21), 1*eye(20));
tempT_end=6;
t=0:tempdt:tempT_end;
tempimax=length(t);

yLQR=zeros(60,tempimax);
uLQR=zeros(20,tempimax);
figure;
ykalLQR=zeros(60, tempimax);
for tempi=2:1:tempimax
    [~,tempytemp]=ode45(@(t,x)(A*x+B*[uLQR(:,tempi-1);elCentroCont(t)]),[t(tempi-1),t(tempi)],yLQR(:,tempi-1));
    yLQR(:,tempi)=(tempytemp(end,:))';
    ykalLQR(:,tempi)=A_d*ykalLQR(:,tempi-1)+D_d*elCentroCont(t(tempi-1))+B_d*uLQR(:,tempi-1)+Ld*(C*yLQR(:,tempi-1)-C*ykalLQR(:,tempi-1));
    
    if mod(tempi,50)==0
        disp(t(tempi));
    end
    tempuLQRt=-KDLQR*ykalLQR(:,tempi);
    uLQR(:,tempi)=tempuLQRt;
    plot(t(1:tempi), yLQR([1,10,20],1:tempi));
    drawnow;
end
clear -regexp ^temp