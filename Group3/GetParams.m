function params = GetParams(filename)
% Kyle Cleveland, minor changes Anton Orlichenko
%
% Read text file to acquire parameter values 
% 
% Parameters: beta, q, theta, sigma, nu, rho, alpha,
% gammaI, gammaA, lambda, deltaQ, gammaH, 
% 
% Contact Rate: c0, cb, r1
% Diagnosis Rate: deltaI0, deltaIF, r2
%
% This function can also read initial conditions and place them in a
% struct (actually any fields can be read and placed into a struct
% with an automatically generated appropriate fieldname)

% Get files

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% PROOF OF CONCEPT.... DELETE WHEN IMPLEMENTING INTO ACTUAL CODE  

%filename=["SampleParams","SampleParams copy","SampleParams copy 2"];
% for k = 1:length(filename)
%     param_files(k) = append(filename(k),'.txt');
% end

param_files = string(filename);

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

% Get number of files
N = length(param_files); 

% Read data from files, keep second column
for i = 1:N
    % Get data from text files 
    data = readtable(param_files(i),'Format','%s%s','ReadVariableNames', false);
    
    % Sort data
    data_sort = sortrows(data);
  
    % Save first (A) and second (B) data column to string cell arrays
    % NOTE: Data files need same number of rows to work
    A(:,1) = data_sort(:,1);
    B(:, i) = data_sort(:, 2);
end

% Convert to string cell array, to string maxtrix of parameter names 
params_name = string(table2array(A));

% Convert to string cell array, to string maxtrix, to decimal matrix 
% converting fractions to decimals) of parameter values
params_val = double(str2sym(string(table2array(B))));

% Get length of value matrix
D=length(params_val);

%Create struct for params allowing for use of multiple file input
params = struct();
for i = 1:D
    params.(params_name(i))=deal(params_val(i,:));
end

end

