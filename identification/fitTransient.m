function [ err ] = fitTransient(x,step20,step10,step1,ifPlot)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

t=step20(:,1);

[A,B1,B2,B3]=buildingModel2(x);

[~,y]=ode45(@(t,y)(A*y+B1*1+B2*0+B3*0),t,zeros(40,1));
% disp(size(y(:,20)));
% disp(size(step20(:,2)));
step20(:,2)=step20(:,2)*10^7;
step10(:,2)=step10(:,2)*10^7;
step1(:,2)=step1(:,2)*10^7;
y(:,1:end)=y(:,1:end)*10^7;
err=sum((step20(:,2)-y(:,20)).^2)+sum((step10(:,2)-y(:,10)).^2)+sum((step1(:,2)-y(:,1)).^2);
a=10^(-12);
siz=60;
err=err+a*sum((max([zeros(1,siz);1-x(1:siz)],[],1)).^2);

if ifPlot==true
    subplot(1,3,1);
    plot(t,step1(:,2),t,y(:,1));
    %     plot(w,log(referTraj(:,1)));
    subplot(1,3,2);
    plot(t,step10(:,2),t,y(:,10));
    subplot(1,3,3);
    plot(t,step20(:,2),t,y(:,20));
    %     subplot(2,3,4);
    %     plot(w, (im(:,1)),w,(im_mod(:,1)));
    %     subplot(2,3,5);
    %     plot(w, (im(:,2)),w,(im_mod(:,2)));
    %     subplot(2,3,6);
    %     plot(w, (im(:,3)),w,(im_mod(:,3)));
    drawnow;
end

end

