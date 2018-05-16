function [ G ] = AR( data, n )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
l=size(data,2);
Y=(data(1,1+n:end))';
phi=zeros(l-n,n);
for i=1:1:l-n
    phi(i, :)=data(1,i:i+n-1);
end


theta=pinv(phi)*Y;
G=[zeros(n-1,1), eye(n-1);theta'];
% disp('data');
% disp(data);
% disp('theta');
% disp(theta);
% figure;
% plot(data);
% title('model')
end

