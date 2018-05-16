iter=24:4:40;
iter=0.002*ones(size(iter))./iter;
p2=zeros(size(iter));
for i=1:1:length(iter)
    disp(i);
    R=eye(20)*iter(i);
    simulateLQR;
    [Jalg,~,~,~]=costD(100,dt,750,9,Q,R,A,B,D,A_d,B_d,D_d,elCentroData);
    Jlqr,Jlqg,Jalg
    p2(i)=Jalg/min(Jlqr,Jlqg)
    
end