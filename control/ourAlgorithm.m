f=figure;
tempdt=0.01;
elCentroCont=@(t)interp1(elCentroData(1, :), elCentroData(2, :), t, 'spline',0);
[A_d, B_d, D_d]=contToDiscr(A, B(:, 1:20), B(:, 21), tempdt);
% Q=1/2*[K, zeros(20,40);zeros(20),M,zeros(20);zeros(20,60)];
% R=5000000*eye(20);
KDLQR=dlqr(A_d, B_d, Q, R);
tempn=9;
tempQ2=zeros(size(Q)+[tempn, tempn]);
tempQ2(1:size(Q, 1),1:size(Q, 1))=Q;
B2d=[B_d;zeros(tempn,size(B_d,2))];
tempT_end=6;
t=0:tempdt:tempT_end;
tempN=750;
tempimax=length(t);
tempdistrb=interp1(elCentroData(1,:),elCentroData(2,:),t,'spline',0);
[~,Ld,~]=kalman(ss(A_d,[B_d,D_d],C,zeros(20,21),-1),0.0000001*eye(21), 1*eye(20));
tempS=35;
y=zeros(60,tempimax);
u=zeros(20,tempimax);
ykal=zeros(60,1);
tempKAlg=[KDLQR,zeros(size(B_d,2),tempn)];
for i=2:1:length(t)
    [~,tempytemp]=ode45(@(t,x)(A*x+B*[u(:,i-1);elCentroCont(t)]),[t(i-1),t(i)],y(:,i-1));
    ykal=A_d*ykal+D_d*elCentroCont(t(i-1))+B_d*u(:,i-1)+Ld*(C*y(:,i-1)-C*ykal);
% [~,ytemp]=ode45(@(t,x)(Akalm*x+BKalm*[zeros(20,1);elCentroCont(t)]),[t(i-1),t(i)],y(:,i-1));
    y(:,i)=(tempytemp(end,:))';
    if mod(i,100)==0
        disp(t(i));
    end
    tempmeasDist=tempdistrb(max(1,i-tempN+1):i)';
    if i<=tempS
        tempuAlgt=-KDLQR*ykal;
    else
        if mod(i,6)==0
            tempG=AR( tempmeasDist', tempn);
%             disp('G');
%             disp(G);
            tempmaxeig=max(abs(eigs(tempG)));
            tempmaxeig2=max(1,tempmaxeig*1.01);
            tempA_2=[A_d, D_d*[zeros(size(D_d,2),tempn-1),eye(size(D_d,2))];zeros(tempn,size(A_d,1)),tempG];
            [~,~,tempKAlg,tempflag]=dare(1/(tempmaxeig2)*tempA_2,1/(tempmaxeig2)*B2d,tempQ2,R,[],[]);
            while tempflag<0
                disp(tempflag);
                disp(tempmaxeig);
                disp(tempmaxeig2);
                tempmaxeig2=tempmaxeig2*1.01;
                [~,~,tempKAlg,tempflag]=dare(1/(tempmaxeig2)*tempA_2,1/(tempmaxeig2)*B2d,tempQ2,R,[],[]);
            end
            
        end
        tempdistrState=[tempmeasDist(max(1,length(tempmeasDist)-tempn+1):end);zeros(max(0,tempn-length(tempmeasDist)),1)];
        tempuAlgt=-tempKAlg*[ykal;tempdistrState];
    end
    u(:,i)=tempuAlgt;
    figure(f);
    plot(t(1:i), y(1:20,1:i));
    drawnow;
end
clear -regexp ^temp