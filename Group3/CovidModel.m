%% COVID Model
%{
Function passed to the ODE solver
Parameters are passed in a struct to avoid having 20 arguments

Parameters are:
- beta
- q
- theta
- sigma
%- e ... replaced by nu and rho
- nu
- rho
- alpha
- gammaI
- gammaA
- lambda
- deltaQ
- gammaH

For contact rate:
- c0
- cb
- r1

For diagnosis rate:
- deltaI0
- deltaIF
- r2

%}

function dNdt = CovidModel(t,N,params)

% Calculate decreasing contact rate at time t
ct = ContactRate(t, params);

% Calculate increasing diagnosis rate at time t
dt = DiagnosisRate(t, params);

% Reproduction ratio
% rt = ReproductionRatio(ct, dt, params);
% 
% figure
% subplot(3,1,1), plot(t, ct);
% subplot(3,1,2), plot(t, dt);
% subplot(3,1,3), plot(t, rt);

% Population numbers
S = N(1);
E = N(2);
I = N(3);
A = N(4);
Sq = N(5);
Eq = N(6);
H = N(7);
R = N(8); % Does not affect anything

% Model parameters
beta = params.beta;
q = params.q;
theta = params.theta;
lambda = params.lambda;
sigma = params.sigma;
rho = params.rho;
nu = params.nu;
alpha = params.alpha;
gammaI = params.gammaI;
gammaA = params.gammaA;
deltaQ = params.deltaQ;
gammaH = params.gammaH;

% ODE Model
dS = -(beta*ct + ct*q*(1-beta))*S*(I + theta*A + nu*E) + lambda*Sq;
dE = beta*ct*(1-q)*S*(I + theta*A + nu*E) - sigma*E;
dI = sigma*rho*E - (dt + alpha + gammaI)*I;
dA = sigma*(1-rho)*E - gammaA*A;
dSq = (1-beta)*ct*q*S*(I + theta*A + nu*E) - lambda*Sq;
dEq = beta*ct*q*S*(I + theta*A + nu*E) - deltaQ*Eq;
dH = dt*I + deltaQ*Eq - (alpha + gammaH)*H;
dR = gammaI*I + gammaA*A + gammaH*H;

dNdt = [dS;dE;dI;dA;dSq;dEq;dH;dR];
end