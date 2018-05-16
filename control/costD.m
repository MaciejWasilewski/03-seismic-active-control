function [cost,yAlg,uAlg,uLQR] = costD(TEnd,dt,N,n,Q,R,ACont,BCont,DCont,ADiscr,BDiscr,DDiscr,distrb)
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
% N,n,S

BAug=[BDiscr;zeros(n,size(BDiscr,2))];
QAug=zeros(size(Q,1)+n);
QAug(1:size(Q,1),1:size(Q,1))=Q;
%         [K_d,~,~]=dlqr(A_2,B_2,Q_2,10^(-4),[]);
KLQR=dlqr(ADiscr,BDiscr,Q,R,[]);
% k2=dlqr(A_d,BallD,Q,eye(size(B_d,2))*10^(-4),[]);
% y_0=zeros(43,1);
t=0:dt:TEnd;
distrb=interp1(distrb(1,:),distrb(2,:),t,'spline',0);
imax=length(t);
% y_2=zeros(imax,40+n);
yAlg=zeros(imax,40);

yLQR=zeros(imax,40);
uAlg=zeros(imax,20);
uLQR=zeros(imax,20);
% distrb=zeros(imax,1);
% for i=1:1:imax
%     distrb(i,1)=elCentroData(2,min(i,size(elCentroData,2)));
% end
% distrb=(elCentroData(2,:))';
%         N=Nvec(nn);
%         S=Svec(s);
uAlg(1,:)=zeros(1,20);
uLQR(1,:)=zeros(1,20);
KAlg=[KLQR,zeros(size(BDiscr,2),n)];
for i=2:1:imax
    if mod(i,100)==0
        %         disp(i);
    end
    ytemp=(yAlg(i-1,:))';
    
    measDist=distrb(max(1,i-N+1):i)';
    
    
    
    
    if i<=35
        uAlgt=-KLQR*ytemp;
    else
        if mod(i,6)==0
            
            %     disp(measDist);
            G=AR( measDist', n);
            maxeig=max(abs(eigs(G)));
            maxeig2=max(1,maxeig*1.01);
%             if maxeig<1/1.01
%                 maxeig2=1;
%             else
%                 maxeig2=maxeig*1.01;
%             end
            %     max(abs(eigs(G/(maxeig))))
            %     disp(G);
            AAug=[ADiscr,DDiscr*[zeros(1,n-1),1];zeros(n,size(ADiscr,1)),G];
            %     [K_d,~,~]=dlqr(A_2,B_2,Q_2,10^(-4),[]);
            %         K_d=lqr_discr_finite(A_2,B_2,Q_2,10^(-4),S);
            [~,~,KAlg,flag]=dare(1/(maxeig2)*AAug,1/(maxeig2)*BAug,QAug,R,[],[]);
            while flag<0
                disp(flag);
                disp(maxeig);
                disp(maxeig2);
                maxeig2=maxeig2*1.01;
                [~,~,KAlg,flag]=dare(1/(maxeig2)*AAug,1/(maxeig2)*BAug,QAug,R,[],[]);
%                 disp(G);
%                 disp(max(abs(eigs(G))));
            end
        end
        %         u=-K_d*ytemp;
        %     disp(size(KAlg));
        distrState=[measDist(max(1,length(measDist)-n+1):end);zeros(max(0,n-length(measDist)),1)];
        %     disp(distrState);
        %     disp(size(distrState));
        uAlgt=-KAlg*[ytemp;distrState];
    end
%     uAlgt=min(max(uAlgt,-4*10^4*ones(size(uAlgt))),4*10^4*ones(size(uAlgt)));
    uAlg(i,:)=uAlgt';
    %     ytemp2=zeros(40,1);
    [~,ytemp2]=ode45(@(t,x)(ACont*x+BCont*uAlgt+DCont*distrb(i)),[0,dt],yAlg(i-1,:));
    %     (A_2-B_2*K_d)*ytemp;
    
    %     ytemp2(end-n+1:end)=zeros(n,1);
    %     f=distrb(max(1,i-n+1):i);
    %     ytemp2(end-length(f)+1:end)=f;
    %             disp(size(y_2(i,:)));
    %             disp(size(ytemp2'));
    yAlg(i,:)=ytemp2(end,:);
    uLQRt=-KLQR*(yLQR(i-1,:))';
%     uLQRt=min(max(uLQRt,-4*10^4*ones(size(uLQRt))),4*10^4*ones(size(uLQRt)));
    uLQR(i,:)=uLQRt';
    [~,ytemp2]=ode45(@(t,x)(ACont*x+BCont*uLQRt+DCont*distrb(i)),[0,dt],yLQR(i-1,:));
    %     y_van(i,:)=((A_d-B_d*K_const)*(y_van(i-1,:))'+B_ed*distrb(i,1))';
    yLQR(i,:)=ytemp2(end,:);
end

plot(t,yLQR(:,[1,10,20]),'-b',t,yAlg(:,[1,10,20]),'-r');

[Ja,tJa]=costFunction(t,yAlg(:,1:40),Q);
JLQR=costFunction(t,yLQR(:,1:40),Q);
Ja,JLQR
Ja/JLQR
cost=Ja;
end

