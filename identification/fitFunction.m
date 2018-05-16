function [ err] = fitFunction(x,freq, amp,ifPlot,~, fromAnsysTransient)
% m=x(1:20);
% vectK=x(21:40);
% vectC=x(41:60);
%
% M=diag(m);
% K=zeros(20);
% K(1,1)=-vectK(1);
% for i=2:1:20
%     ktemp=[-vectK(i),vectK(i);vectK(i),-vectK(i)];
%     K(i-1:i,i-1:i)=K(i-1:i,i-1:i)+ktemp;
% end
% C=zeros(20);
% C(1,1)=-vectC(1);
% for i=2:1:20
%     ctemp=[-vectC(i),vectC(i);vectC(i),-vectC(i)];
%     C(i-1:i,i-1:i)=C(i-1:i,i-1:i)+ctemp;
% end
% C2=[eye(20),zeros(20)];
% B2=[zeros(20,1);zeros(9,1);1/m(10);zeros(10,1)];
% B1=[zeros(20,1);zeros(19,1);1/m(20)];
% B3=[zeros(20,1);b*ones(20,1)];
% A=[zeros(20),eye(20);M\K,M\C];
[A,B,D]=buildingModel(x);
B=[10^6*B,0.1*D];
w=freq;
% elCentroData=accelData;
% AnsysResultsElCentro=fromAnsysTransient{1,1};
% AnsysResultsElCentro.time=AnsysResultsElCentro.time(1:1:end);
% AnsysResultsElCentro.deflection=AnsysResultsElCentro.deflection(1:1:end,:);
% [t,y]=ode45(@(t,x)odeElCentro(t,x,A,-D),AnsysResultsElCentro.time,zeros(40,1));
C=[eye(20),zeros(20)];
% C2=C2([1,10,20],:);
iters=1:8:length(w);
re_mod=zeros(length(iters),size(C,1)*size(B,2));
im_mod=zeros(length(iters),size(C,1)*size(B,2));
for i=1:1:length(iters)
    %     [ re, im ] = spectrumValue( w(i), A,B2,C2);
    %     spect(i,1)=sqrt(re(1)^2+im(1)^2);
    %     spect(i,2)=sqrt(re(10)^2+im(10)^2);
    %     spect(i,3)=sqrt(re(20)^2+im(20)^2);
    %     [ re, im ] = spectrumValue( w(i), A,B1,C2);
    %     spect(i,4)=sqrt(re(1)^2+im(1)^2);
    %     spect(i,5)=sqrt(re(10)^2+im(10)^2);
    %     spect(i,6)=sqrt(re(20)^2+im(20)^2);
    [ re2, im2 ] = spectrumValue( w(iters(i)), A,B,C);
    re_mod(i,:)=re2;
    im_mod(i,:)=im2;
    
    %     [ re2, im2 ] = spectrumValue( w(i), A,1/16000*Ba,C2);
    %     re_mod(i,4)=re2(1);
    %     im_mod(i,4)=im2(1);
    %     re_mod(i,5)=re2(2);
    %     im_mod(i,5)=im2(2);
    %     re_mod(i,6)=re2(3);
    %     im_mod(i,6)=im2(3);
    %     spect(i,7)=sqrt(re(1)^2+im(1)^2);
    %     spect(i,8)=sqrt(re(10)^2+im(10)^2);
    %     spect(i,9)=sqrt(re(20)^2+im(20)^2);
end
% weight=exp(w*0*log(0.5)/(0.3));
% plot(weight);
% figure;
ampl_mod=(re_mod.^2+im_mod.^2);
% ampl=(re(:,1:6).^2+im(:,1:6).^2);
% % disp(size(ampl));
% disp(size(ampl_mod));
% err=sum(sum(weight'.*((log(referTraj(:,1:6))-log(spect(:,1:6)))).^2));
% err=sum(sum(abs(re-re_mod)+abs(im-im_mod)));
err=sum(sum((log(amp(iters,:))-log(ampl_mod)).^2));
% err=sum(sum(weight'.*(((referTraj(:,1:6))-(spect(:,1:6)))).^2));
%             with penalty
a=10^(3);
a2=10^(-2);
a3=10^(2);

% siz=20;
% err=err+a*sum((max([zeros(1,siz);8*10^4-x(1:siz)],[],1)).^2);
% err=err+a*max([0,-1.5+max(x(1:20))/min(x(1:20))]);
% err=err+a2*max([0,-10+max(x(41:60))/min(x(41:60))]);
% err=err+a3*sum(sum((AnsysResultsElCentro.deflection(:,2:21)-y(:,1:20)).^2));
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
% disp(err);
if ifPlot==true
    for i=1:1:size(B,2)
        figure('NumberTitle', 'off', 'Name', [num2str(i) ' floor exct']);
        
        %         subplot(5,5,i);
        rows=floor(sqrt(size(C,1)));
        cols=ceil(sqrt(size(C,1)));
%         rows,cols,size(C,1)
        for j=1:1:size(C,1)
            subplot(rows,cols,j);
            
            plot(w(iters), log(amp(iters,size(C,1)*(i-1)+j)),w(iters),log(ampl_mod(:,size(C,1)*(i-1)+j)));
            title([num2str(j), ' floor resp.']);
            drawnow;
        end
        
        %     plot(w,log(referTraj(:,1)))
    end
%     for i=21:1:25
%         %         subplot(5,5,i);
%         figure;
%         plot(t, y(:,(i-21)*4+1:(i-20)*4),'-r',t,AnsysResultsElCentro.deflection(:,(i-21)*4+2:(i-20)*4+1),'-b');
%         drawnow;
%     end
%     disp(err);
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