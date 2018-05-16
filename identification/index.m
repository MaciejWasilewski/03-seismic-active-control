% xtemp=[ones(1,20)*x0(1),ones(1,20)*x0(2),ones(1,20)*x0(3)];
xtemp=xWithK2;
b=0.0258789062499991;
xWithK2=fminsearch(@(x)fitFunction([x(1:20),SimpleStiffnessCoeff',x(21:40)],2*pi*freq,amplitudes,false,elCentroData,AnsysResultsElCentro),xtemp,options);
% a=@(x)fitTransient([x(1:20),kk',x(21:40)],sf120,sf110,sf101,false);
% x222=fminsearch(@(x)a(x),xtemp,options);
% a2=@(x)fitTransient([x(1:20),kk',x(21:40)],sf120,sf110,sf101,true);

