classdef groundAcceleration<timeDisturbance
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
    end
    
    methods
        function obj=groundAcceleration(data, contr)
            obj.timeSeries=data;
            obj.contrObj=contr;
        end
        function addData(obj, data)
            obj.timeSeries=data;
        end
        function applyDisturbance(obj)
            if obj.contrObj.time>obj.timeSeries(end,1) && obj.contrObj.time<obj.timeSeries(1,1)
                a=[0,0,0];
            else
                a=interp1(obj.timeSeries(:,1), obj.timeSeries(:, 2:4), obj.contrObj.time,'spline',0);
                %             disp(a);
                
            end
            obj.contrObj.applyAcceleration(a(1), a(2), a(3));
        end
        function a=returnDisturbance(obj)
            if obj.contrObj.time>obj.timeSeries(end,1) && obj.contrObj.time<obj.timeSeries(1,1)
                a=[0,0,0];
            else
                a=interp1(obj.timeSeries(:,1), obj.timeSeries(:, 2:4), obj.contrObj.time,'spline',0);
                %             disp(a);
                
            end
        end
    end
    
end

