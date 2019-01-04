classdef controlledBuilding<handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        anCon ansysConnector
        nodePositions
        elemNodes
        elemPos
        elemDefl
        directory
    end
    
    methods
        function d=getElemDefl(obj)
            d=obj.assignDim2El(obj.getDefOfNodes);
        end
        function obj=controlledBuilding(fname)
            obj.directory=fname;
            disp([obj.directory,'file.lock']);
            delete([fname,'file.lock']);
            delete(['D:\Program Files\Ansys\ANSYS Inc\v180\ansys\bin\winx64\','file.lock']);
            [~,~]=system('c:\Users\wasyl\Desktop\runAnsysAasMode.bat &');
            pause(10);
            
            obj.anCon=ansysConnector();
            obj.anCon.iCoMapdlUnit.executeCommand(['/CWD,',fname]);
            obj.time=0;
            obj.initializeStructure();
            obj.getPosOfNodes();
            obj.getElemNodes();
            obj.elemPos=obj.assignDim2El(obj.nodePositions);
        end
        function releaseAnsys(obj)
            obj.anCon.quit();
        end
        function executeFileAndSync(obj, fname)
            fileID = fopen([obj.directory,'fs.txt'],'w');
            while fileID < 0
                pause(0.02);
                %                 filename = input('Open file: ', 's');
                [fileID,err] = fopen([obj.directory,'getStateOfNodes.txt'],'w');
            end
            
            formatSpec = '%f';
            fprintf(fileID,formatSpec,0);
            fclose(fileID);
            %             [~,cmdout]=system(['wmic datafile where name="C:\\Users\\wasyl',...
            %                 '\\Documents\\MATLAB\\ansys\\clean\\ansysFiles\\fs.txt"',...
            %                 ' get LastModified | findstr /brc:[0-9]']);
            
            obj.anCon.iCoMapdlUnit.executeCommand(['/input,',fname]);
%             disp('a');
%             warning('something went wrong, I try again!');
%             obj.executeFileAndSync(fname);
            
            waitForFile(obj.directory);
        end
        function initializeStructure(obj)
            if exist([obj.directory,'geometry.db'], 'file')==2
                obj.anCon.iCoMapdlUnit.executeCommand('RESUME,geometry,db');
                obj.executeFileAndSync('setupSolution.txt');
            else
                obj.executeFileAndSync('geometryAndMesh.txt');
            end
        end
        function getPosOfNodes(obj)
            obj.executeFileAndSync('positionsOfNodes.txt');
            fileID = fopen([obj.directory,'positions.txt'],'r');
            formatSpec = '%f';
            tempArrray = fscanf(fileID,formatSpec,[2 inf]);
            fclose(fileID);
            obj.nodePositions=tempArrray';
            
        end
        function d=getDefOfNodes(obj)
            obj.executeFileAndSync('deflectionOfNodes.txt');
            fileID = fopen([obj.directory,'deflct.txt'],'r');
            while fileID < 0
                pause(0.05);
                fileID = fopen([obj.directory,'deflct.txt'],'r');
            end
            formatSpec = '%f';
            tempArrray = fscanf(fileID,formatSpec,[2 inf]);
            fclose(fileID);
            d=tempArrray';
            
        end
        function getElemNodes(obj)
            obj.executeFileAndSync('getNodesOfElements.txt');
            fileID = fopen([obj.directory,'elNodes.txt'],'r');
            while fileID < 0
                pause(0.02);
                fileID = fopen([obj.directory,'elNodes.txt'],'r');
            end
            formatSpec = '%f';
            tempArrray = fscanf(fileID,formatSpec,[2 inf]);
            fclose(fileID);
            obj.elemNodes=tempArrray';
            
        end
        function elpos=assignDim2El(obj,npos)
            elpos=zeros(size(obj.elemNodes, 1), 4);
            for i=1:1:size(obj.elemNodes, 1)
                elpos(i, 1)=npos(obj.elemNodes(i, 1), 1);
                elpos(i, 2)=npos(obj.elemNodes(i, 2), 1);
                elpos(i, 3)=npos(obj.elemNodes(i, 1), 2);
                elpos(i, 4)=npos(obj.elemNodes(i, 2), 2);
            end
        end
        function applyAcceleration(obj, valx, valy,valz)
            obj.anCon.iCoMapdlUnit.executeCommand('LSCLEAR,INER');
            obj.anCon.iCoMapdlUnit.executeCommand(['ACEL,',num2str(valx),',',num2str(valy),',',num2str(valz)]);
            
        end
        function applyForce(obj, node,valx, valy,valz)
            %             obj.anCon.iCoMapdlUnit.executeCommand('LSCLEAR,INER');
            obj.anCon.iCoMapdlUnit.executeCommand(['F,',num2str(node),',FX,',num2str(valx)]);%,',',num2str(valy),',',num2str(valz)]);
            obj.anCon.iCoMapdlUnit.executeCommand(['F,',num2str(node),',FY,',num2str(valy)]);
            obj.anCon.iCoMapdlUnit.executeCommand(['F,',num2str(node),',FZ,',num2str(valz)]);
        end
        %         function a=returnVel(obj, node)
        %             obj.anCon.iCoMapdlUnit.executeCommand(['*get,vex,NODE,',num2str(node),',v,X']);
        %             obj.anCon.iCoMapdlUnit.executeCommand(['*get,vey,NODE,',num2str(node),',v,Y']);
        %             obj.anCon.iCoMapdlUnit.executeCommand(['*get,vez,NODE,',num2str(node),',v,Z']);
        %             obj.executeFileAndSync('getVelOfNode.txt');
        %
        %             fileID = fopen('D:\Program Files\Ansys\ANSYS Inc\v180\ansys\bin\winx64\velNode.txt','r');
        %             formatSpec = '%f';
        %             tempArrray = fscanf(fileID,formatSpec,[3 1]);
        %             a=tempArrray';
        % %             disp(a);
        %             fclose(fileID);
        %
        %         end
        function a=returnState(obj, type, nodes)
            
            n=size(nodes,1);
            [fileID, err] = fopen([obj.directory,'getStateOfNodes.txt'],'w');
            while fileID < 0
                %                 disp(err);
                pause(0.02);
                %                 filename = input('Open file: ', 's');
                [fileID,err] = fopen([obj.directory,'getStateOfNodes.txt'],'w');
            end
            %             disp(fileID);
            fprintf( fileID, ['*del,tempp\r' newline '*dim,tempp,array,',num2str(n),',2\r',newline]);
            %             fprintf( fileID,'%s\n', []);
            
            switch type
                case 'velocity'
                    for i=1:1:n
                        fprintf( fileID, ['*SET,tempp(',num2str(i),',1),vx(',num2str(nodes(i)),')\r',newline]);
                        fprintf( fileID, ['*SET,tempp(',num2str(i),',2),vy(',num2str(nodes(i)),')\r',newline]);
                        %                 fprintf( fileID, ['*SET,temp(',num2str(i),',3),uz(',num2str(i),')\n']);
                    end
                case 'deflection'
                    for i=1:1:n
                        fprintf( fileID, ['*SET,tempp(',num2str(i),',1),ux(',num2str(nodes(i)),')\r',newline]);
                        fprintf( fileID, ['*SET,tempp(',num2str(i),',2),uy(',num2str(nodes(i)),')\r',newline]);
                        %                 fprintf( fileID, ['*SET,temp(',num2str(i),',3),uz(',num2str(i),')\n']);
                    end
                case 'accel'
                    for i=1:1:n
                        fprintf( fileID, ['*SET,tempp(',num2str(i),',1),ax(',num2str(nodes(i)),')\r',newline]);
                        fprintf( fileID, ['*SET,tempp(',num2str(i),',2),ay(',num2str(nodes(i)),')\r',newline]);
                        %                 fprintf( fileID, ['*SET,temp(',num2str(i),',3),uz(',num2str(i),')\n']);
                    end
            end
            fprintf( fileID, ...
                ['*cfopen,stateNode.txt\r',newline,...
                '*VWRITE,tempp(1,1),tempp(1,2)\r',newline,...
                '(F50.25,F50.25)\r',newline,'*cfclose\r',newline,...
                '/INPUT,forSync,txt']);
            fclose(fileID);
            %             obj.anCon.iCoMapdlUnit.executeCommand(['*get,vex,NODE,',num2str(node),',v,X']);
            %             obj.anCon.iCoMapdlUnit.executeCommand(['*get,vey,NODE,',num2str(node),',v,Y']);
            %             obj.anCon.iCoMapdlUnit.executeCommand(['*get,vez,NODE,',num2str(node),',v,Z']);
            obj.executeFileAndSync('getStateOfNodes.txt');
            
            fileID = fopen([obj.directory,'stateNode.txt'],'r');
            while fileID < 0
                disp(err);
                %                 filename = input('Open file: ', 's');
                [fileID,err] = fopen([obj.directory,'stateNode.txt'],'r');
            end
            formatSpec = '%f';
            tempArrray = fscanf(fileID,formatSpec,[2 inf]);
            a=tempArrray';
            %             disp(a);
            fclose(fileID);
            
        end
        function conductIntegration(obj, endTime)
            
            obj.anCon.iCoMapdlUnit.executeCommand('NSUBST,1,1,1');
            obj.anCon.iCoMapdlUnit.executeCommand(['TIME,',num2str(endTime)]);
            obj.executeFileAndSync('solve1step.txt');
            obj.time=endTime;
            %             obj.anCon.iCoMapdlUnit.executeCommand('LSCLEAR,all');
            %             obj.grabDeflection();
        end
        %         function grabDeflection(obj)
        %             obj.executeFileAndSync('deflectionOfNodes.txt');
        %             fileID = fopen([obj.directory,'deflct.txt'],'r');
        %             formatSpec = '%f';
        %             tempArrray = fscanf(fileID,formatSpec,[2 inf]);
        %
        %
        %             fclose(fileID);
        %             obj.elemDefl=obj.assignDim2El(tempArrray');
        %         end
        function startIntegration(obj)
            obj.executeFileAndSync('restartAnalysis.txt');
        end
        function data=getElemInitPos(obj)
            data=obj.elemPos;
        end
        %         function data=getElemDefl(obj)
        %             data=obj.elemDefl;
        %         end
        function delete(obj)
            obj.releaseAnsys();
            pause(5);
        end
    end
    
end
