toClear_sys_discr=c2d(ss(matACont,matBCont, matC,zeros(20,21)),dt);
A_discr=toClear_sys_discr.A;
B_discr=toClear_sys_discr.B(:,1:20);
D_discr=toClear_sys_discr.B(:,21);
% controller=adaptiveController(A_discr,B_discr,matC, D_discr, Q, R,n,N,min_N, dt);
% controller=discreteLQGController(A_discr,B_discr,matC, D_discr, Q, R,dt);
controller=hInfController(matACont,matBCont(:,1:20),matC, matBCont(:,21), Q, dt);
toClear_t_quake=kobe(1,:);
toClear_quake=kobe(2,:);
quakeHandle=@(t)(interp1(toClear_t_quake, toClear_quake, t,'linear',0));
% quakeHandle=@(t)(sin(2*pi*0.205*t).*heaviside(20-t));
T=0:dt:30;
figure;
subplot(2,2,1);
plot(T,quakeHandle(T));
ylabel('Signal');
[t_alg,state_alg, control_alg, J_alg, u_norm]=simulation(T,matACont,matBCont(:,1:end-1),matC,matBCont(:,end),Q,controller,quakeHandle);
subplot(2,2,2);
plot(t_alg, state_alg(:,[1,10,20]));
ylabel('Deflections');
subplot(2,2,3);
plot(control_alg(:,1), vecnorm(control_alg(:,2:end)')');
ylabel('||u||2');
subplot(2,2,4);
plot(t_alg, J_alg);
ylabel('J');
max_force=max(max(abs(state_alg(:,41:60)/6)));
disp(['Maximal force generated by actuators: ',num2str(max_force)]);
disp(['Performance criterion xQx: ', num2str(J_alg(end))]);
disp(['Performance criterion uu: ',num2str(u_norm)]);
clear -regexp ^toClear_;