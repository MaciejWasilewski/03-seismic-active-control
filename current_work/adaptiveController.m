classdef adaptiveController<controllerInterface
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        time
        measuredDisturbance
        n
        N
        min_N
        S
        dt
        matADiscr
        matBDiscr
        matDDiscr
        matC
        matKalDiscr
        Q
        Q2
        R
        K_alg
        m
        flag
        all_control
        observerState
    end
    
    methods
        function obj = adaptiveController(A_d,B_d,C, D_d, Q, R,n,N,min_N, dt)
            %ADAPTIVECONTROLLER Construct an instance of this class
            %   Detailed explanation goes here
            obj.time=0;
            obj.n=n;
            obj.N=N;
            obj.matADiscr=A_d;
            obj.matBDiscr=B_d;
            obj.matDDiscr=D_d;
            obj.Q=Q;
            obj.Q2=zeros(size(Q)+[n,n]);
            obj.Q2(1:size(Q),1:size(Q))=obj.Q;
            obj.R=R;
            obj.dt=dt;
            obj.m=size(B_d,2);
            obj.min_N=min_N;
            [obj.K_alg,~,~]=dlqr(A_d,B_d,Q,R);
            obj.K_alg=[obj.K_alg,zeros(obj.m,n)];
            obj.measuredDisturbance=[];
            obj.flag=false;
            obj.all_control=zeros(1,obj.m+1);
            obj.matC=C;
            [~,obj.matKalDiscr,~]=...
                kalman(...
                ss(A_d,[B_d,D_d],C,zeros(20,21),-1),...
                0.000001*eye(21), 1*eye(20)...
                );
            obj.observerState=zeros(size(A_d,1),1);
        end
        
        function u = apply(obj,t,y,f)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if(t-obj.time>=obj.dt)
                obj.time=obj.time+obj.dt;
                %                 disp(obj.all_control(end, 2:end)');
                obj.measuredDisturbance=[obj.measuredDisturbance;f];
                obj.observerState=(obj.matADiscr-obj.matKalDiscr*obj.matC)*obj.observerState...
                    +[obj.matBDiscr,obj.matDDiscr]*[obj.all_control(end, 2:end)';obj.measuredDisturbance(end)]...
                    +obj.matKalDiscr*y;
                if(length(obj.measuredDisturbance)>=obj.min_N)
                    if(~obj.flag)
                        disp('start!');
                        obj.flag=true;
                    end
                    obj.measuredDisturbance=obj.measuredDisturbance(end-min(length(obj.measuredDisturbance),obj.N)+1:end);
                    if size(obj.measuredDisturbance, 1)==1
                        G=obj.AR( obj.measuredDisturbance, obj.n);
                    else
                        G=obj.AR( obj.measuredDisturbance', obj.n);
                    end
                    maxeig=max(abs(eigs(G)));
                    maxeig2=max(1,maxeig*1.05);
                    G2=G;
                    A=[obj.matADiscr,obj.matDDiscr*[zeros(1,obj.n-1),1];...
                        zeros(obj.n,size(obj.matADiscr,2)),G2];
                    %                 disp(size(A));
                    B=[obj.matBDiscr;zeros(size(G,1),obj.m)];
                    %                 disp(size(B));
                    %                 obj.K_alg=obj.dlqr_finite(A,B,obj.Q2,obj.R, obj.S);
                    [~,~,obj.K_alg,flag2]=dare(A,B,obj.Q2,obj.R,[],[]);
                    while flag2<0
%                         disp(flag2);
                        %                     disp(maxeig);
%                         disp(maxeig2);
                        maxeig2=maxeig2*1.05;
                        G2=G/maxeig2;
                        A=[obj.matADiscr,obj.matDDiscr*[zeros(1,obj.n-1),1];...
                            zeros(obj.n,size(obj.matADiscr,2)),G2];
                        [~,~,obj.K_alg,flag2]=dare(A,B,obj.Q2,obj.R,[],[]);
                        
                        
                    end
                    x=[obj.observerState;obj.measuredDisturbance(end-obj.n+1:end)];
                else
                    %                 simple LQR
                    x=[obj.observerState;zeros(obj.n,1)];
                    [obj.K_alg,~,~]=dlqr(obj.matADiscr,obj.matBDiscr,obj.Q,obj.R);
                    obj.K_alg=[obj.K_alg,zeros(obj.m,obj.n)];
                end
                u=-obj.K_alg*x;
                obj.all_control=[obj.all_control;[obj.time,u']];
            else
                u=obj.all_control(end, 2:end)';
                
            end
        end
        function u=returnControl(obj)
            u=obj.all_control;
        end
        function restart(obj)
            obj.all_control=zeros(1,obj.m+1);
        end
        function [ G] = AR(~, data, n )
            %UNTITLED12 Summary of this function goes here
            %   Detailed explanation goes here
            l=size(data,2);
            if l==1
                disp('l==1!!!');
            end
            Y=(data(1,1+n:end))';
            
            phi=zeros(l-n,n);
            for i=1:1:l-n
                phi(i, :)=data(1,i:i+n-1);
            end
            
            
            theta=pinv(phi)*Y;
            G=[zeros(n-1,1), eye(n-1);theta'];
            %             disp('data');
            %             disp(data);
            %             disp('theta');
            %             disp(theta);
            %             figure;
            %             plot(data);
            %             title('ansys');
        end
        
    end
end

