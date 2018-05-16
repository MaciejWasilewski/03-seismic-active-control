classdef hydraulicActuators<actuatorInterface
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nodes
        time
        matrixA
        matrixB
        matrixD1
        matrixD2
        u
    end
    
    methods
        function obj=hydraulicActuators(nodes, contr)
            obj.nodes=nodes;
            obj.u=zeros(20);
            obj.contrObj=contr;
            obj.force=zeros(size(obj.nodes,1),1);
            obj.time=0;
            obj.matrixA=-1.621*10^3*eye(20);
            obj.matrixD1=[1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;-1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -1 1];
            obj.matrixD2=[1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 -1;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
            obj.matrixB=[-5.813*10^9*obj.matrixD1,-5.464*10^7*obj.matrixD1,5.813*10^9*eye(20)];
        end
        function reset(obj)
            obj.time=0;
            obj.force=zeros(size(obj.nodes,1),1);
        end
        function setInput(obj, val)
            obj.u=val;
        end
        function applyForce(obj)
            defl=obj.contrObj.returnState('deflection',obj.nodes);
            vel=obj.contrObj.returnState('velocity',obj.nodes);
            if size(vel,1)==1
                vel=vel';
            end
            if size(defl,1)==1
                defl=defl';
            end
            vel=vel(:,1);
            defl=defl(:,1);
            if size(obj.force,1)==1
                obj.force=obj.force';
            end
%             disp(size(obj.matrixA));
%             disp(size(obj.matrixB));
%             disp(size(obj.force));
%             disp(size([defl]));
%             disp(size([vel]));
%             disp(size([u]));
% disp('defl:');
% disp(defl);
            [~,f]=ode45(@(t,y)(obj.matrixA*y+obj.matrixB*[defl;vel;obj.u]), [obj.time, obj.contrObj.time],obj.force);
            f=f';
            obj.force=f(:,end);
            obj.time=obj.contrObj.time;
%             disp(size(obj.matrixD2));
%             disp(size(
            Forces=obj.matrixD2*obj.force;
            for i=1:1:size(Forces,1)
                for j=1:1:length(obj.nodes(i, :))
                    obj.contrObj.applyForce(obj.nodes(i,j),Forces(i),0,0);
                end
            end
        end
    end
    
end

