classdef chirpDisturbance<timeDisturbance
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        node
        tend
        f0
        fmax
    end
    
    methods
        function obj=chirpDisturbance(contr, node, tend, f0, fmax)
            obj.contrObj=contr;
            obj.node=node;
            obj.tend=tend;
            obj.f0=f0;
            obj.fmax=fmax;
        end
        function applyDisturbance(obj)
            obj.contrObj.applyForce(obj.node,(10^6)*chirp(obj.contrObj.time, obj.f0,obj.tend, obj.fmax),0,0);
        end
    end
    
end

