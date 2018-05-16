function [ A_d,B_d,B_ed ] = contToDiscr( A,B,Be,dt )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
A_d=expm(A*dt);
% B=A2\(A-eye(size(A2, 1)))*B2;
temp=zeros(size(A));
i=1;
temp2=eye(size(A));

while ~isequal(temp, temp2) %&& i<10
    temp2=temp;
    temp=temp+(A^(i-1)/factorial(i))*dt^(i);
    i=i+1;
    if mod(i,100)==0
       disp(i); 
    end
end

B_d=temp*B;
B_ed=temp*Be;

end

