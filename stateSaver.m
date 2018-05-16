classdef stateSaver<resultGrabber
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        nodes int32
        time double
        defl
        vel
        contrObj
        u
        f
        timeExpmnt
        kal
%         fname string
iter
fname
    end
    
    methods
        function obj=stateSaver(nodes,contr,txp, fname)
            obj.nodes=nodes;
%             obj.fname=fname;
            obj.contrObj=contr;
            obj.timeExpmnt=txp;
            obj.time=[];
            obj.defl=[];
            obj.vel=[];
            obj.u=cell(1,length(obj.timeExpmnt.controllers));
            obj.f=cell(1,length(obj.timeExpmnt.actuators));
            obj.fname=fname;
            obj.iter=0;
            obj.kal=cell(1,length(obj.timeExpmnt.controllers));
        end
        function reset(obj)
            obj.time=[];
            obj.defl=[];
            obj.vel=[];
            obj.u=cell(1,length(obj.timeExpmnt.controllers));
            obj.f=cell(1,length(obj.timeExpmnt.actuators));
            obj.iter=0;
            obj.kal=cell(1,length(obj.timeExpmnt.controllers));
        end
        function getResults(obj)
            vell=obj.contrObj.returnState('velocity', obj.nodes);
            def=obj.contrObj.returnState('deflection', obj.nodes);
            obj.time=[obj.time;obj.contrObj.time];
            obj.vel=[obj.vel;(vell(:,1))'];
            obj.defl=[obj.defl;(def(:,1))'];
            for jc=1:1:length(obj.timeExpmnt.controllers)
                    obj.u{jc}=[obj.u{jc},obj.timeExpmnt.controllers{jc}.returnControlInput()];
                    obj.kal{jc}=[obj.kal{jc},obj.timeExpmnt.controllers{jc}.returnObserverState()];
            end
            for ja=1:1:length(obj.timeExpmnt.actuators)
                    obj.f{ja}=[obj.f{ja},obj.timeExpmnt.actuators{jc}.returnForce()];
            end
            if mod(obj.iter,100)==0
                evalin('base', 'sym=syst.saveRes();');
                evalin('base', ['save(fname, ''sym'');']);
%                 res=obj.storeResults();
%                 save(obj.fname, res);
            end
            obj.iter=obj.iter+1;
%             vell=zeros(1,size(obj.nodes, 1));
%             def=zeros(1,size(obj.nodes, 1));
%             for i=1:1:size(obj.nodes,1)
%                 temp=obj.contrObj.returnDefl(obj.nodes(i,1));
%                 def(1,i)=temp(1);
%                 temp=obj.contrObj.returnVel(obj.nodes(i,1));
%                 vell(1,i)=temp(1);
%             end
%             obj.time=[obj.time;obj.contrObj.time];
%             obj.vel=[obj.vel;vell];
%             obj.defl=[obj.defl;def];
        end
        function res=storeResults(obj)
            res.time=obj.time;
            res.deflection=obj.defl;
            res.velocity=obj.vel;
            res.u=obj.u;
            res.f=obj.f;
            res.kal=obj.kal;
        end
    end
    
end

