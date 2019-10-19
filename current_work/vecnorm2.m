function [ n ] = vecnorm(A)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
m=size(A,2);
n=zeros(1,m);
for i=1:1:m
    n(1,i)=norm(A(:,i));
end
end

