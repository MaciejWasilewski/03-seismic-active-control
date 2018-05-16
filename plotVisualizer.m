classdef plotVisualizer<visualizerInterface
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        fig
    end
    
    methods
        function obj=plotVisualizer()
            obj.fig=figure;            
        end
        function delete(obj)
            if ishghandle(obj.fig)
                close(obj.fig);
            end
        end
        function resetFig(obj)
            if ishghandle(obj.fig)
                figure(obj.fig);
                clf('reset');
                hold off;
            else
                obj.fig=figure;
            end
        end
    end
    
end

