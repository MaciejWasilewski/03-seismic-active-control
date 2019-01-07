function [results] = hinf_simulation(matACont,matBCont, matC, Q,dt,endT, quakeHandle, regTerm )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

controller=hInfController(matACont,matBCont(:,1:20),matC, matBCont(:,21), Q, dt, regTerm);

T=0:dt:endT;
[t_alg,state_alg, control_alg, J_alg, u_norm]=simulation(T,matACont,matBCont(:,1:end-1),matC,matBCont(:,end),Q,controller,quakeHandle);
results.time=t_alg;
results.state=state_alg;
results.control_signal=control_alg;
results.J=J_alg;
results.u_norm=u_norm;
results.name='H_inf';
end

