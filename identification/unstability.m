n=4;
f_rate=0.1;
close;
modified_params=[1*xWithK3(1:20), 1.5*xWithK3(21:end)*1];
[A0, B0, ~, M0, K0, C0]=buildingModel([SimpleStiffnessCoeff',modified_params]);
R=10^(0)*eye(20);
C=[-M0\K0,M0\C0];
Q=1/2*[K0, zeros(20);zeros(20), M0];
% [~,L, ~]=kalman(ss(A0,B0,C,zeros(20,20)),0.000001*eye(20), 1*eye(20));
% lc=L*C;
lc=eye(40);
KLQR=lqr(A0, B0, Q, R);
KLQR=KLQR*lc;

P0=lyap((A0-B0*KLQR)', Q);
trp=trace(P0);
disp(trp);
floors=1:1:20;
fails=nchoosek(floors,n);
traces=zeros(size(fails, 1), 1);
initial_vec=zeros(40, size(fails, 1));
max_diff=zeros(1, size(fails, 1));
for i=1:1:size(fails, 1)
    %     disp(i/size(fails, 1)*100);
    s1=SimpleStiffnessCoeff;
    p1=modified_params;
    for j=1:1:size(fails, 2)
        s1(fails(i, j))=f_rate*s1(fails(i, j));
        p1(20+fails(i, j))=f_rate*p1(20+fails(i, j));
    end
    [A1, B1, ~, ~, ~, ~]=buildingModel([s1',p1]);
    max_pole=max(real(eig(A1-B1*KLQR)));
    if max_pole>0
        disp(['niestabilny przy: ', num2str(i)]);
        disp(max_pole);
    else
        P1=lyap((A1-B1*KLQR)', Q);
        traces(i)=(trace(P1)/trp);
        [V, D]=eigs(P1-P0);
        [m, elem]=max(diag(D));
        initial_vec(:,i)=V(:,elem);
        max_diff(i)=m;
        %         disp(['slad: ', num2str(trace(lyap((A1-B1*KLQR)', Q))/trp)])
    end
end

[m, floor_index]=max(max_diff);
% disp(m);
% disp(initial_vec(:,i));
s1=SimpleStiffnessCoeff;
p1=xWithK3;
for j=1:1:size(fails, 2)
    s1(fails(floor_index, j))=f_rate*s1(fails(floor_index, j));
    p1(20+fails(floor_index, j))=f_rate*p1(20+fails(floor_index, j));
end
[A1, B1, ~, ~, ~, ~]=buildingModel([s1',p1]);
[t1, y1]=ode45(@(t, y)([(A1-B1*KLQR)*y(1:end-1);(y(1:end-1))'*Q*y(1:end-1)]),[0,17000],[0.01*initial_vec(:,floor_index);0]);
[t0, y0]=ode45(@(t, y)([(A0-B0*KLQR)*y(1:end-1);(y(1:end-1))'*Q*y(1:end-1)]),[0,17000],[0.01*initial_vec(:,floor_index);0]);
figure;
subplot(1,2,1);
plot(t0, y0(:, end), 'b',t1, y1(:, end), 'r');
subplot(1,2,2);
plot(t0, y0(:, 20), 'b',t1, y1(:, 20), 'r');
disp(y1(end, end)/y0(end, end));

deflect0=zeros(length(t0), 20);
for i=1:1:20
   deflect0(:,i)=y0(:,i+1)-y0(:,i);
end

deflect1=zeros(length(t1), 20);
for i=1:1:20
   deflect1(:,i)=y1(:,i+1)-y1(:,i);
end

[r0, c0]=find(deflect0>0.1*2.5);
max(r0)

[r1, c1]=find(deflect1>0.1*2.5);
max(r1)