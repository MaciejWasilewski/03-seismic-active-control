classdef disturbanceInterface<handle & matlab.mixin.Heterogeneous
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess=protected)
        contrObj
    end
    
    methods (Abstract)
        applyDisturbance(obj, wholeSystem)
    end
    
end

