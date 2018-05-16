% The logic of this script is in general the same as the 'tryAlgorithm.m'
try
    if exist('syst')==1
        delete(syst);
        pause(5);
    end
    
    dt=0.01;
    Tend=100;
    syst=timeExp(Tend,dt);
    floorNodes=[2 10 23 32 41 50;85 86 90 94 98 102;...
        106 107 111 115 119 123;127 128 132 136 140 144;148 149 153 157 161,...
        165;169 170 174 178 182 186;190 191 195 199 203 207;211 212 216 220, ...
        224 228;232 233 237 241 245 249;253 254 258 262 266 270;274 275 279 283 287 291;295 296 300 304 308 312;316 317 321 325 329 333;337 338 342 346 350 354;358 359 363 367 371 375;379 380 384 388 392 396;400 401 405 409 413 417;421 422 426 430 434 438;442 443 447 451 455 459;463 464 468 472 476 480;484 485 489 493 497 501];
    syst.addObject(controlledBuilding('../ansysFiles/'));
    earthquake=zeros(length(elCentroData(1,:)),4);
    earthquake(:,1)=elCentroData(1,:);
    earthquake(:,2)=-(elCentroData(2,:))';
    syst.addDisturbance(groundAcceleration(earthquake,syst.contrObj));
    syst.addActuator(hydraulicActuators(floorNodes(2:end, :), syst.contrObj));
    for i=1:1:20
        syst.addSensor(accelerometer(100,0,floorNodes(i+1,1),syst.contrObj));
    end
    syst.addSensor(baseAccelerometer(syst.disturbances{1}));
    syst.addController(LQRController(syst.actuators,syst.sensors(1:20),syst.sensors{21}, syst.contrObj));
    syst.addVizualizer(realTimeStatePlot(syst.contrObj, floorNodes([2,11,21],1)));
    syst.addVizualizer(realTimeControllerPlot(syst.contrObj,syst.controllers{1}));
    syst.addResGrab(stateSaver(floorNodes,syst.contrObj,syst,'1'));
    
    fname='../data/lqr.mat';
    syst.conductExp();
catch err
    warning(err.message);
    tryLQR;
    
end