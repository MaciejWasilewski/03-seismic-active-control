classdef sensorInterface<handle & matlab.mixin.Heterogeneous
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess=protected)
        measurement double
        contrObj
    end
    
    methods (Abstract)
        conductMeasurement(obj)
    end
    methods 
        function val=returnSensorOutput(obj)
            val=obj.measurement;
        end
    end
    
end

