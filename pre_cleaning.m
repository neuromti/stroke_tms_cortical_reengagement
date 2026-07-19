% -------------------------------------------------------------------------
%  Project: INTENS 2019
%  Task:    EEG cleaning data
% -------------------------------------------------------------------------

% -- clear workspace, close all figures, and clear command window
clear all; close all; clc;

% -- initialize project settings and enable saving of results
pout = def_pro('IA_23a', 'saveWork', false, 'loadEEGLAB', true);

%% -- define EEG system

eegsys = nin_eeg_system('BrainVision');

%% -- diary and load eeglab

if pout.saveWork

    time = strsplit(pout.archive_NIN_path, filesep);
    time = time{contains(time, 'NIN')};
    diary([pout.archive_path, 'softare_version', strrep(time, 'NIN', ''), '.txt'])

    %% -- load EEGLAB

    if pout.loadEEGLAB

        eeglab;

        % -- store info about version
        desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
        cmdWindow = desktop.getClient('Command Window');
        cmdWindowScrollPane = cmdWindow.getComponent(0);
        cmdWindowScrollPaneViewport = cmdWindowScrollPane.getComponent(0);
        cmdTextUI = cmdWindowScrollPaneViewport.getComponent(0);
        cmdText = cmdTextUI.getText;
        EEGLABv = cmdText;
        clear desktop cmdWindow cmdWindowScrollPane cmdWindowScrollPaneViewport cmdTextUI cmdText

    else

        EEGLABv = '';

    end

    % -- display current MATLAB version
    disp(['Matlab ', version]);

    diary off

end

%% -- define input parameters

% -- main directory containing subject folders and XDF files
pout.path_in = {'/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/data_out/Raw_HC_2023_03_14/';...
    '/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/data_out/Raw_ST_2023_03_10/'};

% -- base output directory
pout.path_out = '/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/data_out/';

% -- base supplementary directory
pout.path_supplementary = '/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/Supplementary/';
pout.tms_file = 'TMS_pulses';

%% -- create data out folder

% -- generate current timestamp
ctime = nin_ctime;

% -- create timestamped output directory
pout.path_out = [pout.path_out, 'Cleaned_', pout.pro_name, filesep];
if ~exist(pout.path_out, 'dir') && pout.saveWork
    mkdir(pout.path_out);
end

%% -- features for TESA

% -- settings for cleaning function
musle_artifacts_features = {'compCheck', 'off',... %    'comps', 15, ...
    'figSize', 'small',...
    'plotTimeX', [-200 500],...
    'plotFreqX', [1 100],...
    'tmsMuscle', 'on',...
    'tmsMuscleThresh', 8,...
    'tmsMuscleWin', [11 30],...
    'tmsMuscleFeedback', 'off',...
    'blink', 'off',...
    'blinkThresh', 2.5,...
    'blinkElecs', {'Fp1','Fp2'},...
    'blinkFeedback', 'off',...
    'move', 'off',...
    'moveThresh', 2,...
    'moveElecs', {'F7','F8'},...
    'moveFeedback', 'off',...
    'muscle', 'off',...
    'muscleThresh', 0.6,...
    'muscleFreqWin', [30 100],...
    'muscleFreqIn', [31,100],...
    'muscleFeedback', 'off',...
    'elecNoise', 'off',...
    'elecNoiseThresh', 4,...
    'elecNoiseFeedback', 'off'};

tms_win = [-5 10];
tms_win_e = [-5 15];

%% -- compute the total number of files
k = 1;
N = 0;
while k <= length(pout.path_in)
    fileList = dir([pout.path_in{k}, '*.mat' ]);
    fileList = {fileList.name};
    fileList = fileList(~contains(fileList, 'transfer_report.mat'));
    N = N + length(fileList);
    k = k + 1;
end

