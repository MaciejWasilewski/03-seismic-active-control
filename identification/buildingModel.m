function [ A,B,D, M, K, C] = buildingModel(x)
m=x(1:20);
vectK=x(21:40);
vectC=x(41:60);

M=diag(m);
K=zeros(20);
K(1,1)=-vectK(1);
for i=2:1:20
    ktemp=[-vectK(i),vectK(i);vectK(i),-vectK(i)];
    K(i-1:i,i-1:i)=K(i-1:i,i-1:i)+ktemp;
end
C=zeros(20);
C(1,1)=-vectC(1);
for i=2:1:20
    ctemp=[-vectC(i),vectC(i);vectC(i),-vectC(i)];
    C(i-1:i,i-1:i)=C(i-1:i,i-1:i)+ctemp;
end
B=[zeros(20,20);diag(ones(1,20)./m)];
% B2=[zeros(20,1);zeros(9,1);1/m(10);zeros(10,1)];
% B1=[zeros(20,1);zeros(19,1);1/m(20)];
D=[zeros(20,1);ones(20,1)];
A=[zeros(20),eye(20);M\K,M\C];
K=-K;
C=-C;
end