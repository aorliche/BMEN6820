%% Reproductive Rate
%{
Calculate daily reproduction ratio as a function of 
- ct: contact rate
- dt: diagnosis rate
and other parameters of Covid model.
%}
function rt = ReproductionRatio(ct, dt, params)
beta = params.beta;
%e = params(1).e;
rho = params.rho;
q = params.q;
theta = params.theta;
alpha = params.alpha;
gammaI = params.gammaI;
gammaA = params.gammaA;
S0 = params.S0;

rt = beta*rho*ct*(1-q)./(dt+alpha+gammaI) + beta*ct*theta*(1-rho)*(1-q)/gammaA;
rt = rt * S0;
end