function [ F ] = lqr_discr_finite( A, B, Q, R, n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

P=zeros(size(Q));
% P=Q;
for i=n:-1:1
    
    P=Q+A'*(P-P*B*((R+B'*P*B)\B')*P)*A;
end
F=((R+B'*P*B)\B')*P*A;

end