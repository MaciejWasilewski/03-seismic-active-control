classdef floorForce<actuatorInterface
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess=protected)
        node int32
        timeHist
    end
    
    methods
        function obj = floorForce(node, contr,data)
            obj.node=node;
            obj.contrObj=contr;
            obj.timeHist=data;
        end
        function applyForce(obj)
            val=interp1(obj.timeHist(1,:),obj.timeHist(2,:),obj.contrObj.time,'nearest',0)/length(obj.node);
            for i=1:1:length(obj.node)
                obj.contrObj.applyForce(obj.node(i),val,0,0);
                
            end
        end
    end
    
end

