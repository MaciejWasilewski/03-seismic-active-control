function [results] = lqg_simulation(matACont,matBCont, matC, Q,R,dt,endT, quakeHandle, lqgRterm)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
object=ss(matACont,matBCont, matC,zeros(20,21));
[~,L,~]=kalman(object,0.000001*eye(21), 1*eye(20));
[K,~,~]=lqr(ss(matACont,matBCont(:,1:20), matC,zeros(20,20)), Q,lqgRterm*R);
Acl=[matACont, matBCont(:,1:20)*(-K);...
    L*matC, (matACont-matBCont(:,1:20)*K-L*matC)];
Bcl=[matBCont(:,21);matBCont(:,21)];
Ccl=[sqrtm(Q),zeros(60);zeros(20,60),sqrtm(R)*K];
Dcl=zeros(80,1);
clobject=ss(Acl,Bcl,Ccl,Dcl);
disp(['Gamma LQG (z=[Q^(1/2)x;R^(1/2)u): ', num2str(hinfnorm(clobject))]);
toClear_sys_discr=c2d(object,dt);
A_discr=toClear_sys_discr.A;
B_discr=toClear_sys_discr.B(:,1:20);
D_discr=toClear_sys_discr.B(:,21);
controller=discreteLQGController(A_discr,B_discr,matC, D_discr, Q,  lqgRterm*R,dt);

T=0:dt:endT;
[t_alg,state_alg, control_alg, J_alg, u_norm]=simulation(T,matACont,matBCont(:,1:end-1),matC,matBCont(:,end),Q,controller,quakeHandle);
results.time=t_alg;
results.state=state_alg;
results.control_signal=control_alg;
results.J=J_alg;
results.u_norm=u_norm;
results.name='LQG';
results.R=lqgRterm*R;
end

