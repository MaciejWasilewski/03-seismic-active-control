function [ err ] = lqg_control( varV,st,elCentroData,A,C,B20,Ba,K ,Q)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
varV=max(varV,0.001);
sC=size(C,1);
[~,L,~] = kalman(ss(A,[B20,Ba],C,zeros([sC,2])),st,eye(sC)*varV,zeros([1,sC]));
[tlqg,ylqg]=ode45(@(t,x)([A, zeros(size(A));L*C,(A-L*C)]*x+[B20;B20]*(-K*x(1:40))+[Ba;zeros(size(Ba))]*elCentroData(2,min([2502,floor(t/0.02)+1]))),[0,100],zeros(80,1));
Jlqg=costFunction(tlqg,ylqg(:,1:40),Q);
err=Jlqg;
end