TMS = [];
ks = 1;
k = 1;
while k <= length(pout.path_in)

    %% -- cleaning data subject by subject

    % -- get all folders from the main directory
    fileList = dir([pout.path_in{k}, '*.mat' ]);
    fileList = {fileList.name};
    fileList = fileList(~contains(fileList, 'transfer_report.mat'));

    k2 = 1;
    while k2 <= length(fileList)

        x(ks).path_in =  pout.path_in{k};
        x(ks).filename_in = fileList{k2};
        disp(['Loading file ', num2str(ks), filesep, num2str(N)]);

        try

            %% -- load data

            load([x(ks).path_in, x(ks).filename_in]);

            % -- initialize output structure
            cdata = rdata;
            cTMS = table([cdata.lmarkers.index], [cdata.lmarkers.tphase], 'VariableNames', {'stimuli', 'tphase'});
            cTMS = table2struct(cTMS);
            [cTMS.sub] = deal(char(nin_strsplit({x(ks).filename_in}, 3, 3, 'spliter', '_')));
            if contains(x(ks).path_in, 'HC')
                [cTMS.Condition] = deal('HC');
            else
                [cTMS.Condition] = deal('ST');
            end
            [cTMS.session] = deal(strrep(char(nin_strsplit({x(ks).filename_in}, 4, 4, 'spliter', '_')), '.mat', ''));
            [cTMS.tfreq] = deal(20);
            [cTMS.valid] = deal(true);
            [cTMS.filename] = deal(x(ks).filename_in);
            [cTMS.stimulation] = deal(strrep(char(nin_strsplit({x(ks).filename_in}, 2, 2, 'spliter', '_')), '.mat', ''));

            % -- keep only valid eeg channels
            ix_ch = cell2mat(cellfun(@ischar, cdata.eeg.channels, 'un', 0));
            cdata.eeg.channels(~ix_ch) = {''};
            ix = ismember(cdata.eeg.channels, eegsys.channels);
            cdata.eeg.channels = cdata.eeg.channels(ix);
            if ~isempty(cdata.eeg.unit)
                cdata.eeg.unit = cdata.eeg.unit(ix);
            end
            cdata.eeg.data = cdata.eeg.data(ix, :);

            %% -- clean data

            if ~isempty(cTMS)

                %% -- remove closely spaced pulses

                epoch_distance = num2cell(true(1, length([cTMS.stimuli])));
                stimuli_th = 1000;
                diffs = diff([cTMS.stimuli]);
                ix_e = find(diffs < stimuli_th);
                ix_e = sort([ix_e, ix_e+1]);
                if ~isempty(ix_e)
                    if any(ix_e(end) == length([cTMS.stimuli]) - 1)
                        ix_e = [ix_e, ix_e(end) + 1];
                    end
                end
                epoch_distance(ix_e) = {false};
                cTMS(ix_e) = [];

                %% -- cleaning data

                [cdata.eeg, epoch_status, error_status, EEG_cleaned, ~, ME] = nin_cleaning_data_TESA(cdata.eeg, 'stimuli', [cTMS.stimuli], 'bad_epoch', ~[cTMS.valid],...
                    'musle_artifacts_features', musle_artifacts_features,...
                    'tms_win' , tms_win,...
                    'tms_win_e', tms_win_e,...
                    'epoch_len', [-1, 1]);

                % -- store epoch rejection status
                epoch_status = num2cell(~epoch_status);
                [cTMS.valid_cleaning] = epoch_status{:};

                % -- store pulse distance status
                [cTMS.valid_distance] = epoch_distance{:};

                % -- store number of removed channels
                [cTMS.bad_channels] = deal(nnz(EEG_cleaned.etc.bad_ch.ch_removed));

                if strcmpi(EEG_cleaned.etc.TESAvers, 'TESA1.0.1') || strcmpi(EEG_cleaned.etc.TESAvers, 'TESA1.1.1')
                    if isfield(EEG_cleaned.etc, 'TESA')
                        [cTMS.bad_componentsM] = deal(length(EEG_cleaned.etc.TESA.tmsMuscle));
                        [cTMS.bad_componentsO] = deal(length(EEG_cleaned.etc.TESA.eye) + ...
                            length(EEG_cleaned.etc.TESA.muscle) + ...
                            length(EEG_cleaned.etc.TESA.electrodeNoise) + ...
                            length(EEG_cleaned.etc.TESA.sensory) + ...
                            length(EEG_cleaned.etc.TESA.other));
                    else
                        [cTMS.bad_componentsM] = deal(0);
                        [cTMS.bad_componentsO] = deal(0);
                    end
                end
                TMS = [TMS; cTMS];


                %% -- export data

                % -- define output filename
                x(ks).path_out =  pout.path_out;
                x(ks).filename_out = strrep(x(ks).filename_in, '.mat', '_cleaned.mat');

                % -- save cleaned data
                if pout.saveWork
                    save([x(ks).path_out, x(ks).filename_out], 'cdata', '-v7.3');
                end

                % -- store processing status
                if strcmpi(error_status, '')

                    x(ks).passed =  true;
                    x(ks).comment =  '';

                else

                    x(ks).passed =  false;
                    x(ks).comment =  error_status;

                end

            else

                % -- store missing marker information
                x(ks).path_out =  '';
                x(ks).filename_out = '';
                x(ks).passed =  false;
                x(ks).comment =  'markers are missing';

            end

        catch

            % -- store processing error
            x(ks).path_out =  '';
            x(ks).filename_out = '';
            x(ks).passed =  false;
            x(ks).comment =  'error';

        end

        k2  = k2 + 1;
        ks = ks + 1;

    end

    k = k + 1;

end

% -- reorder tms fields
sfields = {'sub', 'Condition', 'session', 'stimulation', 'stimuli', 'tfreq', 'tphase', 'valid', 'valid_cleaning', 'valid_distance', 'bad_channels', 'bad_componentsM', 'bad_componentsO', 'filename'};
TMS = orderfields(TMS, sfields);

% -- save tms results
if pout.saveWork
    save([pout.path_supplementary, pout.tms_file, '_', pout.pro_name, '.mat'], 'TMS');
end

% -- save analysis report
if pout.saveWork
    save([pout.path_out, 'analysis_report.mat'], 'x', 'EEGLABv');
end