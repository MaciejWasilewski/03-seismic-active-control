function [all_results] =full_simulation( quakeHandle, dt, Tend,  matACont,matBCont, matC, Q, R,n,N, min_N )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
toClear_h_results=hinf_simulation(matACont,matBCont, matC, Q,dt,Tend, quakeHandle, 0.0014 );
toClear_adaptive_results=adaptive_simulation(matACont,matBCont, matC, Q,dt,Tend, quakeHandle, R,n,N, min_N );
toClear_lqg_results = lqg_simulation(matACont,matBCont, matC, Q,R,dt,Tend, quakeHandle);
all_results={toClear_adaptive_results, toClear_lqg_results, toClear_h_results};

end

