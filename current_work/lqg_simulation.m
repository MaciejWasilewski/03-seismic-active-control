function [results] = lqg_simulation(matACont,matBCont, matC, Q,R,dt,endT, quakeHandle)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
toClear_sys_discr=c2d(ss(matACont,matBCont, matC,zeros(20,21)),dt);
A_discr=toClear_sys_discr.A;
B_discr=toClear_sys_discr.B(:,1:20);
D_discr=toClear_sys_discr.B(:,21);
controller=discreteLQGController(A_discr,B_discr,matC, D_discr, Q, R,dt);

T=0:dt:endT;
[t_alg,state_alg, control_alg, J_alg, u_norm]=simulation(T,matACont,matBCont(:,1:end-1),matC,matBCont(:,end),Q,controller,quakeHandle);
results.time=t_alg;
results.state=state_alg;
results.control_signal=control_alg;
results.J=J_alg;
results.u_norm=u_norm;
results.name='LQG';
end

