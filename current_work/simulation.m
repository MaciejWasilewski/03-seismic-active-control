function [t,state, control, J] = simulation(time_vector,A,B,C,D,Q,controlObject,disturbHandle)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[t,state]=ode45(@(t,x)(...
    A*x+B*controlObject.apply(t,C*x,disturbHandle(t))+D*disturbHandle(t)...
    ), time_vector, zeros(size(A,1),1));
control=controlObject.returnControl();
Q=sqrtm(Q);
J=state*Q;
J2=zeros(length(1),1);
for i=1:1:length(t)
    J2(i)=J(i,:)*(J(i,:))';
end
J=cumtrapz(t,J2);
end

