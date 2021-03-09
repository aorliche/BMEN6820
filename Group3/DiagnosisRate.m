%% Diagnosis Rate
%{
Calculate increasing and saturating diagnosis rate
as function of some Covid model parameters
%}
function dt = DiagnosisRate(t, params)
deltaI0 = params.deltaI0;
deltaIF = params.deltaIF;
r2 = params.r2;

dt = 1./((1/deltaI0 - 1/deltaIF)*exp(-r2*t)+(1/deltaIF));
end