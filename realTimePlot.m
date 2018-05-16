classdef realTimePlot<plotVisualizer
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        contrObj
    end
    
    methods
        function obj=realTimePlot(contr)
            obj.contrObj=contr;
        end
        function showResults(obj)
            if ishghandle(obj.fig)
            else
                obj.fig=figure;
            end
            figure(obj.fig);
            pos=obj.contrObj.getElemInitPos();
            defl=obj.contrObj.getElemDefl();
            obj.fig=clf('reset');
            hold on;
            for i=1:1:size(pos, 1)
                plot(pos(i, 1:2), pos(i, 3:4), 'b-');
                plot(pos(i, 1:2)+defl(i, 1:2), pos(i, 3:4)+defl(i, 3:4), 'r-');
            end
            drawnow;
            hold off;
        end
        function resetViz(obj)
            obj.resetFig();
        end
    end
    
end

