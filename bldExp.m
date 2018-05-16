classdef bldExp<timeExp
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        ansysCon
        dt double
        sensorsArray
    end
    
    methods
        function obj=bldExp(t0,tend, dt)
            obj.startTime=t0;
            obj.endTime=tend;
            obj.dt=dt;
            obj.ansysCon=ansysConnector();
        end
        function conductExp(obj)
           obj.results=1;
        end
        function saveRes(obj)
            
        end
        function addSensor(obj, freq, sens, node, X)
            obj.sensorsArray=[obj.sensorsArray, accelerometer(freq, sens, node, X)];
        end
    end
    
end

