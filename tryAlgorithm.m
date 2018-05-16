% This script conducts the dynamic simulation simulation of the seismically
% excited building for Tend seconds with the discretization period dt.
% Because the simulation with the interface between Matlab and Ansys is
% prone to the errors (I don't know why and honestly I don't want to), the
% script is being invoked until it succeeds to conduct the whole
% simulation.
try
    % if the object 'syst' (that is in charge of the whole simulation)
    % exists (for instance from the previous run), delete it.
    if exist('syst')==1
        delete(syst);
        pause(5);
    end
    % dt - discretization period
    dt=0.01;
    % Tend - final time of the simulation
    Tend=100;
    % this object is in charge of the whole simulation
    syst=timeExp(Tend,dt);
    % this array contains nodes of the subsequent floor of the buildin
    floorNodes=[2 10 23 32 41 50;85 86 90 94 98 102;...
        106 107 111 115 119 123;127 128 132 136 140 144;148 149 153 157 161,...
        165;169 170 174 178 182 186;190 191 195 199 203 207;211 212 216 220, ...
        224 228;232 233 237 241 245 249;253 254 258 262 266 270;274 275, ...
        279 283 287 291;295 296 300 304 308 312;316 317 321 325 329 333;337 338 342 346 350 354;358 359 363 367 371 375;379 380 384 388 392 396;400 401 405 409 413 417;421 422 426 430 434 438;442 443 447 451 455 459;463 464 468 472 476 480;484 485 489 493 497 501];
    % the object to simulate is the controlled building with ansys scripts
    % that defines it placed in folder '../ansysFiles/'
    syst.addObject(controlledBuilding('../ansysFiles/'));
    % earthquake - Nx4 array, column 1 is the time, columns 2-4 is the X,
    % Y, Z acceleration of the considered earthquake
    earthquake=zeros(length(elCentroData(1,:)),4);
    earthquake(:,1)=elCentroData(1,:);
    earthquake(:,2)=-(elCentroData(2,:))';
    syst.addDisturbance(groundAcceleration(earthquake,syst.contrObj));
    % the building is controlled by the means of hydraulic actuators
    syst.addActuator(hydraulicActuators(floorNodes(2:end, :), syst.contrObj));
    % on each floor, the accelerometer is placed
    for i=1:1:20
        syst.addSensor(accelerometer(100,0,floorNodes(i+1,1),syst.contrObj));
    end
    % additional accelerometer that measures acceleration of the ground
    syst.addSensor(baseAccelerometer(syst.disturbances{1}));
    % our control algorithm
    syst.addController(controller(syst.actuators,syst.sensors(1:20),syst.sensors{21},9,750,35, syst.contrObj));
    % this object is used to produce real-time plot of the simulation state
    syst.addVizualizer(realTimeStatePlot(syst.contrObj, floorNodes([2,11,21],1)));
    % syst.addVizualizer(realTimeControllerPlot(syst.contrObj, syst.controllers{1}));
    % object to save the course of the simulation
    syst.addResGrab(stateSaver(floorNodes,syst.contrObj,syst,'1'));
    
    % path and filename of the file that stores the results. Unfortunately
    % I do not remember why the save to a file has to be invoked in such a
    % strange way (see stateSaver->getResults() method). For future
    % consideration.
    fname='../data/algorithm.mat';
    
    % after the whole simulation is set, conduct it.
    syst.conductExp();
catch err
%      warning(err);
     tryAlgorithm;
    
end