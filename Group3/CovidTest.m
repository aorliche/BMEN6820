%% Covid model test

params = struct();

% Contact rate
params.c0 = 13; %14.781;
params.cb = 13; %2.9253;
params.r1 = 1.3768;

% Diagnosis rate
params.deltaI0 = 0.1382; %0.13266;
params.deltaIF = 0.1382; %1/0.3654;
params.r2 = 0.3283;

% Reproduction ratio
params.beta = 2.0389e-9; %2.1011e-8;
%params(1).e = 1.5008; %0.86834; % Also called rho in second paper
params.rho = 0.6834; % Replaces E in second paper
params.nu = 1.5008; % New in second paper
params.q = 2e-6; %1.8877e-7; %1.2858e-5;
params.theta = 1.6003;
params.alpha = 0.0009; %1.7826e-5;
params.gammaI = 0.1029; %0.33029;
params.gammaA = 0.2978; %0.13978;

% Full model
params.lambda = 1/14;
params.sigma = 1/5; %1/7;
params.deltaQ = 0.1259;
params.gammaH = 0.1024; %0.11624;

% Initial Conditions
params.S0 = 11081000;
E0 = 600;
I0 = 410;
A0 = 30;
Sq0 = 739;
Eq0 = 20;
H0 = 41;
R0 = 2; 

tend = 100;
N0 = [params(1).S0, E0, I0, A0, Sq0, Eq0, H0, R0];

[t,N] = ode45(@CovidModel, [0, tend], N0, [], params);

figure;
subplot(3,1,1);
plot(t,N(:,1));
xlabel('time (days)');
ylabel('susceptibles');

subplot(3,1,2);
plot(t,N(:,2));
xlabel('time (days)');
ylabel('exposed');

subplot(3,1,3);
plot(t,N(:,3));
xlabel('time (days)');
ylabel('infected');