classdef actuatorInterface<handle & matlab.mixin.Heterogeneous
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess=protected)
        force double
        contrObj
    end
    methods (Abstract)
        applyForce(obj)
        setInput(obj)
        reset(obj)
    end
    methods
        function val=returnForce(obj)
            val=obj.force;
        end
    end
    
end

