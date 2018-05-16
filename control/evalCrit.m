function [ J ] = evalCrit( y,t,m )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

J=zeros(8,1);
d=diff([zeros(1,size(y,2));y(1:20, :)],1,1);
% disp(size(d));
h=([5.49*ones(size(y,2),1),ones(size(y,2),19)*3.96])';
% disp(size(h))
a=diff(y(21:40, :),1,2)./diff(t,1,2);
disp(size(a));
% disp(size(repmat(m,size(y,1)-1,1)));
s=a.*repmat(m',1,size(y,2)-1);
disp(size(s));
J(1,1)=max(max(abs(y(1:20, :))));
J(2,1)=max(max(abs(d)./h));
J(3,1)=max(max(abs(a)));
J(4,1)=max(abs(sum(s,2)));
J(5,1)=max(sqrt(trapz(t,(y(1:20, :)).^2,2)));
J(6,1)=max(sqrt(trapz(t,d.^2./(h(1,:)),2)));
J(7,1)=max(sqrt(trapz(t(2:end),a.^2,2)));
J(8,1)=sqrt(trapz(t(2:end),sum(s,1).^2,2));
end

