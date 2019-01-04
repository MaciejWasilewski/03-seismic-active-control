classdef discreteLQGController<controllerInterface
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
        function obj = discreteLQGController(A_d,B_d,C, D_d, Q, R, dt)
            %ADAPTIVECONTROLLER Construct an instance of this class
            %   Detailed explanation goes here
            obj.time=0;
            obj.matADiscr=A_d;
            obj.matBDiscr=B_d;
            obj.matDDiscr=D_d;
            obj.Q=Q;
            obj.R=R;
            obj.dt=dt;
            obj.m=size(B_d,2);
            [obj.K_alg,~,~]=dlqr(A_d,B_d,Q,R);
            obj.measuredDisturbance=[];
            obj.flag=false;
            obj.all_control=zeros(1,obj.m+1);
            obj.matC=C;
            [~,obj.matKalDiscr,~]=...
                kalman(...
                ss(A_d,[B_d,D_d],C,zeros(20,21),-1),...
                0.000001*eye(21), 1*eye(20)...
                );
            obj.observerState=zeros(size(obj.matADiscr,1),1);
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
                
                
                
                
                u=-obj.K_alg*obj.observerState;
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
            obj.observerState=zeros(size(obj.matADiscr,1),1);
        end
        
        
    end
end

