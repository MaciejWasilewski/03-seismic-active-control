function [results] = hinf_simulation(matACont,matBCont, matC, Q,R,dt,endT, quakeHandle, regTerm )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

controller=hInfController(matACont,matBCont(:,1:20),matC, matBCont(:,21), Q,R, dt, regTerm);

T=0:dt:endT;
[alg,cl_system]=controller.returnAlgorithm();
% [t_alg,state_alg, control_alg, J_alg, u_norm]=simulation(T,matACont,matBCont(:,1:end-1),matC,matBCont(:,end),Q,controller,quakeHandle);
[t,y]=ode45(@(t,x)(cl_system.A*x+cl_system.B*quakeHandle(t)),T,zeros(size(cl_system.A,1),1));
% results.time=t_alg;
% results.state=state_alg;
% results.control_signal=control_alg;
% results.J=J_alg;
% results.u_norm=u_norm;

results.time=t;
results.state=y(:,1:60);

results.control_signal=[t,(y(:,61:end)*alg.C')];
Q=sqrtm(Q);
J=results.state*Q;
J2=zeros(length(1),1);
for i=1:1:length(t)
    J2(i)=J(i,:)*(J(i,:))';
end
J=cumtrapz(t,J2);
results.J=J;

u2=zeros(size(results.control_signal, 1),1);
for i=1:1:length(u2)
   u2(i)=results.control_signal(i,2:end)*results.control_signal(i,2:end)'; 
end
u_norm=trapz(results.control_signal(:,1), u2);
results.u_norm=u_norm;
results.R=R*regTerm^2;
results.name='H_inf';
end

