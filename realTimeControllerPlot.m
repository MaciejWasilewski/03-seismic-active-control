classdef realTimeControllerPlot<plotVisualizer
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        observerState
        contrObj
        time
        controler
        u
        baseAcc;
    end
    
    methods
        function obj= realTimeControllerPlot(contr, controler)
            obj.contrObj=contr;
            obj.controler=controler;
            %             obj.timeSignal=[];
        end
        function resetViz(obj)
            obj.resetFig();
            obj.time=[];
            obj.u=[];
            obj.observerState=[];
            obj.baseAcc=[];
        end
        function showResults(obj)
            if ishghandle(obj.fig)
            else
                obj.fig=figure;
            end
            figure(obj.fig)
            %             vel=zeros(1,size(obj.nodes, 1));
            %             def=zeros(1,size(obj.nodes, 1));
            %             for i=1:1:size(obj.nodes,1)
            %                 temp=obj.contrObj.returnDefl(obj.nodes(i,1));
            %                 def(1,i)=temp(1);
            %                 temp=obj.contrObj.returnVel(obj.nodes(i,1));
            %                 vel(1,i)=temp(1);
            %             end
            %             vel=obj.contrObj.returnState('velocity', obj.nodes);
            obs=obj.controler.returnObserverState();
            uu=obj.controler.returnControlInput();
            obj.time=[obj.time;obj.contrObj.time];
            %             obj.velocities=[obj.velocities;(vel(:,1))'];
            obj.observerState=[obj.observerState,obs(1:20)];
%             C=[-496.006203806364 322.970211300617 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 -27.9764790399158 0.000864963735856850 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;319.681683220260 -586.244309551784 266.562626331525 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000856156553539938 -25.0831351170678 25.0822789605142 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 267.302577518565 -518.883130700452 251.580553181887 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 25.1519048579850 -53.2124772332198 28.0605723752348 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 250.543581507286 -491.311319064983 240.767737557697 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 27.9449115327802 -63.2015367013320 35.2566251685518 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 355.503215646607 -809.720023506413 454.216807859806 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 52.0578203184873 -115.084719319264 63.0268990007768 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 454.501783539227 -790.347758371119 335.845974831893 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 63.0664420847264 -105.998993295894 42.9325512111673 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 242.886084823716 -475.017994203757 232.131909380041 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 31.0491119638807 -70.7492318326470 39.7001198687663 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 318.953015893524 -749.472089364972 430.519073471447 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 54.5486098714103 -143.583419407356 89.0348095359452 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 437.275999318762 -720.768968870612 283.492969551850 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 90.4321961860027 -112.136067287843 21.7038711018403 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 284.193902275396 -635.120530865252 350.926628589856 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 21.7575336441846 -21.7587760751087 0.00124243092412855 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 348.991855890919 -622.243510343649 273.251654452730 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00123558099814265 -62.1348529497006 62.1336173687025 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 187.412427653045 -404.190163275419 216.777735622374 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 42.6149737071339 -73.4761384984274 30.8611647912935 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 213.795669295991 -406.850495341467 193.054826045476 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 30.4366283874378 -65.1367284389163 34.7001000514785 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 194.053657982115 -357.666070884460 163.612412902345 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 34.8796323058435 -67.7817160125226 32.9020837066791 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 200.004017201721 -418.653902038292 218.649884836571 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 40.2203524714889 -75.1276692085134 34.9073167370245 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 263.003424300897 -563.711967747639 300.708543446742 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 41.9883314452947 -71.9050400676935 29.9167086223988 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 302.514492688930 -524.598595792155 222.084103103226 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 30.0963778018843 -30.0971462869484 0.000768485064108561 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 217.069960249362 -413.152883555938 196.082923306577 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000751134457565102 -31.3893615901399 31.3886104556823 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 134.022659179270 -233.782946166821 99.7602869875509 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 21.4541122208560 -51.0386250707621 29.5845128499061 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 99.6910990344147 -99.6910990344147 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 29.5639947464560 -29.5639947464560 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
%             obj.baseAcc=[obj.baseAcc,-C*obs];
            obj.u=[obj.u,uu];
            subplot(3,1,1);
%             disp(obj.time);
%             disp(obj.observerState);
            plot(obj.time,obj.observerState);
            subplot(3,1,2);
            plot(obj.time, obj.u);
%             subplot(3,1,3);
%             plot(obj.time, obj.baseAcc);
            %             obj.fig=clf('reset');
            %             hold on;
            
            
            
            
            drawnow;
            %             hold off;
        end
    end
    
end