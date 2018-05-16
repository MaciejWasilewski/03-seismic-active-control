import casadi.*
addpath('C:\Users\wasyl\Documents\MATLAB\casadi-matlabR2014a-v3.1.1');
T=100;
N=T*50;
t=0:T/N:T-T/N;
casA=SX(A);
% casB=SX(B20);
casB=SX(B);
casD=SX(D);
casX=SX.sym('x',40,1);
sizU=20;
casU = SX.sym('u',sizU,1);
casQ=SX(Q);
casR=SX(R);

% disp(casA*casB);
casErthq=SX.sym('e');
xdot = casA*casX+casB*casU+casD*casErthq;
% L=casX'*casQ*casX+casU'*casR*casU;
L=casX'*casQ*casX;
maxU=2*10^5;
% disp(L);
casf = Function('casf', {casX, casU, casErthq}, {xdot, L});
M = 20; % RK4 steps per interval
DT = T/N/M;
X0 = MX.sym('X0', 40);
U = MX.sym('U',sizU);
Erthq=MX.sym('e');
X = X0;
q=0;
for j=1:M
    [k1, k1_q] = casf(X, U,Erthq);
    [k2, k2_q] = casf(X + DT/2 * k1, U,Erthq);
    [k3, k3_q] = casf(X + DT/2 * k2, U,Erthq);
    [k4, k4_q] = casf(X + DT * k3, U,Erthq);
    X=X+DT/6*(k1 +2*k2 +2*k3 +k4);
    q = q + DT/6*(k1_q + 2*k2_q + 2*k3_q + k4_q);
end
F = Function('F', {X0, U,Erthq}, {X, q}, {'x0','p','ac'}, {'xf', 'qf'});

% Evaluate at a test point
Fk = F('x0',zeros(40,1),'p',ones(sizU,1),'ac',0);
disp(Fk.xf)
disp(Fk.qf)
% Start with an empty NLP
w={};
w0 = [];
lbw = [];
ubw = [];
J = 0;
g={};
lbg = [];
ubg = [];

% "Lift" initial conditions
X0 = MX.sym('X0', 40);
w = {w{:}, X0};
lbw = [lbw; zeros(40,1)];
ubw = [ubw; zeros(40,1)];
w0 = [w0; zeros(40,1)];


% Formulate the NLP
Xk = X0;
for k=0:N-1
    % New NLP variable for the control
    Uk = MX.sym(['U_' num2str(k)],sizU);
    w = {w{:}, Uk};
    %     lbw = [lbw; -inf*ones(sizU,1)];
    %     ubw = [ubw;  inf*ones(sizU,1)];
    lbw = [lbw; -maxU*ones(sizU,1)];
    ubw = [ubw;  maxU*ones(sizU,1)];
    w0 = [w0;  zeros(sizU,1)];
    
    % Integrate till the end of the interval
    Fk = F('x0', Xk, 'p', Uk,'ac',elCentroData(2,min(2502,(floor(k/N*T*50)+1))));
    Xk_end = Fk.xf;
    J=J+Fk.qf;
    
    % New NLP variable for state at end of interval
    Xk = MX.sym(['X_' num2str(k+1)], 40);
    w = {w{:}, Xk};
    lbw = [lbw; -inf*ones(40,1)];
    ubw = [ubw;  inf*ones(40,1)];
    w0 = [w0; zeros(40,1)];
    
    % Add equality constraint
    g = {g{:}, Xk_end-Xk};
    lbg = [lbg; zeros(40,1)];
    ubg = [ubg; zeros(40,1)];
end

% Create an NLP solver
prob = struct('f', J, 'x', vertcat(w{:}), 'g', vertcat(g{:}));
solver = nlpsol('solver', 'ipopt', prob);

% Solve the NLP
sol = solver('x0', w0, 'lbx', lbw, 'ubx', ubw,...
    'lbg', lbg, 'ubg', ubg);
w_opt = full(sol.x);