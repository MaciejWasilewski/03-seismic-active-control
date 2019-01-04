classdef controllerInterface<handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    

    methods (Abstract)      
        u=apply(obj,t,y,f);
        u=returnControl(obj);
        restart(obj);
    end
end

