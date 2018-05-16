classdef realTimeStatePlot<plotVisualizer
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        velocities
        deflections
        contrObj
        nodes
        time;
    end
    
    methods
        function obj= realTimeStatePlot(contr, nodes)
            obj.contrObj=contr;
            %             obj.timeSignal=[];
            obj.nodes=nodes;
        end
        function resetViz(obj)
            obj.resetFig();
            obj.time=[];
            obj.velocities=[];
            obj.deflections=[];
        end
        function showResults(obj)
            if ishghandle(obj.fig)
            else
                obj.fig=figure;
            end
            figure(obj.fig)
            %             vel=zeros(1,size(obj.nodes, 1));
            %             def=zeros(1,size(obj.nodes, 1));
            %             for i=1:1:size(obj.nodes,1)
            %                 temp=obj.contrObj.returnDefl(obj.nodes(i,1));
            %                 def(1,i)=temp(1);
            %                 temp=obj.contrObj.returnVel(obj.nodes(i,1));
            %                 vel(1,i)=temp(1);
            %             end
            %             vel=obj.contrObj.returnState('velocity', obj.nodes);
            def=obj.contrObj.returnState('deflection', obj.nodes);
            obj.time=[obj.time;obj.contrObj.time];
            %             obj.velocities=[obj.velocities;(vel(:,1))'];
            obj.deflections=[obj.deflections;(def(:,1))'];
            subplot(3,1,1);
            plot(obj.time, obj.deflections);
            if size(obj.deflections, 1)<2
                obj.velocities=[];
            else
                obj.velocities=diff(obj.deflections,1,1)./diff(obj.time);
                subplot(3,1,2);
                plot(obj.time(2:end), obj.velocities);
                
            end
            if size(obj.deflections, 1)<3
                
            else
                accels=diff(obj.velocities,1,1)./(diff(obj.time(1:end-1)));
                subplot(3,1,3);
                %                 disp(size(obj.time(3:end)));
                %                 disp(size(accels));
                plot(obj.time(1:end-2), accels');
            end
            
            
            %             obj.fig=clf('reset');
            %             hold on;
            
            
            
            
            drawnow;
            %             hold off;
        end
    end
    
end

