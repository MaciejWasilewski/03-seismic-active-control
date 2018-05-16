function [ err ] = fitStiff( vectK,def,f,ifPlot )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

K=zeros(20);
K(1,1)=-vectK(1);
for i=2:1:20
    ktemp=[-vectK(i),vectK(i);vectK(i),-vectK(i)];
    K(i-1:i,i-1:i)=K(i-1:i,i-1:i)+ktemp;
end
K=-K;
X=K\f;
err=norm(def-X);

if ifPlot==true
    for i=1:1:9
        subplot(3,3,i);
        plot([def(:,i),X(:,i)]);
        
        %     subplot(2,3,4);
        %     plot(w, (im(:,1)),w,(im_mod(:,1)));
        %     subplot(2,3,5);
        %     plot(w, (im(:,2)),w,(im_mod(:,2)));
        %     subplot(2,3,6);
        %     plot(w, (im(:,3)),w,(im_mod(:,3)));
    end
    drawnow;
end
end

