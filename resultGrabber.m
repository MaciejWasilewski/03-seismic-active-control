classdef resultGrabber<handle & matlab.mixin.Heterogeneous
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Abstract)
        storeResults(obj)
        getResults(obj)
    end
    
end

