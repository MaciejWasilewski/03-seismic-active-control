classdef buildingInterface<handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess=protected)
        time;
        state;
    end
    
    methods (Abstract)
        conductIntegration(obj,time);
        startIntegration(obj);
        state=returnState(obj, type, nodes);
        applyForce(obj, node,valx, valy,valz);
    end
end

