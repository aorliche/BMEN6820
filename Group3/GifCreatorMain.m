function GifCreatorMain
% Simple Wizard for creating an animated Gif file
%
%   Kyle Cleveland, minor changes by Anton

% Get filenames
gifFilename = input('Enter name of gif file: ', 's');
paramFilename = input('Enter path to params file: ', 's');
params = GetParams(paramFilename);  % Try to load to make sure filename correct

icFilename = input('Enter path to ICs file: ', 's');
ics = GetParams(icFilename);        % Try to load to make sure filename correct

% Get param field which is changing
changeParamField = input('Enter name of field to vary: ','s');
TF = isfield(params,changeParamField);
while TF==0 % check variable exists
    input('Invalid Entry...\nEnter name of field to vary: ','s');
    TF = isfield(params,changeParamField);
end

% Get range for variable
range_in = input('Enter initial value for range: ');
range_fin = input('Enter final value for range: ');

% Get number of curves
num_curves = input('Enter number of curves: ');
while num_curves<0 || round(num_curves)~=num_curves % check value 
    num_curves = input('Invalid Entry...\nEnter correct value for number of curves: ');
end

curveValues = linspace(range_in,range_fin,num_curves); % Set range of variable values 

% Get length of simulation
tend = input('Enter length of simulation (days): ');
if tend < 1 || tend > 10000
    disp('Invalid simulation length, must be between 1 and 10000');
    tend = input('Enter length of simulation (days): ');
end

% Get which population to plot
popIndex = input('Enter index of population vector to plot (1-9): ');
if popIndex < 1 || popIndex > 9
    disp('Invalid population index, must be between 1 and 9');
    popIndex = input('Enter index of population vector to plot (1-9): ');
end

% Call the function
GifCreator(gifFilename, paramFilename, icFilename, changeParamField,...
    tend, popIndex, curveValues);
end

