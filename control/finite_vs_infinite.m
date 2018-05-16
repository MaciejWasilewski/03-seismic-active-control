l=100;
finite_times=zeros(l,1);
infinite_times=zeros(l,1);

for i=1:1:l
    tic;
    dare(ad, bd, eye(60),eye(20));
    a=toc;
    infinite_times(i)=a;
    tic;
    lqr_discr_finite(ad, bd, eye(60),eye(20),5000);
    a=toc;
    finite_times(i)=a;
end

disp(mean(finite_times));
disp(std(finite_times));
disp(mean(infinite_times));
disp(std(infinite_times));