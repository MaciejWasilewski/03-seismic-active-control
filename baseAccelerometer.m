classdef baseAccelerometer<sensorInterface
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        groundAccel
    end
    
    methods
        function obj=baseAccelerometer(gA)
            obj.groundAccel=gA;
        end
        
        function conductMeasurement(obj)
            obj.measurement=obj.groundAccel.returnDisturbance();
            obj.measurement=obj.measurement(1);
%             disp('measurement conducted!');
        end
    end
    
end

