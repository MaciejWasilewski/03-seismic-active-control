classdef numExp<handle
    %numExp Interface for all numerical simulations
    %   This is an interface class for all different simulation scenarios.
    
    properties (SetAccess = private)
    end
    
    methods (Abstract)
        conductExp(obj)
%         saveRes(obj)
    end
    
end

