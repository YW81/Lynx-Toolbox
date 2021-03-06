
% INFO_PREPROCESSORS Generate an HTML report on the available preprocessors

% License to use and modify this code is granted freely without warranty to all, as long as the original author is
% referenced and attributed as such. The original author maintains the right to be solely associated with this work.
%
% Programmed and Copyright by Simone Scardapane:
% simone.scardapane@uniroma1.it

preprocessors = class_filter(fullfile(XmlConfiguration.getRoot(), 'functionalities/Preprocessors/'), 'Preprocessor');
fprintf('Generating report...\n');

try
    report('templates/Available Preprocessors.rpt', '-quiet');
catch err
    if(strcmp(err.identifier, 'MATLAB:UndefinedFunction'))
        error('Lynx:Runtime:ToolboxNotInstalled', 'You need the MATLAB Report Generator to create the HTML report.');
    else
        error(err);
    end
end