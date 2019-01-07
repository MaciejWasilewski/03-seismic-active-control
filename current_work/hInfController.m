classdef hInfController<controllerInterface
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
        matA
        matB
        matD
        matC
        Q
        A_alg
        B_alg
        C_alg
        D_alg
        m
        flag
        all_control
        algState
        observerState
    end
    
    methods
        function obj = hInfController(A,B,C, D, Q, dt, rTerm)
            %ADAPTIVECONTROLLER Construct an instance of this class
            %   Detailed explanation goes here
            obj.time=0;
            obj.matA=A;
            obj.matB=B;
            obj.matD=D;
            obj.Q=Q;
            obj.dt=dt;
            obj.m=size(B,2);
            %             system=ss(A,[D,B], [[sqrtm(Q(1:40,1:40)), zeros(40,20); zeros(20,40),rTerm*eye(20)];C],zeros(80,21));
            Q2=[sqrtm(Q(1:40,1:40)), zeros(40,20); zeros(20,40),rTerm*eye(20)];
            system=ss(A,[D,B], [Q2;C;zeros(1,60)],[zeros(60,21);[zeros(20,1);1], zeros(21,20)]);
            [alg_system,clsystem,gam]=hinfsyn(system,21,20);
            clsystem=ss(clsystem.A,clsystem.B,[sqrtm(Q(1:40,1:40)), zeros(40,80)],clsystem.D(1:40,:));
%             disp(clsystem);
            disp(['Gamma: ', num2str(gam)]);
            disp(['Gamma2: ', num2str(hinfnorm(clsystem))]);
            alg_system=c2d(alg_system, dt);
            obj.A_alg=alg_system.A;
            obj.B_alg=alg_system.B;
            obj.C_alg=alg_system.C;
            obj.D_alg=alg_system.D;
            obj.measuredDisturbance=[];
            obj.flag=false;
            obj.all_control=zeros(1,obj.m+1);
            obj.matC=C;
            obj.observerState=zeros(size(obj.A_alg,1),1);
        end
        
        function u = apply(obj,t,y,f)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if(t-obj.time>=obj.dt)
                obj.time=obj.time+obj.dt;
                %                 disp(obj.all_control(end, 2:end)');
                obj.measuredDisturbance=[obj.measuredDisturbance;f];
                obj.observerState=obj.A_alg*obj.observerState+obj.B_alg*[y;f];
                u=obj.C_alg*obj.observerState+obj.D_alg*[y;f];
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