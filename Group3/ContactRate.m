function ct = ContactRate(t, params)
%% Contact Rate
%
% Calculate daily contact rate as a function of a few
% Covid model parameters.

c0 = params.c0;
cb = params.cb;
r1 = params.r1;

ct = (c0-cb)*exp(-r1*t)+cb;
end