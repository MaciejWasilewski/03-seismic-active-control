classdef controllerInterface<handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        u
        contrObj
    end
    
    methods (Abstract)
        generateControl(obj)
        reset(obj)
%         returnControlInput(obj)
    end
    methods
        function val=returnControlInput(obj)
            val=obj.u;
        end
        function [ A_d,B_d] = contToDiscr(obj)
            %UNTITLED3 Summary of this function goes here
            %   Detailed explanation goes here
            A_d=expm(obj.matACont*obj.dt);
            % B=A2\(A-eye(size(A2, 1)))*B2;
            temp=zeros(size(obj.matACont));
            i=1;
            temp2=eye(size(obj.matACont));
            
            while ~isequal(temp, temp2) %&& i<10
                temp2=temp;
                temp=temp+(obj.matACont^(i-1)/factorial(i))*obj.dt^(i);
                i=i+1;
                if mod(i,100)==0
                    disp(i);
                end
            end
            
            B_d=temp*obj.matBCont;
            
            
        end
    end
    
end

