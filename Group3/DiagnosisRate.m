function dt = DiagnosisRate(t, params)
%% Diagnosis Rate
%
% Calculate increasing and saturating diagnosis rate
% as function of some Covid model parameters

dI0 = params.dI0;
dIF = params.dIF;
r2 = params.r2;

dt = 1./((1/dI0 - 1/dIF)*exp(-r2*t)+(1/dIF));
end