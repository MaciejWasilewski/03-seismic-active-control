mkdir('results');
addpath('../control');
d=10;
for i=1:1:length(results)
    sdir=fullfile('results',results{i}.fname);
    mkdir(sdir);
    csvwrite(fullfile(sdir,'disturbance.txt'),results{i}.disturbance(1:d:end,:));
    [fs, amps]=fft_amps(0.01,results{i}.disturbance(:,2));
    csvwrite(fullfile(sdir,'fft.txt'),[fs(1:1:end,:), amps(1:1:end,:)]);
    criteria=[];
    alg_crit=[];
    for j=1:1:length(results{i}.results)
        algDir=fullfile(sdir,results{i}.results{j}.name);
        mkdir(algDir);
        csvwrite(fullfile(algDir,'state.txt'),...
            [results{i}.results{j}.time(1:d:end,:), ...
            results{i}.results{j}.state(1:d:end,:)]);
        csvwrite(fullfile(algDir,'stateMax.txt'),...
            [results{i}.results{j}.time(1:d:end,:), ...
            max(abs(results{i}.results{j}.state(1:d:end,1:20)),[],2)]);
        temp=diff(...
            results{i}.results{j}.state(1:end,21:40),1,1)./diff(results{i}.results{j}.time(1:end,:),1,1);
%         results{i}.results{j}.state*matC';
        csvwrite(fullfile(algDir,'accels.txt'),...
            [results{i}.results{j}.time(1:d:end-1,:), temp(1:d:end,:)]);
        temp=max(abs(temp),[],2);
        csvwrite(fullfile(algDir,'accelsMax.txt'),...
            [results{i}.results{j}.time(1:d:end-1,:), temp(1:d:end,:)]);
        csvwrite(fullfile(algDir,'J.txt'),[results{i}.results{j}.time(1:d:end,:), results{i}.results{j}.J(1:d:end)']);
        csvwrite(fullfile(algDir,'unorm.txt'),results{i}.results{j}.u_norm/results{i}.results{1}.u_norm);
        csvwrite(fullfile(algDir,'Jnorm.txt'),results{i}.results{j}.J(end)/results{i}.results{1}.J(end));        
        criteria=[criteria,evalCrit(results{i}.results{j}.state(1:end,:)',results{i}.results{j}.time(1:end,:)',diag(matMass)')];
        if(strcmp(results{i}.results{j}.name,'Adaptive'))
            alg_crit=criteria(:,end);
        end
        csvwrite(fullfile(algDir,'criteria.txt'),criteria(:,end));
        end
        csvwrite(fullfile(sdir,'full_criteria.txt'),criteria./alg_crit);
end