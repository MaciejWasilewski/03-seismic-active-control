classdef ansysConnector<handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        orb
        iCoMapdlUnit
    end
    
    methods
        function obj=ansysConnector()
            obj.orb=initialize_orb();
            load_ansys_aas;
            obj.iCoMapdlUnit=actmapdlserver(obj.orb,'D:\Program Files\Ansys\ANSYS Inc\v180\ansys\bin\winx64\aaS_MapdlId.txt');
        end
        function executeCommand(obj,string)
            obj.iCoMapdlUnit.executeCommand(string);
        end
        function quit(obj)
            obj.iCoMapdlUnit.executeCommand('/input,quitansys.txt');
        end
    end
    
end

