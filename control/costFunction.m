function [ J,tJ ] = costFunction(t,x,Q)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

l=size(x,1);
dJ=zeros(l,1);
for i=1:1:l
    xtemp=x(i,:);
    dJ(i)=xtemp*Q*xtemp';
end
tJ=cumtrapz(t, dJ);
J=tJ(end);
end

