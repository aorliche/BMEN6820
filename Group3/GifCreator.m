function GifCreator(gifFilename, paramFilename, icFilename,...
    changeParamField,  tend, outPopulationIdx, curveValues)

%   Create gif from varying parameter value (can be any parameter)
%   Kyle Cleveland, minor modifications by Anton

% Usage:
%   GifCreator('myGif.gif', 'Params/BasicModel.txt',...
%       'ICs/BasicModel_ICs.txt', 'alpha', 100, 9, linspace(0,0.01,5));
%   GifCreator('myGif.gif', 'Params/BasicModel.txt',...
%       'ICs/BasicModel_ICs.txt', 'c0', 100, 3, linspace(13,5,9));

% Get params and ICs
params = GetParams(paramFilename);
ics = GetParams(icFilename);

% Build N0
params.S0 = ics.S0;
N0 = [ics.S0, ics.E0, ics.I0, ics.A0, ics.Sq0, ics.Eq0, ics.H0, ics.R0, ics.D0];

% Get population name
if length(outPopulationIdx) ~= 1 ||...
        outPopulationIdx < 1 || outPopulationIdx > 9
    disp('Invalid population index');
    return;
end

pops = {'Susceptible', 'Exposed', 'Infected', 'Asymptomatic',...
    'Quarantined Susceptible', 'Quarantined Exposed',...
    'Hospitalized', 'Recovered', 'Deceased'};
popName = string(pops(outPopulationIdx));
    
% Plot the variable against infected (or some other) population
h=figure; hold on;
title(sprintf('Effect of Changing %s on %s Population',changeParamField,popName),...
    'fontweight','bold','fontsize',16);
axis tight

for i = 1:length(curveValues)
    % Change Param Value
    params.(changeParamField) = curveValues(i);
    
    % Run model
    [t,N] = ode45(@CovidModel, [0, tend], N0, [], params);
    
    % Update curve name
    txt_legend = string([changeParamField,' = ',num2str(params.(changeParamField))]);
    
    % Plot curve
    plot(t,N(:,outPopulationIdx),'DisplayName',txt_legend);
    
    drawnow
    
    % Axis labels
    xlabel('Time (days)','fontweight','bold','fontsize',12);
    ylabel(popName,'fontweight','bold','fontsize',12);
    
    % Display legend
    legend show
    
    % Capture the plot as an image 
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if i == 1 
        imwrite(imind,cm,gifFilename,'gif', 'Loopcount',inf); 
    else 
        imwrite(imind,cm,gifFilename,'gif','WriteMode','append'); 
    end 
    
end

hold off;
end

