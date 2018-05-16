classdef stepDisturb<timeDisturbance
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        node int32
        tstart double
        tend double
        value double
    end
    
    methods
        function obj=stepDisturb(contr, node, tstart, tend, value)
            obj.contrObj=contr;
            obj.node=node;
            obj.tstart=tstart;
            obj.tend=tend;
            obj.value=value;
        end
        function applyDisturbance(obj)
            if obj.contrObj.time>=obj.tstart && obj.contrObj.time<=obj.tend
                obj.contrObj.applyForce(obj.node, obj.value,0,0);
            else
                obj.contrObj.applyForce(obj.node, 0,0,0);
            end
            
            
        end
    end
    
end

