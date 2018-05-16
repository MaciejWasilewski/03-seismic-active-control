function [ re, im ] = spectrumValue( w, A,B,C )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% if length(vectM)==1
%     M=vectM*eye(20);
% else
%     M=diag(vectM);
% end
% 
% if length(vectK)==1
%     K=eye(20);
%     K(2:end, 1:end-1)=K(2:end, 1:end-1)-eye(19);
%     K=K+K';
%     K=vectK*K;
% else
%     K=zeros(20);
%     K(1,1)=-vectK(1);
%     for i=2:1:20
%         ktemp=[-vectK(i),vectK(i);vectK(i),-vectK(i)];
%         K(i-1:i,i-1:i)=K(i-1:i,i-1:i)+ktemp;
%     end
%     
% end
% 
% if length(vectC)==1
%     C=eye(20);
%     C(2:end, 1:end-1)=C(2:end, 1:end-1)-eye(19);
%     C=C+C';
%     C=vectC*C;
% else
%     C=zeros(20);
%     C(1,1)=-vectC(1);
%     for i=2:1:20
%         ctemp=[-vectC(i),vectC(i);vectC(i),-vectC(i)];
%         C(i-1:i,i-1:i)=C(i-1:i,i-1:i)+ctemp;
%     end
%     
% end

% A=[zeros(20),eye(20);-M\K,-M\C];

% C2=[eye(20),zeros(20)];
% B2=[zeros(20,1);zeros(12,1);1;zeros(7,1)];
% B1=[zeros(20,1);1;zeros(19,1)];
% disp(size(eye(40)*w*complex(0,1)-A));
trnsm=zeros(1,size(C,1)*size(B,2));
for i=1:1:size(B,2)
trnsm(1+size(C,1)*(i-1):size(C,1)*(i))=(C*((eye(40)*w*complex(0,1)-A)\B(:,i)));
end
re=real(trnsm);
im=imag(trnsm);
end

