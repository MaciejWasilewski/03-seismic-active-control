classdef accelerometer<sensorInterface
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess=protected)
        timeOfLastMeasurement double
        Frequency double
        sensitivity double
        node int32 
    end
    
    methods
        function obj = accelerometer(freq, sens, node, contr)
            obj.Frequency=freq;
            obj.sensitivity=sens;
            obj.measurement=0;
            obj.timeOfLastMeasurement=0;
            obj.node=node;
            obj.contrObj=contr;
        end
        
        function conductMeasurement(obj)
            if 1/(obj.contrObj.time-obj.timeOfLastMeasurement)>obj.Frequency
                
            else
                obj.measurement=obj.contrObj.returnState('accel',obj.node);
                obj.timeOfLastMeasurement=obj.timeOfLastMeasurement+1/obj.Frequency;
            end
%             obj.measurement;
        end
    end
    
    
end

