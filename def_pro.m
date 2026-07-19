function [pro_struct] = def_pro(pro_name, varargin)

%% This function define project directory and mane a copy of script with current settings
%
% - inputs:
% pro_name: name of the project something
%
% - optional:
% saveWork: flag for making a copy of scripts
% loadEEGLAB: add EEGLab's folder to the path

% -- read input parameters
import_params(varargin);

% -- set manitory flags
if ~exist('saveWork', 'var')
    pro_struct.saveWork = false;
else
    pro_struct.saveWork = saveWork;
end

if ~exist('loadEEGLAB', 'var')
    pro_struct.loadEEGLAB = false;
else
    pro_struct.loadEEGLAB = loadEEGLAB;
end

% -- name of the main function
fname = dbstack;
pro_struct.function_name = fname(2).name;

pro_struct.pro_name = pro_name;

% -- read local configuration file
A = textread('local_settings.config', '%s', 'whitespace', '');
eval(A{:});

% -- add nessery folders to path
pro_struct.NIN_path = NINpath;
addpath(genpath(pro_struct.NIN_path));
if pro_struct.loadEEGLAB
    pro_struct.EEGLAB_path = EEGLABpath;
    addpath(pro_struct.EEGLAB_path);
end

% -- current date and time
cdate = nin_ctime('outFormat', 'date');
chour = nin_ctime('outFormat', 'time');
ctime = nin_ctime;

if pro_struct.saveWork
    
    % -- create folders for backup
    pro_struct.archive_path = [pwd, filesep, 'code_archive', filesep, pro_struct.function_name, '_', pro_struct.pro_name, filesep, cdate, filesep];
    
    pro_struct.archive_NIN_path = [pro_struct.archive_path, 'NIN_', chour, filesep];
    if ~isfolder(pro_struct.archive_NIN_path)
        mkdir(pro_struct.archive_NIN_path)
    end
    
    % -- backup scripts
    if pro_struct.saveWork
        copyfile(pro_struct.NIN_path, pro_struct.archive_NIN_path);
        copyfile([pwd filesep pro_struct.function_name '.m'], [pro_struct.archive_path, pro_struct.function_name, '_', pro_struct.pro_name, '_', ctime, '.m']);
    end
    
end

end

function import_params(oinputs)
for kv = 1:2:length(oinputs)
    assignin('caller', oinputs{kv}, oinputs{kv+1})
end
end