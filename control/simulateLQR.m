K=lqr(A,B,Q,R);
C=eye(40);
% C=C([1,10,20],:);
% sys_cont=ss(A,[B20,D],C,zeros([3,2]));
sC=size(C,1);
[~,L,~] = kalman(ss(A,[B,D],C,zeros([sC,21])),std(elCentroData(2,:))^2,eye(sC)*0.01,zeros([1,sC]));
[~,L2,~] = kalman(ss(A,[B,D,eye(40)],C,zeros([sC,61])),eye(40)*1,eye(sC)*0.01,zeros([1,sC]));
[tlqg,ylqg]=ode45(@(t,x)([A, -B*K;L*C,A-B*K-L*C]*x+[D;zeros(size(D))]*elCentroData(2,min([2502,floor(t/0.02)+1]))),[0,100],zeros(80,1));
[tlqg2,ylqg2]=ode45(@(t,x)([A, -B*K;L2*C,A-B*K-L2*C]*x+[D;D]*elCentroData(2,min([2502,floor(t/0.02)+1]))),[0,100],zeros(80,1));
[tvan,yvan]=ode45(@(t,x)((A)*x+D*elCentroData(2,min([2502,floor(t/0.02)+1]))),[0,100],zeros(40,1));
% [toptim2,yoptim2]=ode45(@(t,x)((A)*x+B*u_opt(:,floor(t/0.02)+1)),[0,100-0.02],zeros(40,1));
to=0:T/N:T*(1-1/N);
[toptim,yoptim]=ode45(@(t,x)((A)*x+B*(interp1(to,u_opt2',t,'nearest',0))'+D*elCentroData(2,min([2502,floor(t/0.02)+1]))),[0,100-0.02],zeros(40,1));
[tlqr,ylqr]=ode45(@(t,x)((A-B*K)*x+D*elCentroData(2,min([2502,floor(t/0.02)+1]))),[0,100],zeros(40,1));
% [tlqg,ylqg]=ode45(@(t,x)([A, zeros(size(A));L*C,(A-L*C)]*x+[B;B]*(-K*x(41:80))+[D;zeros(size(D))]*elCentroData(2,min([2502,floor(t/0.02)+1]))),[0,100],zeros(80,1));
[Jvan,tJvan]=costFunction(tvan,yvan,Q);
[Jlqr,tJlqr]=costFunction(tlqr,ylqr,Q);
[Jlqg,tJlqg]=costFunction(tlqg,ylqg(:,1:40),Q);
uLQG=-K*(ylqg(:,41:80))';
uLQR=-K*ylqr';
[Jopt,tJopt]=costFunction(toptim,yoptim(:,1:40),Q);
% subplot(2,1,1);
% plot(tvan,yvan(:,[1,10,20]),'-b',tlqr,ylqr(:,[1,10,20]),'-r',tlqg,ylqg(:,[1,10,20]),'-g');
% subplot(2,1,2);
% plot(tlqr,min(897*10^3*ones(size(ylqr,1),1),max(-897*10^3*ones(size(ylqr,1),1),-ylqr*K')));