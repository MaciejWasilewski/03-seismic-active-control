function [all_results] =full_simulation( quakeHandle, dt, Tend,  matACont,matBCont, matC, Q, R,n,N, min_N ,rTerm, lqgRterm, flagTable)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
all_results=cell(1,3);
if(flagTable(1))
toClear_h_results=hinf_simulation(matACont,matBCont, matC, Q,R,dt,Tend, quakeHandle, rTerm);
all_results{3}=toClear_h_results;
end
if(flagTable(2))
toClear_adaptive_results=adaptive_simulation(matACont,matBCont, matC, Q,dt,Tend, quakeHandle, R,n,N, min_N );
all_results{1}=toClear_adaptive_results;
end
if(flagTable(3))
toClear_lqg_results = lqg_simulation(matACont,matBCont, matC, Q,R,dt,Tend, quakeHandle, lqgRterm);
all_results{2}=toClear_lqg_results;
end
% all_results={toClear_adaptive_results, toClear_lqg_results, toClear_h_results};
% all_results={toClear_h_results};

end

