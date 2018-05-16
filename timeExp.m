classdef timeExp<numExp
    % timeExp This class encompass the whole logic of the simulation
    
    
    properties
        startTime double   % usually 0
        endTime double % end time of the simulation
        dt double   % discretization period
        contrObj controlledBuilding    % controlled object
        controllers     % array of the controllers (usually only one)
        sensors     % array of the sensors
        actuators   % array of the actuators
        disturbances % array of the disturbances
        vizualizers % array of the objects that visualize the state of the simulation
        resultsGrabbers % array of the objects that saves the results of the simulation
        time % current time of the simulation
    end
    
    methods
        function changeTime(obj,stop)
            obj.endTime=stop;
        end
        function obj=timeExp(stop, dt)
            %   syst=timeExp(Tend,dt) creates the simulation layout with the end
            %   time Tend and discretization dt
            %   rest of the properties are initialized as empty ceils.
            obj.startTime=0;
            obj.endTime=stop;
            obj.dt=dt;
            obj.controllers={};
            obj.sensors={};
            obj.actuators={};
            obj.disturbances={};
            obj.vizualizers={};
            obj.resultsGrabbers={};
            %             obj.contrObj=controlledBuilding();
        end
        function delete(obj)
            delete(obj.contrObj);
        end
        function conductExp(obj)
            % main method of the class, that is conduct of the whole
            % experiment
            
            % firstly, reset and initialize all contained objects
            for iv=1:1:length(obj.vizualizers)
                obj.vizualizers{iv}.resetViz();
            end
            for jc=1:1:length(obj.controllers)
                obj.controllers{jc}.reset();
            end
            for ja=1:1:length(obj.actuators)
                obj.actuators{ja}.reset();
            end
            t=obj.startTime:obj.dt:obj.endTime;
            obj.contrObj.startIntegration();
            tic;
            
            % for every time instant, conduct loop:
            for i=2:1:length(t)
                obj.time=t(i);
                disp(obj.time);
                for jd=1:1:length(obj.disturbances)
                    obj.disturbances{jd}.applyDisturbance();
                end
                % after the disturbance is applied, simulate one step of
                % the building
                obj.contrObj.conductIntegration(t(i));
                % grab sensors' measurements
                for js=1:1:length(obj.sensors)
                    obj.sensors{js}.conductMeasurement();
                end
                % generate new control value (and send it to actuators)
                for jc=1:1:length(obj.controllers)
                    obj.controllers{jc}.generateControl();
                end
                % apply force generated by actuators to the building
                for ja=1:1:length(obj.actuators)
                    obj.actuators{ja}.applyForce();
                end
                % vizualis
                for iv=1:1:length(obj.vizualizers)
                    obj.vizualizers{iv}.showResults();
                end
                for ir=1:1:length(obj.resultsGrabbers)
                    obj.resultsGrabbers{ir}.getResults();
                end
                
                % because simulation is lengthy, estimate time-to-end
                timeToEnd=(toc/(i-1)*(length(t)-i));
                hours=floor(timeToEnd/3600);
                minutes=floor((timeToEnd-hours*3600)/60);
                seconds=timeToEnd-hours*3600-minutes*60;
                disp(['End in ',num2str(hours),' h ', num2str(minutes), ' m ', num2str(seconds), ' s.']);
            end
            
        end
        function addObject(obj, contr)
            obj.contrObj=contr;
        end
        function addSensor(obj, sensor)
            obj.sensors{end+1}=sensor;
        end
        function addController(obj, controller)
            obj.controllers{end+1}=controller;
        end
        function deleteController(obj, i)
            obj.controllers(i)=[];
        end
        function addActuator(obj, actuator)
            obj.actuators{end+1}=actuator;
        end
        function addDisturbance(obj, dist)
            obj.disturbances{end+1}=dist;
        end
        function addVizualizer(obj, viz)
            obj.vizualizers{end+1}=viz;
        end
        function deleteVizualizer(obj, i)
            obj.vizualizers(i)=[];
        end
        function addResGrab(obj, res)
            obj.resultsGrabbers{end+1}=res;
        end
        function deleteResGrab(obj, i)
            obj.resultsGrabbers(i)=[];
        end
        function resultsCell=saveRes(obj)
            resultsCell=cell(size(obj.resultsGrabbers, 1),1);
            for ir=1:1:size(obj.resultsGrabbers, 1)
                disp(ir);
                resultsCell{ir,1}=obj.resultsGrabbers{ir}.storeResults();
            end
        end
    end
    
end

