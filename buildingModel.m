function [A, B, C, D] = buildingModel( par, ~ )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

n=20;
m=par(1);
k=par(2);
c=par(3);
% M=m*eye(n);
K=k*eye(n);
K=K-k*[zeros(1,n);eye(n-1), zeros(n-1,1)];
K=K+K';

C=c*eye(n);
C=C-c*[zeros(1,n);eye(n-1), zeros(n-1,1)];
C=C+C';

L=[zeros(2,1);1;zeros(n-3,1)];

A=[zeros(n,n),eye(n);-1/m*K,-1/m*C];
B=[zeros(20,1);1/m*L];

C=eye(40);
D=zeros(40,1);
end

