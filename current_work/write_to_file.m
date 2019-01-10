mkdir('results');
d=10;
for i=1:1:length(results)
    mkdir(['results\',results{i}.fname]);
    csvwrite(['results\',results{i}.fname,'\disturbance.txt'],results{i}.disturbance(1:d:end,:));
    [fs, amps]=fft_amps(0.01,results{i}.disturbance(:,2));
    csvwrite(['results\',results{i}.fname,'\fft.txt'],[fs(1:1:end,:), amps(1:1:end,:)]);
    for j=1:1:length(results{i}.results)
        mkdir(['results\',results{i}.fname,'\',results{i}.results{j}.name]);
        csvwrite(['results\',results{i}.fname,'\',results{i}.results{j}.name,'\state.txt'],[results{i}.results{j}.time(1:d:end,:), results{i}.results{j}.state(1:d:end,:)]);
        temp=results{i}.results{j}.state*matC';
        csvwrite(['results\',results{i}.fname,'\',results{i}.results{j}.name,'\accels.txt'],[results{i}.results{j}.time(1:d:end,:), temp(1:d:end,:)]);
        csvwrite(['results\',results{i}.fname,'\',results{i}.results{j}.name,'\J.txt'],[results{i}.results{j}.time(1:d:end,:), results{i}.results{j}.J(1:d:end)']);
        csvwrite(['results\',results{i}.fname,'\',results{i}.results{j}.name,'\unorm.txt'],results{i}.results{j}.u_norm/results{i}.results{1}.u_norm);
        csvwrite(['results\',results{i}.fname,'\',results{i}.results{j}.name,'\Jnorm.txt'],results{i}.results{j}.J(end)/results{i}.results{1}.J(end));
    end
end