function rt = ReproductionRatio(ct, dt, params)
%% Reproduction Ratio
% Calculate daily reproduction ratio as a function of 
% - ct: contact rate
% - dt: diagnosis rate
% and other parameters of Covid model.

beta = params.beta;
%e = params(1).e;
nu = params.nu;
rho = params.rho;
sigma = params.sigma;
q = params.q;
theta = params.theta;
alpha = params.alpha;
gammaI = params.gammaI;
gammaA = params.gammaA;
S0 = params.S0;

rt = beta*rho*ct*(1-q)./(dt+alpha+gammaI) + beta*ct*theta*(1-rho)*(1-q)/gammaA +...
    beta*ct*nu*(1-q)./sigma;
rt = rt * S0;
end