function [ err] = fitHarmonic(x,b, referTraj,ifPlot)
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
C2=[eye(20),zeros(20)];
B2=[zeros(20,1);zeros(9,1);1/m(10);zeros(10,1)];
B1=[zeros(20,1);zeros(19,1);1/m(20)];
B3=[zeros(20,1);0.0000001875*b*ones(20,1)];
A=[zeros(20),eye(20);M\K,M\C];

referTraj=referTraj(1:10:end,:);
w=0.0001:0.0001:0.3;
w=w(1:10:end);
w=w(1:floor(length(referTraj)/3));
referTraj=referTraj(1:floor(length(referTraj)/3),:);


spect=zeros(length(w),9);

for i=1:1:length(w)
    [ re, im ] = spectrumValue( w(i), A,B2,C2);
    spect(i,1)=sqrt(re(1)^2+im(1)^2);
    spect(i,2)=sqrt(re(10)^2+im(10)^2);
    spect(i,3)=sqrt(re(20)^2+im(20)^2);
    [ re, im ] = spectrumValue( w(i), A,B1,C2);
    spect(i,4)=sqrt(re(1)^2+im(1)^2);
    spect(i,5)=sqrt(re(10)^2+im(10)^2);
    spect(i,6)=sqrt(re(20)^2+im(20)^2);
    [ re, im ] = spectrumValue( w(i), A,1*B3,C2);
    spect(i,7)=sqrt(re(1)^2+im(1)^2);
    spect(i,8)=sqrt(re(10)^2+im(10)^2);
    spect(i,9)=sqrt(re(20)^2+im(20)^2);
end
weight=exp(w*2*log(0.5)/(0.3));
% plot(weight);
% figure;

err=sum(sum(weight'.*((log(referTraj(:,1:6))-log(spect(:,1:6)))).^2));
% err=sum(sum(weight'.*(((referTraj(:,1:6))-(spect(:,1:6)))).^2));
%             with penalty
a=10^(-8);
siz=60;
err=err+a*sum((max([zeros(1,siz);100-x(1:siz)],[],1)).^2);

% err=err+a*sum(
% if isempty(obj.bestErr) || err<obj.bestErr
%     obj.bestErr=err;
%     obj.bestFit=x(1:60);
% else
%
% end
% obj.lastFit=x(1:siz);
% if isempty(obj.refreshRate)
%
% else
%     if mod(obj.iteration, obj.refreshRate)==0
%         if obj.mode==true
%             subplot(3,3,1);
%             plot(w, (spect(:,1)),w,obj.referTraj(:,1));
%             subplot(3,3,2);
%             plot(w, (spect(:,2)),w,obj.referTraj(:,2));
%             subplot(3,3,3);
%             plot(w, (spect(:,3)),w,obj.referTraj(:,3));
%             subplot(3,3,4);
%             plot(w, (spect(:,4)),w,obj.referTraj(:,4));
%             subplot(3,3,5);
%             plot(w, (spect(:,5)),w,obj.referTraj(:,5));
%             subplot(3,3,6);
%             plot(w, (spect(:,6)),w,obj.referTraj(:,6));
%             subplot(3,3,7);
%             plot(w, (spect(:,7)),w,obj.referTraj(:,7));
%             subplot(3,3,8);
%             plot(w, (spect(:,8)),w,obj.referTraj(:,8));
%             subplot(3,3,9);
%             plot(w, (spect(:,9)),w,obj.referTraj(:,9));
%         else
if ifPlot==true
    subplot(3,3,1);
    plot(w, log(spect(:,1)),w,log(referTraj(:,1)));
%     plot(w,log(referTraj(:,1)));
    subplot(3,3,2);
    plot(w, log(spect(:,2)),w,log(referTraj(:,2)));
    subplot(3,3,3);
    plot(w, log(spect(:,3)),w,log(referTraj(:,3)));
    subplot(3,3,4);
    plot(w, log(spect(:,4)),w,log(referTraj(:,4)));
    subplot(3,3,5);
    plot(w, log(spect(:,5)),w,log(referTraj(:,5)));
    subplot(3,3,6);
    plot(w, log(spect(:,6)),w,log(referTraj(:,6)));
    subplot(3,3,7);
    plot(w, log(spect(:,7)),w,log(referTraj(:,7)));
    subplot(3,3,8);
    plot(w, log(spect(:,8)),w,log(referTraj(:,8)));
    subplot(3,3,9);
    plot(w, log(spect(:,9)),w,log(referTraj(:,9)));
    drawnow;
end
%
%         end
%         disp(err);
%     end
%     drawnow;
% end
%
% obj.iteration=obj.iteration+1;
end