% -------------------------------------------------------------------------
%  Project: INTENS 2019
%  Task:    ERP/TEP
% -------------------------------------------------------------------------

% -- clear workspace, close all figures, and clear command window
clear all; close all; clc;

% -- initialize project settings and enable saving of results
pout = def_pro('IA_23a', 'saveWork', false, 'loadEEGLAB', true);

%% -- diary and load eeglab

if pout.saveWork
    % -- extract timestamp information from archive path
    time = strsplit(pout.archive_NIN_path, filesep);
    time = time{contains(time, 'NIN')};

    % -- create diary file for software version tracking
    diary([pout.archive_path, 'softare_version', strrep(time, 'NIN', ''), '.txt'])

    % -- launch EEGLAB
    if pout.loadEEGLAB
        eeglab;
    end
    eegsys = nin_eeg_system('BrainVision');

    % -- display current MATLAB version
    disp(['Matlab ', version]);

    diary off
else
    % -- launch EEGLAB
    if pout.loadEEGLAB
        eeglab;
    end
    eegsys = nin_eeg_system('BrainVision');
end

%% -- define input parameters

% -- define input directory
pout.path_in = '/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/data_out/Epoched_IA_23a/';

% -- define output directory
pout.path_out = ['/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/data_results/', pout.function_name, '_', pout.pro_name, '_', nin_ctime, '/'];

% -- define gateway directory
pout.path_gateway = '/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/data_out/gateway/';

% -- define supplementary directory and filename
pout.path_supplementary = '/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/Supplementary/';
pout.demog_file = 'Demog_INTENS_2019.xlsx';
pout.recording_file = 'Recordings_INTENS_2019.xlsx';
pout.clin_meas = 'IN-TENS_Clinical_assessments_scores_all.xlsx';
pout.clin_meas_hand = 'FMUE_best_all_hand.xlsx';

%% -- create data out folder

% -- define output path
if ~exist(pout.path_out, 'dir') && pout.saveWork
    mkdir(pout.path_out);
end

%% -- run following parts of code

flag_keep = false;

flag_plot_group_visit_stimulation_C3_C4 = true;
flag_topoplot_group_visit_stimulation = false;
flag_plot_group_visit_diff = false;

%% -- read supplementary

% -- read data and convet the into structure
[~, demogH, demog] = xlsread([pout.path_supplementary, pout.demog_file]);
demog = demog(:, 1:size(demogH, 2));
header = demog(1, :);
header(strcmpi(header, 'sub')) = {'sub'};
header(strcmpi(header, 'Condition')) = {'condition'};
T = cell2table(demog(2:end, :));
T.Properties.VariableNames = header;
demog = table2struct(T);

[~, recordFileH, recordFile] = xlsread([pout.path_supplementary, pout.recording_file]);
recordFile = recordFile(:, 1:size(recordFileH, 2));
header = lower(recordFile(1, :));
ix = contains(header, {'sub', 'visit', 'session'});
header = header(ix);
T = cell2table(recordFile(2:end, ix));
T.Properties.VariableNames = header;
recordFile = table2struct(T);

clear T header ix

%% -- load clinical data

[~, clinH, clin] = xlsread([pout.path_supplementary, pout.clin_meas]);
clin = clin(:, 1:size(clinH, 2));
header = clin(1, :);
T = cell2table(clin(2:end, :));
T.Properties.VariableNames = header;
clin = table2struct(T);

[~, clinH_hand, clin_hand] = xlsread([pout.path_supplementary, pout.clin_meas_hand]);
k = 1;
while k <= size(clin, 1)
    clin(k).fmue_hand = clin_hand{strcmpi(clinH_hand(:, 1), clin(k).part_id), strcmpi(clinH_hand(1, :), clin(k).ses_id)};
    k = k + 1;
end

%% -- define constants

sub = unique([{demog.sub}, {recordFile.sub}], 'stable');
condition = {'HC', 'ST'};
visit = {'V1', 'V2', 'V3', 'V4', 'V5', 'V6'};
sessions = {'pre1', 'pre2', 'post1', 'post2', 'pre3', 'pre4', 'post3', 'post4', 'post5', 'post6'};
stimulations = {'TMS', 'SHAM'};
stimulation_side = {'Dominant', 'Nondominant', 'Contralesional', 'Ipsilesional'};
phases = cellfun(@num2str, (num2cell(0:45:315)), 'un', 0);
npeaks = {'P25', 'N45', 'P70', 'N100', 'P180'};

%% -- load ERP data session by session

try

    % -- load previously compiled ERP dataset
    load([pout.path_gateway, 'ERP_', pout.pro_name, '.mat']);

catch

    % -- get all ERP files from input directory
    fileList = dir([pout.path_in '*.mat' ]);
    fileList = {fileList.name};
    fileList = fileList(~contains(fileList, 'analysis_report.mat'));

    erp_all = [];
    k = 1;
    while k <= length(fileList)

        % -- display loading progres
        disp(['Loading file ', num2str(k), '\', num2str(length(fileList))]);

        % -- load data
        load([pout.path_in, fileList{k}]);

        % -- extract stimulation side from filename
        [erp.stim_side] = deal(strrep(char(nin_strsplit({erp(1).filename}, 5, 5, 'spliter', '_')), '.mat', ''));

        % -- append current session data
        erp_all = [erp_all; erp];

        k  = k + 1;

    end

    erp = erp_all;

    %% -- merge ERP data with demographic and recording data

    % -- add demographic information
    erp = nin_merge_structures(erp, demog, {'sub'});

    % -- remove obsolete field
    erp = rmfield(erp, 'condition');

    % -- add recording metadata
    erp = nin_merge_structures(erp, recordFile, {'sub'; 'session'});

    % -- remove entries with missing trial counts
    erp = erp(~isnan([erp.N]));

    % -- save compiled ERP dataset
    if pout.saveWork
        save([pout.path_gateway, 'ERP_', pout.pro_name, '.mat'], 'erp', '-v7.3');
    end

    clear erp_all s

end

%% -- TEP data subject by subject and gather data

try

    % -- load previously compiled TEP dataset
    load([pout.path_gateway, 'TEP_', pout.pro_name, '.mat']);

catch

    % -- extract peak-based TEP measures
    tep = nin_erp_measure(erp, 'peak');

    % -- save compiled TEP dataset
    if pout.saveWork
        save([pout.path_gateway, 'TEP_', pout.pro_name, '.mat'], 'tep', '-v7.3');
    end

end

%% -- exclude subjects based on visual inspection or external decisions

% -- sub, stim, visit, side
toRemove = {'KoEb', 'TMS', 'V1', 'Dominant';...
    'KoEb', 'TMS', 'V1', 'Nondominant';...
    'AmWo', 'SHAM', 'V6', 'Contralesional';...
    'AmWo', 'SHAM', 'V6', 'Ipsilesional';...
    'EiHe', 'SHAM', 'V6', 'Contralesional';...
    'EiHe', 'SHAM', 'V6', 'Ipsilesional';...
    'GeKl', 'TMS', 'V5', 'Contralesional';...
    'GeKl', 'TMS', 'V5', 'Ipsilesional';...
    'GrMa', 'TMS', 'V2', 'Contralesional';...
    'GrMa', 'TMS', 'V2', 'Ipsilesional';...
    'HeLn', 'TMS', 'V3', 'Contralesional';...
    'HeLn', 'TMS', 'V3', 'Ipsilesional';...
    'HeLn', 'TMS', 'V5', 'Ipsilesional';...
    'KaBe', 'SHAM', 'V6', 'Contralesional';...
    'MaPe', 'TMS', 'V5', 'Contralesional';...
    'MaPe', 'TMS', 'V5', 'Ipsilesional';...
    'SaCe', 'TMS', 'V5', 'Contralesional';...
    'SaCe', 'TMS', 'V5', 'Ipsilesional';...
    'WiLu', 'TMS', 'V2', 'Contralesional';...
    'WiLu', 'TMS', 'V2', 'Ipsilesional';...
    'WiLu', 'TMS', 'V3', 'Ipsilesional';...
    'WiLu', 'TMS', 'V4', 'Contralesional';...
    'WiLu', 'TMS', 'V4', 'Ipsilesional';...
    'ZaRo', 'TMS', 'V2', 'Contralesional';...
    'ZaRo', 'TMS', 'V2', 'Ipsilesional';};

% -- identify entries matching exclusion criteria
ix = true(size(erp, 2), 1);
k = 1;
while k <= size(toRemove, 1)

    % -- find matching records
    [~, cix] = nin_subselect_dstruct(erp, 'sub', toRemove{k, 1}, 'stimulation', toRemove{k, 2}, 'visit', toRemove{k, 3}, 'stim_side', toRemove{k, 4});

    % -- mark records for removal
    ix = ix & ~cix;

    k = k + 1;

end

% -- keep only records that passed exclusion criteria
erp = erp(ix);
tep = tep(ix);

clear ix cix

%% -- remove sessions with technical issue

[sanity_file_DC{1, 1}, sanity_file_NI{1, 1}, ix(:, 1)] = erp_sanity_technical(erp, sub, visit, demog, '0');
[sanity_file_DC{2, 1}, sanity_file_NI{2, 1}, ix(:, 2)] = erp_sanity_technical(erp, sub, visit, demog, '45');
[sanity_file_DC{3, 1}, sanity_file_NI{3, 1}, ix(:, 3)] = erp_sanity_technical(erp, sub, visit, demog, '90');
[sanity_file_DC{4, 1}, sanity_file_NI{4, 1}, ix(:, 4)] = erp_sanity_technical(erp, sub, visit, demog, '135');
[sanity_file_DC{5, 1}, sanity_file_NI{5, 1}, ix(:, 5)] = erp_sanity_technical(erp, sub, visit, demog, '180');
[sanity_file_DC{6, 1}, sanity_file_NI{6, 1}, ix(:, 6)] = erp_sanity_technical(erp, sub, visit, demog, '225');
[sanity_file_DC{7, 1}, sanity_file_NI{7, 1}, ix(:, 7)] = erp_sanity_technical(erp, sub, visit, demog, '270');
[sanity_file_DC{8, 1}, sanity_file_NI{8, 1}, ix(:, 8)] = erp_sanity_technical(erp, sub, visit, demog, '315');
[sanity_file_DC{9, 1}, sanity_file_NI{9, 1}, ix(:, 9)] = erp_sanity_technical(erp, sub, visit, demog, 'all');
ix  = logical(prod(ix, 2));

% -- keep only records that passed exclusion criteria
erp = erp(ix);
tep = tep(ix);

clear ix

%% -- remove subjects and sessions with incomplete phase data

[sub_DC, sub_NI, ~, ~, ix] = erp_sanity_phase(erp, sub, visit, demog, phases);

% -- keep only records that passed exclusion criteria
erp = erp(ix);
tep = tep(ix);

clear ix

%% -- keep just common sub from sessions V2 and V5

if flag_keep

    % -- sub, stim, visit, side
    toKeep = {'AmKa', 'TMS', 'V1', 'Dominant';...
        'AmKa', 'TMS', 'V1', 'Nondominant';...
        'KoCh', 'TMS', 'V1', 'Dominant';...
        'KoCh', 'TMS', 'V1', 'Nondominant';...
        'RaPa', 'TMS', 'V1', 'Dominant';...
        'RaPa', 'TMS', 'V1', 'Nondominant';...
        'RaSi', 'TMS', 'V1', 'Dominant';...
        'RaSi', 'TMS', 'V1', 'Nondominant';...
        'SoMa', 'TMS', 'V1', 'Dominant';...
        'SoMa', 'TMS', 'V1', 'Nondominant';...
        'TrGe', 'TMS', 'V1', 'Dominant';...
        'TrGe', 'TMS', 'V1', 'Nondominant';...
        'VoAn', 'TMS', 'V1', 'Dominant';...
        'VoAn', 'TMS', 'V1', 'Nondominant';...
        'VoHe', 'TMS', 'V1', 'Dominant';...
        'VoHe', 'TMS', 'V1', 'Nondominant';...
        'VoSa', 'TMS', 'V1', 'Dominant';...
        'VoSa', 'TMS', 'V1', 'Nondominant';...
        'WiBe', 'TMS', 'V1', 'Dominant';...
        'WiBe', 'TMS', 'V1', 'Nondominant';...
        'WiDo', 'TMS', 'V1', 'Dominant';...
        'WiDo', 'TMS', 'V1', 'Nondominant';...
        'ZaBe', 'TMS', 'V1', 'Dominant';...
        'ZaBe', 'TMS', 'V1', 'Nondominant';...
        'AmWo', 'TMS', 'V2', 'Contralesional';...
        'AmWo', 'TMS', 'V2', 'Ipsilesional';...
        'AmWo', 'TMS', 'V5', 'Contralesional';...
        'AmWo', 'TMS', 'V5', 'Ipsilesional';...
        'BuUl', 'TMS', 'V2', 'Contralesional';...
        'BuUl', 'TMS', 'V2', 'Ipsilesional';...
        'BuUl', 'TMS', 'V5', 'Contralesional';...
        'BuUl', 'TMS', 'V5', 'Ipsilesional';...
        'EiHe', 'TMS', 'V2', 'Contralesional';...
        'EiHe', 'TMS', 'V2', 'Ipsilesional';...
        'EiHe', 'TMS', 'V5', 'Contralesional';...
        'EiHe', 'TMS', 'V5', 'Ipsilesional';...
        'FuMa', 'TMS', 'V2', 'Contralesional';...
        'FuMa', 'TMS', 'V2', 'Ipsilesional';...
        'FuMa', 'TMS', 'V5', 'Contralesional';...
        'FuMa', 'TMS', 'V5', 'Ipsilesional';...
        'GuWi', 'TMS', 'V2', 'Contralesional';...
        'GuWi', 'TMS', 'V2', 'Ipsilesional';...
        'GuWi', 'TMS', 'V5', 'Contralesional';...
        'GuWi', 'TMS', 'V5', 'Ipsilesional';...
        'HeIn', 'TMS', 'V2', 'Contralesional';...
        'HeIn', 'TMS', 'V2', 'Ipsilesional';...
        'HeIn', 'TMS', 'V5', 'Contralesional';...
        'HeIn', 'TMS', 'V5', 'Ipsilesional';...
        'MeRu', 'TMS', 'V2', 'Contralesional';...
        'MeRu', 'TMS', 'V2', 'Ipsilesional';...
        'MeRu', 'TMS', 'V5', 'Contralesional';...
        'MeRu', 'TMS', 'V5', 'Ipsilesional';...
        'SoFa', 'TMS', 'V2', 'Contralesional';...
        'SoFa', 'TMS', 'V2', 'Ipsilesional';...
        'SoFa', 'TMS', 'V5', 'Contralesional';...
        'SoFa', 'TMS', 'V5', 'Ipsilesional';};

else

    toKeep = {'AmKa', 'TMS', 'V1', 'Dominant';...
        'AmKa', 'TMS', 'V1', 'Nondominant';...
        'KoCh', 'TMS', 'V1', 'Dominant';...
        'KoCh', 'TMS', 'V1', 'Nondominant';...
        'RaPa', 'TMS', 'V1', 'Dominant';...
        'RaPa', 'TMS', 'V1', 'Nondominant';...
        'RaSi', 'TMS', 'V1', 'Dominant';...
        'RaSi', 'TMS', 'V1', 'Nondominant';...
        'SoMa', 'TMS', 'V1', 'Dominant';...
        'SoMa', 'TMS', 'V1', 'Nondominant';...
        'TrGe', 'TMS', 'V1', 'Dominant';...
        'TrGe', 'TMS', 'V1', 'Nondominant';...
        'VoAn', 'TMS', 'V1', 'Dominant';...
        'VoAn', 'TMS', 'V1', 'Nondominant';...
        'VoHe', 'TMS', 'V1', 'Dominant';...
        'VoHe', 'TMS', 'V1', 'Nondominant';...
        'VoSa', 'TMS', 'V1', 'Dominant';...
        'VoSa', 'TMS', 'V1', 'Nondominant';...
        'WiBe', 'TMS', 'V1', 'Dominant';...
        'WiBe', 'TMS', 'V1', 'Nondominant';...
        'WiDo', 'TMS', 'V1', 'Dominant';...
        'WiDo', 'TMS', 'V1', 'Nondominant';...
        'ZaBe', 'TMS', 'V1', 'Dominant';...
        'ZaBe', 'TMS', 'V1', 'Nondominant';...
        'AmWo', 'TMS', 'V2', 'Contralesional';...
        'AmWo', 'TMS', 'V2', 'Ipsilesional';...
        'AmWo', 'TMS', 'V5', 'Contralesional';...
        'AmWo', 'TMS', 'V5', 'Ipsilesional';...
        'BuUl', 'TMS', 'V2', 'Contralesional';...
        'BuUl', 'TMS', 'V2', 'Ipsilesional';...
        'BuUl', 'TMS', 'V5', 'Contralesional';...
        'BuUl', 'TMS', 'V5', 'Ipsilesional';...
        'EiHe', 'TMS', 'V2', 'Contralesional';...
        'EiHe', 'TMS', 'V2', 'Ipsilesional';...
        'EiHe', 'TMS', 'V5', 'Contralesional';...
        'EiHe', 'TMS', 'V5', 'Ipsilesional';...
        'FuMa', 'TMS', 'V2', 'Contralesional';...
        'FuMa', 'TMS', 'V2', 'Ipsilesional';...
        'FuMa', 'TMS', 'V5', 'Contralesional';...
        'FuMa', 'TMS', 'V5', 'Ipsilesional';...
        'GuWi', 'TMS', 'V2', 'Contralesional';...
        'GuWi', 'TMS', 'V2', 'Ipsilesional';...
        'GuWi', 'TMS', 'V5', 'Contralesional';...
        'GuWi', 'TMS', 'V5', 'Ipsilesional';...
        'MeRu', 'TMS', 'V2', 'Contralesional';...
        'MeRu', 'TMS', 'V2', 'Ipsilesional';...
        'MeRu', 'TMS', 'V5', 'Contralesional';...
        'MeRu', 'TMS', 'V5', 'Ipsilesional';...
        'SoFa', 'TMS', 'V2', 'Contralesional';...
        'SoFa', 'TMS', 'V2', 'Ipsilesional';...
        'SoFa', 'TMS', 'V5', 'Contralesional';...
        'SoFa', 'TMS', 'V5', 'Ipsilesional';};

end

% -- identify entries matching inclusion criteria
ix = false(size(erp, 2), 1);
k = 1;
while k <= size(toKeep, 1)

        % -- find matching records
    [~, cix] = nin_subselect_dstruct(erp, 'sub', toKeep{k, 1}, 'stimulation', toKeep{k, 2}, 'visit', toKeep{k, 3}, 'stim_side', toKeep{k, 4});

        % -- mark records
    ix = ix | cix;

    k = k + 1;

end

% -- keep only records that passed exclusion criteria
erp = erp(ix);
tep = tep(ix);

clear ix cix

%% -- display demographic characteristics of HC and ST groups at V2 and V5

cvisitALL = unique({erp.visit});

% -- select HC cohort
cerpHC = nin_subselect_dstruct(erp, 'visit', 'V1', 'stimulation', 'TMS', 'tphase', 'all', 'stim_side', 'Dominant');
disp(['HC: N = ', num2str(size(cerpHC, 2))]);
HCF = nin_subselect_dstruct(cerpHC, 'Gender', 'F');
disp(['HC: F = ', num2str(size(HCF, 2)), ' Age = ', num2str(mean([HCF.Age], 'omitnan')), ' +/- ', num2str(std([HCF.Age], 'omitnan'))]);
HCM = nin_subselect_dstruct(cerpHC, 'Gender', 'M');
disp(['HC: M = ', num2str(size(HCM, 2)), ' Age = ', num2str(mean([HCM.Age], 'omitnan')), ' +/- ', num2str(std([HCM.Age], 'omitnan'))]);
HCL = nin_subselect_dstruct(cerpHC, 'Lesion_Hand', 'L');
disp(['HC: L = ', num2str(size(HCL, 2))]);
HCR = nin_subselect_dstruct(cerpHC, 'Lesion_Hand', 'R');
disp(['HC: R = ', num2str(size(HCR, 2))]);

% -- select stroke cohort
cerpST = nin_subselect_dstruct(erp, 'visit', 'V2', 'stimulation', 'TMS', 'tphase', 'all', 'stim_side', 'Contralesional');
disp(['ST: N = ', num2str(size(cerpST, 2))]);
STF = nin_subselect_dstruct(cerpST, 'Gender', 'F');
disp(['ST: F = ', num2str(size(STF, 2)), ' Age = ', num2str(mean([STF.Age], 'omitnan')), ' +/- ', num2str(std([STF.Age], 'omitnan'))]);
STM = nin_subselect_dstruct(cerpST, 'Gender', 'M');
disp(['ST: M = ', num2str(size(STM, 2)), ' Age = ', num2str(mean([STM.Age], 'omitnan')), ' +/- ', num2str(std([STM.Age], 'omitnan'))]);
STL = nin_subselect_dstruct(cerpST, 'Lesion_Hand', 'L');
disp(['ST: L = ', num2str(size(STL, 2))]);
STR = nin_subselect_dstruct(cerpST, 'Lesion_Hand', 'R');
disp(['ST: R = ', num2str(size(STR, 2))]);

if any(strcmpi(cvisitALL, 'V5'))
    cerpST = nin_subselect_dstruct(erp, 'visit', 'V5', 'stimulation', 'TMS', 'tphase', 'all', 'stim_side', 'Contralesional');
    disp(['ST: N = ', num2str(size(cerpST, 2))]);
    STF = nin_subselect_dstruct(cerpST, 'Gender', 'F');
    disp(['ST: F = ', num2str(size(STF, 2)), ' Age = ', num2str(mean([STF.Age], 'omitnan')), ' +/- ', num2str(std([STF.Age], 'omitnan'))]);
    STM = nin_subselect_dstruct(cerpST, 'Gender', 'M');
    disp(['ST: M = ', num2str(size(STM, 2)), ' Age = ', num2str(mean([STM.Age], 'omitnan')), ' +/- ', num2str(std([STM.Age], 'omitnan'))]);
    STL = nin_subselect_dstruct(cerpST, 'Lesion_Hand', 'L');
    disp(['ST: L = ', num2str(size(STL, 2))]);
    STR = nin_subselect_dstruct(cerpST, 'Lesion_Hand', 'R');
    disp(['ST: R = ', num2str(size(STR, 2))]);
end

clear cerpHC HCF HCM HCL HCR cerpST STF STM STL STR

%% -- flip left-sided lesions to a common hemispheric orientation

% -- create copies of ERP and TEP data structures
erpf = erp;
tepf = tep;

% -- define homologous left and right hemisphere channels
ch_l = {'Fp1', 'AF7', 'AF3', 'FT9', 'F7', 'F5', 'F3', 'F1', 'FT7', 'FC5', 'FC3', 'FC1', 'T7', 'C5', 'C3', 'C1', 'TP7', 'CP5', 'CP3', 'CP1', 'P7', 'P5', 'P3', 'P1', 'TP9', 'PO7', 'PO3', 'O1'};
ch_r = {'Fp2', 'AF8', 'AF4', 'FT10', 'F8', 'F6', 'F4', 'F2', 'FT8', 'FC6', 'FC4', 'FC2', 'T8', 'C6', 'C4', 'C2', 'TP8', 'CP6', 'CP4', 'CP2', 'P8', 'P6', 'P4', 'P2', 'TP10', 'PO8', 'PO4', 'O2'};

% -- select participants with left-sided lesions
[cerp, ix] = nin_subselect_dstruct(erp, 'Lesion_Hand', 'L');
[ctep, ~] = nin_subselect_dstruct(tep, 'Lesion_Hand', 'L');
ix = find(ix);

k = 1;
while k <= size(cerp, 2)

    % -- initialize flipped data matrices
    ndata_mean = cerp(k).dataMEAN;
    ndata_std = cerp(k).dataSTD;
    ndata_sem = cerp(k).dataSEM;
    ndata_tep = ctep(k).data;

    kc = 1;
    while kc <= length(ch_l)

        % -- identify corresponding left and right hemisphere channels
        ix_l = strcmpi(cerp(k).data_rows, ch_l{kc});
        ix_r = strcmpi(cerp(k).data_rows, ch_r{kc});

        % -- swap left and right hemisphere data
        ndata_mean(ix_r, :) = cerp(k).dataMEAN(ix_l, :);
        ndata_mean(ix_l, :) = cerp(k).dataMEAN(ix_r, :);

        ndata_std(ix_r, :) = cerp(k).dataSTD(ix_l, :);
        ndata_std(ix_l, :) = cerp(k).dataSTD(ix_r, :);

        ndata_sem(ix_r, :) = cerp(k).dataSEM(ix_l, :);
        ndata_sem(ix_l, :) = cerp(k).dataSEM(ix_r, :);

        ndata_tep(ix_r, :) = ctep(k).data(ix_l, :);
        ndata_tep(ix_l, :) = ctep(k).data(ix_r, :);

        kc = kc + 1;

    end

    % -- update ERP structure with flipped data
    erpf(ix(k)).dataMEAN = ndata_mean;
    erpf(ix(k)).dataSTD = ndata_std;
    erpf(ix(k)).dataSEM = ndata_sem;

    % -- swap lesion and paretic/dominant side labels
    erpf(ix(k)).Parethic_Dominant_Side = cerp(k).Lesion_Hand;
    erpf(ix(k)).Lesion_Hand = cerp(k).Parethic_Dominant_Side;

    % -- update TEP structure with flipped data
    tepf(ix(k)).dataMEAN = ndata_mean;
    tepf(ix(k)).dataSTD = ndata_std;
    tepf(ix(k)).dataSEM = ndata_sem;
    tepf(ix(k)).data = ndata_tep;
    tepf(ix(k)).Parethic_Dominant_Side = ctep(k).Lesion_Hand;
    tepf(ix(k)).Lesion_Hand = ctep(k).Parethic_Dominant_Side;

    k = k + 1;

end

clear ndata_mean ndata_sem ndata_std ndata_tep ix cerp ctep ix_l ix_r kc

%% -- compute group-level ERP and TEP averages

% -- group ERP data by experimental condition
cdata = erpf;
cdata_group = nin_group_data(cdata, {'dataMEAN'}, {'visit', 'stimulation', 'stim_side', 'tphase'});
% -- add channel and time information
[cdata_group.data_rows] = deal(cdata(1).data_rows);
[cdata_group.data_columns] = deal(cdata(1).data_columns);
% -- assign participant group labels
[cdata_group.Condition] = deal('ST');
[cdata_group(strcmpi({cdata_group.stim_side}, 'Dominant')).Condition] = deal('HC');
[cdata_group(strcmpi({cdata_group.stim_side}, 'Nondominant')).Condition] = deal('HC');
% -- add side information
[cdata_group.Parethic_Dominant_Side] = deal(cdata(1).Parethic_Dominant_Side);
[cdata_group.Lesion_Hand] = deal(cdata(1).Lesion_Hand);

% -- preserve grouped ERP data
erpf_group = cdata_group;

% -- compute sample counts and grand-average ERP
cdata_group = nin_function(cdata_group, @(x) nnz(squeeze(~isnan(x(1, 1, :)))), {'dataMEAN'}, {'n'});
cdata_group = nin_function(cdata_group, @(x) size(x, 3), {'dataMEAN'}, {'N'});
cdata_group = nin_function(cdata_group, @(x) mean(x, 3, 'omitnan'), {'dataMEAN'}, {'data'});
% -- remove raw grouped ERP data
cdata_group = rmfield(cdata_group, 'dataMEAN');

% -- store grand-average ERP data
erpf_avg = cdata_group;

% -- group TEP data by experimental condition
cdata = tepf;
cdata_group = nin_group_data(cdata, {'data'}, {'stimulation', 'visit', 'stim_side', 'tphase'});

% -- add channel and time information
[cdata_group.data_rows] = deal(cdata(1).data_rows);
[cdata_group.data_columns] = deal(cdata(1).data_columns);

% -- assign participant group labels
[cdata_group.Condition] = deal('ST');
[cdata_group(strcmpi({cdata_group.stim_side}, 'Dominant')).Condition] = deal('HC');
[cdata_group(strcmpi({cdata_group.stim_side}, 'Nondominant')).Condition] = deal('HC');

% -- add side information
[cdata_group.Parethic_Dominant_Side] = deal(cdata(1).Parethic_Dominant_Side);
[cdata_group.Lesion_Hand] = deal(cdata(1).Lesion_Hand);

% -- preserve grouped TEP data
tepf_group = cdata_group;

% -- compute sample counts and grand-average TEP
cdata_group = nin_function(cdata_group, @(x) nnz(squeeze(~isnan(x(1, 1, :)))), {'data'}, {'n'});
cdata_group = nin_function(cdata_group, @(x) size(x, 3), {'data'}, {'N'});
cdata_group = nin_function(cdata_group, @(x) mean(x, 3, 'omitnan'), {'data'}, {'data'});

% -- store grand-average TEP data
tepf_avg = cdata_group;

clear cdata cdata_group

%% -- compute between-group TEP differences

% -- initialize TEP statistics structure
tepf_stat = [];
k = 1;
% -- TMS: HC vs ST, Dominant vs Contralesional, V1 vs V2
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V1';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Dominant';
cparam.cphase1 = 'all'; cparam.cphase2 = 'all';

% -- perform independent-samples t-test
[cstat, cstat_topo, cdata_diff] = erp_ttests(cparam, 'ttest2', tepf, tepf_avg);

% -- store statistical results and grand-average differences
tepf_stat = [tepf_stat, cstat];
tepf_stat_topo(k) = cstat_topo;
tepf_avg_diff(k) = cdata_diff;

clear cdata_diff cstat cstat_topo cparam

k = k + 1;
% -- TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V2
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V1';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Nondominant';
cparam.cphase1 = 'all'; cparam.cphase2 = 'all';

% -- perform independent-samples t-test
[cstat, cstat_topo, cdata_diff] = erp_ttests(cparam, 'ttest2', tepf, tepf_avg);

% -- store statistical results and grand-average differences
tepf_stat = [tepf_stat, cstat];
tepf_stat_topo(k) = cstat_topo;
tepf_avg_diff(k) = cdata_diff;

clear cdata_diff cstat cstat_topo cparam


% -- TMS and TMS: HC vs TMS, Dominant vs Contralesional, V1 vs V5
if any(strcmpi(cvisitALL, 'V1')) && any(strcmpi(cvisitALL, 'V5'))
    cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
    cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V1';
    cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Dominant';
    cparam.cphase1 = 'all'; cparam.cphase2 = 'all';

    % -- perform independent-samples t-test
    [cstat, cstat_topo, cdata_diff] = erp_ttests(cparam, 'ttest2', tepf, tepf_avg);

    % -- store statistical results and grand-average differences
    tepf_stat = [tepf_stat, cstat];
    tepf_stat_topo(k) = cstat_topo;
    tepf_avg_diff(k) = cdata_diff;

    clear cdata_diff cstat cstat_topo cparam

    k = k + 1;
end

% -- TMS and TMS: HC vs TMS, Nondominant vs Ipsilesional, V1 vs V5
if any(strcmpi(cvisitALL, 'V1')) && any(strcmpi(cvisitALL, 'V5'))
    cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
    cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V1';
    cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Nondominant';
    cparam.cphase1 = 'all'; cparam.cphase2 = 'all';

    % -- perform independent-samples t-test
    [cstat, cstat_topo, cdata_diff] = erp_ttests(cparam, 'ttest2', tepf, tepf_avg);

    % -- store statistical results and grand-average differences
    tepf_stat = [tepf_stat, cstat];
    tepf_stat_topo(k) = cstat_topo;
    tepf_avg_diff(k) = cdata_diff;

    clear cdata_diff cstat cstat_topo cparam

    k = k + 1;
end

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V2 vs V5
if any(strcmpi(cvisitALL, 'V2')) && any(strcmpi(cvisitALL, 'V5'))
    cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
    cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V2';
    cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
    cparam.cphase1 = 'all'; cparam.cphase2 = 'all';

    % -- perform independent-samples t-test
    [cstat, cstat_topo, cdata_diff] = erp_ttests(cparam, 'ttest', tepf, tepf_avg);

    % -- store statistical results and grand-average differences
    tepf_stat = [tepf_stat, cstat];
    tepf_stat_topo(k) = cstat_topo;
    tepf_avg_diff(k) = cdata_diff;

    clear cdata_diff cstat cstat_topo cparam

    k = k + 1;
end

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V2 vs V5
if any(strcmpi(cvisitALL, 'V2')) && any(strcmpi(cvisitALL, 'V5'))
    cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
    cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V2';
    cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
    cparam.cphase1 = 'all'; cparam.cphase2 = 'all';

    % -- perform independent-samples t-test
    [cstat, cstat_topo, cdata_diff] = erp_ttests(cparam, 'ttest', tepf, tepf_avg);

    % -- store statistical results and grand-average differences
    tepf_stat = [tepf_stat, cstat];
    tepf_stat_topo(k) = cstat_topo;
    tepf_avg_diff(k) = cdata_diff;

    clear cdata_diff cstat cstat_topo cparam

    k = k + 1;
end

%% -- plot grand-average ERP responses at C3 and C4

if flag_plot_group_visit_stimulation_C3_C4

    % -- create output folder
    pout.path_out_subfolder = [pout.path_out, 'Grand Average ERP C3 and C4\'];
    if ~exist(pout.path_out_subfolder, 'dir') && pout.saveWork
        mkdir(pout.path_out_subfolder);
    end


    % -- TMS: HC vs ST, Dominant vs Contralesional, V1 vs V2 vs V5
    cstim1 = 'TMS'; cstim2 = 'TMS'; cstim3 = 'TMS';
    cvisit1 = 'V1'; cvisit2 = 'V2'; cvisit3 = 'V5';
    cstimside1 = 'Dominant'; cstimside2 = 'Contralesional'; cstimside3 = 'Contralesional';
    cphase = 'all';
    cxrange = [-100, 500]; cyrange = [-5, 5];

    cdata = [nin_subselect_dstruct(erpf_avg, 'stimulation', cstim1, 'visit', cvisit1, 'stim_side', cstimside1, 'tphase', cphase);...
        nin_subselect_dstruct(erpf_avg, 'stimulation', cstim2, 'visit', cvisit2, 'stim_side', cstimside2, 'tphase', cphase);...
        nin_subselect_dstruct(erpf_avg, 'stimulation', cstim3, 'visit', cvisit3, 'stim_side', cstimside3, 'tphase', cphase)];

    % -- generate condition labels
    cstim_side = strcat({cdata.stimulation}, '_', {cdata.Condition}, '_', {cdata.visit}, '_', {cdata.stim_side});
    [cdata.condition] = cstim_side{:};
    cdata_1 = cdata;

    % -- TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V2 vs V5
    cstim1 = 'TMS'; cstim2 = 'TMS'; cstim2 = 'TMS';
    cvisit1 = 'V1'; cvisit2 = 'V2'; cvisit3 = 'V5';
    cstimside1 = 'Nondominant'; cstimside2 = 'Ipsilesional'; cstimside3 = 'Ipsilesional';
    cphase = 'all';
    cxrange = [-100, 500]; cyrange = [-5, 5];

    cdata = [nin_subselect_dstruct(erpf_avg, 'stimulation', cstim1, 'visit', cvisit1, 'stim_side', cstimside1, 'tphase', cphase);...
        nin_subselect_dstruct(erpf_avg, 'stimulation', cstim2, 'visit', cvisit2, 'stim_side', cstimside2, 'tphase', cphase);...
        nin_subselect_dstruct(erpf_avg, 'stimulation', cstim3, 'visit', cvisit3, 'stim_side', cstimside3, 'tphase', cphase)];

    % -- generate condition labels
    cstim_side = strcat({cdata.stimulation}, '_', {cdata.Condition}, '_', {cdata.visit}, '_', {cdata.stim_side});
    [cdata.condition] = cstim_side{:};
    cdata_2 = cdata;

    % -- define figure formatting parameters
    fW = 17.5;
    fH = 6;
    fFont = 'Ariel';
    fFontSize = 9;
    fFontSizeTick = 8;
    fFontSizeSTitle = 10;
    fFontSizeTitle = 11;
    fFontWeight = 'bold';
    fFontWeightTick = 'normal';
    lineWidth = 2;
    lineWidth2 = 2.5;
    axesLineWidth = 0.75;
    markerSize = 4;
    alphaerrorBand = 0.2;
    alphafreqHighlight = 0.25;

    % -- create figure and tiled layout
    h = figure('Units', 'centimeters', 'Position', [2, 2, fW, fH], 'Color', [1 1 1]);
    t = tiledlayout(1, 2, 'TileSpacing', 'tight');

    % -- define time range around stimulation onset
    ctime = cell2mat(cellfun(@str2num, cdata_1(1).data_columns, 'un', 0));
    ix_0 = find(ctime == 0);
    samplet = ix_0-50:ix_0+400;
    sample = samplet;
    cylim = [-5 5];
    cxlim = [-50 400];

    % -- plot c3 erp responses
    nexttile(1);
    plot(ctime(samplet), cdata_1(1).data(strcmpi(cdata_1(1).data_rows, 'C3'), samplet), 'b', 'linewidth', lineWidth);
    hold on;
    plot(ctime(samplet), cdata_1(2).data(strcmpi(cdata_1(2).data_rows, 'C3'), samplet), 'r', 'linewidth', lineWidth);
    plot(ctime(samplet), cdata_1(3).data(strcmpi(cdata_1(3).data_rows, 'C3'), samplet), 'Color', rgb('Green'), 'linewidth', lineWidth);
    % -- highlight stimulation window
    fill([ctime(ix_0-10) ctime(ix_0-10) ctime(ix_0+10) ctime(ix_0+10)], [cylim fliplr(cylim)], 'k', 'FaceAlpha', 1,'linestyle','none');%%
    ylim(cylim);
    xlim(cxlim);
    title('Dominant / Contralesional', ...
        'FontName', fFont, ...
        'FontSize', fFontSizeSTitle, ...
        'FontWeight', fFontWeight, ...
        'interpreter', 'none');

    % -- format axes
    set(gca, 'FontName', fFont, ...
        'FontSize', fFontSizeTick, ...
        'FontWeight', fFontWeightTick, ...
        'LineWidth', axesLineWidth);

    % -- plot c4 erp responses
    nexttile(2);
    plot(ctime(samplet), cdata_2(1).data(strcmpi(cdata_2(1).data_rows, 'C4'), samplet), 'b', 'linewidth', lineWidth);
    hold on;
    plot(ctime(samplet), cdata_2(2).data(strcmpi(cdata_2(2).data_rows, 'C4'), samplet), 'r', 'linewidth', lineWidth);
    plot(ctime(samplet), cdata_2(3).data(strcmpi(cdata_2(3).data_rows, 'C4'), samplet), 'Color', rgb('Green'), 'linewidth', lineWidth);
    % -- highlight stimulation window
    fill([ctime(ix_0-10) ctime(ix_0-10) ctime(ix_0+10) ctime(ix_0+10)], [cylim fliplr(cylim)], 'k', 'FaceAlpha', 1,'linestyle','none');%%
    ylim(cylim);
    xlim(cxlim);
    set(gca, 'YTick', []);
    title('Non-dominant / Ipsilesional', ...
        'FontName', fFont, ...
        'FontSize', fFontSizeSTitle, ...
        'FontWeight', fFontWeight, ...
        'interpreter', 'none');
    % -- format axes
    set(gca, 'FontName', fFont, ...
        'FontSize', fFontSizeTick, ...
        'FontWeight', fFontWeightTick, ...
        'LineWidth', axesLineWidth);

    % -- add shared axis labels
    ylabel(t,'Amplitude (\muV)','FontName', fFont, 'FontSize', fFontSize);
    xlabel(t,'Time (ms)','FontName', fFont, 'FontSize', fFontSize);

    % -- add legend
    l = legend('Healthy', 'Stroke - PRE', 'Stroke - POST');
    l.FontName = fFont;
    l.FontSize = fFontSizeTick;

    % -- save figure
    if pout.saveWork

        pout.fielname_out = 'ERP';
        saveas(h, [pout.path_out_subfolder, pout.fielname_out, '.fig']);
        exportgraphics(h, [pout.path_out_subfolder, pout.fielname_out, '.png'], 'Resolution', 300);

    end

    close(h);

end

%% -- generate grand-average TEP topographic maps

if flag_topoplot_group_visit_stimulation

    % -- create output directory for TEP topographies
    pout.path_out_subfolder = [pout.path_out, 'Grand Average TEP\'];
    if ~exist(pout.path_out_subfolder, 'dir') && pout.saveWork
        mkdir(pout.path_out_subfolder);
    end

    % -- TMS: HC, Dominant, V1
    cstim = 'TMS';
    cvisit = 'V1';
    cstimside = 'Dominant';
    cphase = 'all';
    crange_topo = [-5, 5];

    cdata =  nin_subselect_dstruct(tepf_avg, 'stimulation', cstim, 'visit', cvisit, 'stim_side', cstimside, 'tphase', cphase);

    % -- generate peak-amplitude topographic maps
    h = nin_topoplot(cdata, [], 'scolumns', strcat(npeaks, '_amp'), 'crange', crange_topo);

    % -- add figure title and save output
    k = 1;
    while k <= length(h)
        set(0, 'currentfigure', h(k));
        cname = [cdata.stimulation, ': ', cdata.Condition, ', ', cdata.visit, ', ', cdata.stim_side, ', ', cdata.tphase, ', ', strrep(h(k).Name, '_', ' '), ', N = ', num2str(cdata.n)];
        sgtitle(cname);
        if pout.saveWork
            pout.fielname_out = char(nin_strsplit({strrep(strrep(strrep(cname, ': ', '_'), ', ', '_'), ' ', '_')}, 1, 7, 'spliter', '_'));
            exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
        end
        k = k + 1;
    end

    % -- close topography figures
    k = 1;
    while k <= length(h)
        if isempty(strfind(h(k).Name, 'EEGLAB'))
            close(h(k));
        end
        k = k + 1;
    end

    % -- TMS: HC, Nondominant, V1
    cstim = 'TMS';
    cvisit = 'V1';
    cstimside = 'Nondominant';
    cphase = 'all';
    crange_topo = [-5, 5];

    cdata =  nin_subselect_dstruct(tepf_avg, 'stimulation', cstim, 'visit', cvisit, 'stim_side', cstimside, 'tphase', cphase);

    % -- generate peak-amplitude topographic maps
    h = nin_topoplot(cdata, [], 'scolumns', strcat(npeaks, '_amp'), 'crange', crange_topo);

    % -- add figure title and save output
    k = 1;
    while k <= length(h)
        set(0, 'currentfigure', h(k));
        cname = [cdata.stimulation, ': ', cdata.Condition, ', ', cdata.visit, ', ', cdata.stim_side, ', ', cdata.tphase, ', ', strrep(h(k).Name, '_', ' '), ', N = ', num2str(cdata.n)];
        sgtitle(cname);
        if pout.saveWork
            pout.fielname_out = char(nin_strsplit({strrep(strrep(strrep(cname, ': ', '_'), ', ', '_'), ' ', '_')}, 1, 7, 'spliter', '_'));
            exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
        end
        k = k + 1;
    end

    % -- close topography figures
    k = 1;
    while k <= length(h)
        if isempty(strfind(h(k).Name, 'EEGLAB'))
            close(h(k));
        end
        k = k + 1;
    end

    % -- TMS: ST, Contralesional, V2
    cstim = 'TMS';
    cvisit = 'V2';
    cstimside = 'Contralesional';
    cphase = 'all';
    crange_topo = [-5, 5];

    cdata =  nin_subselect_dstruct(tepf_avg, 'stimulation', cstim, 'visit', cvisit, 'stim_side', cstimside, 'tphase', cphase);

    % -- generate peak-amplitude topographic maps
    h = nin_topoplot(cdata, [], 'scolumns', strcat(npeaks, '_amp'), 'crange', crange_topo);

    % -- add figure title and save output
    k = 1;
    while k <= length(h)
        set(0, 'currentfigure', h(k));
        cname = [cdata.stimulation, ': ', cdata.Condition, ', ', cdata.visit, ', ', cdata.stim_side, ', ', cdata.tphase, ', ', strrep(h(k).Name, '_', ' '), ', N = ', num2str(cdata.n)];
        sgtitle(cname);
        if pout.saveWork
            pout.fielname_out = char(nin_strsplit({strrep(strrep(strrep(cname, ': ', '_'), ', ', '_'), ' ', '_')}, 1, 7, 'spliter', '_'));
            exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
        end
        k = k + 1;
    end

    % -- close topography figures
    k = 1;
    while k <= length(h)
        if isempty(strfind(h(k).Name, 'EEGLAB'))
            close(h(k));
        end
        k = k + 1;
    end

    % -- TMS: ST, Ipsilesional, V2
    cstim = 'TMS';
    cvisit = 'V2';
    cstimside = 'Ipsilesional';
    cphase = 'all';
    crange_topo = [-5, 5];

    cdata =  nin_subselect_dstruct(tepf_avg, 'stimulation', cstim, 'visit', cvisit, 'stim_side', cstimside, 'tphase', cphase);

    % -- generate peak-amplitude topographic maps
    h = nin_topoplot(cdata, [], 'scolumns', strcat(npeaks, '_amp'), 'crange', crange_topo);

    % -- add figure title and save output
    k = 1;
    while k <= length(h)
        set(0, 'currentfigure', h(k));
        cname = [cdata.stimulation, ': ', cdata.Condition, ', ', cdata.visit, ', ', cdata.stim_side, ', ', cdata.tphase, ', ', strrep(h(k).Name, '_', ' '), ', N = ', num2str(cdata.n)];
        sgtitle(cname);
        if pout.saveWork
            pout.fielname_out = char(nin_strsplit({strrep(strrep(strrep(cname, ': ', '_'), ', ', '_'), ' ', '_')}, 1, 7, 'spliter', '_'));
            exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
        end
        k = k + 1;
    end

    % -- close topography figures
    k = 1;
    while k <= length(h)
        if isempty(strfind(h(k).Name, 'EEGLAB'))
            close(h(k));
        end
        k = k + 1;
    end

    % -- TMS: ST, Contralesional, V5
    if any(strcmpi(cvisitALL, 'V5'))
        cstim = 'TMS';
        cvisit = 'V5';
        cstimside = 'Contralesional';
        cphase = 'all';
        crange_topo = [-5, 5];

        cdata =  nin_subselect_dstruct(tepf_avg, 'stimulation', cstim, 'visit', cvisit, 'stim_side', cstimside, 'tphase', cphase);

        % -- generate peak-amplitude topographic maps
        h = nin_topoplot(cdata, [], 'scolumns', strcat(npeaks, '_amp'), 'crange', crange_topo);

        % -- add figure title and save output
        k = 1;
        while k <= length(h)
            set(0, 'currentfigure', h(k));
            cname = [cdata.stimulation, ': ', cdata.Condition, ', ', cdata.visit, ', ', cdata.stim_side, ', ', cdata.tphase, ', ', strrep(h(k).Name, '_', ' '), ', N = ', num2str(cdata.n)];
            sgtitle(cname);
            if pout.saveWork
                pout.fielname_out = char(nin_strsplit({strrep(strrep(strrep(cname, ': ', '_'), ', ', '_'), ' ', '_')}, 1, 7, 'spliter', '_'));
                exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
            end
            k = k + 1;
        end

        % -- close topography figures
        k = 1;
        while k <= length(h)
            if isempty(strfind(h(k).Name, 'EEGLAB'))
                close(h(k));
            end
            k = k + 1;
        end
    end

    % -- TMS: ST, Ipsilesional, V5
    if any(strcmpi(cvisitALL, 'V5'))
        cstim = 'TMS';
        cvisit = 'V5';
        cstimside = 'Ipsilesional';
        cphase = 'all';
        crange_topo = [-5, 5];

        cdata =  nin_subselect_dstruct(tepf_avg, 'stimulation', cstim, 'visit', cvisit, 'stim_side', cstimside, 'tphase', cphase);

        % -- generate peak-amplitude topographic maps
        h = nin_topoplot(cdata, [], 'scolumns', strcat(npeaks, '_amp'), 'crange', crange_topo);

        % -- add figure title and save output
        k = 1;
        while k <= length(h)
            set(0, 'currentfigure', h(k));
            cname = [cdata.stimulation, ': ', cdata.Condition, ', ', cdata.visit, ', ', cdata.stim_side, ', ', cdata.tphase, ', ', strrep(h(k).Name, '_', ' '), ', N = ', num2str(cdata.n)];
            sgtitle(cname);
            if pout.saveWork
                pout.fielname_out = char(nin_strsplit({strrep(strrep(strrep(cname, ': ', '_'), ', ', '_'), ' ', '_')}, 1, 7, 'spliter', '_'));
                exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
            end
            k = k + 1;
        end

        % -- close topography figures
        k = 1;
        while k <= length(h)
            if isempty(strfind(h(k).Name, 'EEGLAB'))
                close(h(k));
            end
            k = k + 1;
        end
    end

end

if flag_plot_group_visit_diff

    % -- create output directory for TEP topographies
    pout.path_out_subfolder = [pout.path_out, 'Grand Average TEP diff\'];
    if ~exist(pout.path_out_subfolder, 'dir') && pout.saveWork
        mkdir(pout.path_out_subfolder);
    end

    % -- TMS: HC vs ST, Dominant vs Contralesional, V1 vs V2
    ccondition = 'TMS_ST_V2_Contralesional_all - TMS_HC_V1_Dominant_all';
    crange_topo = [-2.5, 2.5];

    cdata =  nin_subselect_dstruct(tepf_avg_diff, 'condition', ccondition);
    cstat =  nin_subselect_dstruct(tepf_stat_topo, 'condition', ccondition);

    % -- generate peak-amplitude topographic maps
    h = nin_topoplot(cdata, cstat, 'scolumns', strcat(npeaks, '_amp'), 'crange', crange_topo);

    % -- add figure title and save output
    k = 1;
    while k <= length(h)
        set(0, 'currentfigure', h(k));
        cname = ['diff_', h(k).Name, ' = ', strrep(cdata.condition, '_all', '')];
        sgtitle(cname, 'interpreter', 'none');
        if pout.saveWork
            pout.fielname_out = strrep(strrep(cname, ' = ', '_'), ' - ', '_');
            exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
        end
        k = k + 1;
    end

    % -- close topography figures
    k = 1;
    while k <= length(h)
        if isempty(strfind(h(k).Name, 'EEGLAB'))
            close(h(k));
        end
        k = k + 1;
    end

    % -- generate statistic-amplitude topographic maps
    h = nin_topoplot(cstat, cstat, 'scolumns', strcat(npeaks, '_amp_t'), 'crange', crange_topo);

    % -- add figure title and save output
    k = 1;
    while k <= length(h)
        set(0, 'currentfigure', h(k));
        cname = ['diff_', h(k).Name, ' = ', strrep(cdata.condition, '_all', '')];
        sgtitle(cname, 'interpreter', 'none');
        if pout.saveWork
            pout.fielname_out = strrep(strrep(cname, ' = ', '_'), ' - ', '_');
            exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
        end
        k = k + 1;
    end

    % -- close topography figures
    k = 1;
    while k <= length(h)
        if isempty(strfind(h(k).Name, 'EEGLAB'))
            close(h(k));
        end
        k = k + 1;
    end

    % -- TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V2
    ccondition = 'TMS_ST_V2_Ipsilesional_all - TMS_HC_V1_Nondominant_all';
    crange_topo = [-2.5, 2.5];

    cdata =  nin_subselect_dstruct(tepf_avg_diff, 'condition', ccondition);
    cstat =  nin_subselect_dstruct(tepf_stat_topo, 'condition', ccondition);

    % -- generate peak-amplitude topographic maps
    h = nin_topoplot(cdata, cstat, 'scolumns', strcat(npeaks, '_amp'), 'crange', crange_topo);

    % -- add figure title and save output
    k = 1;
    while k <= length(h)
        set(0, 'currentfigure', h(k));
        cname = ['diff_', h(k).Name, ' = ', strrep(cdata.condition, '_all', '')];
        sgtitle(cname, 'interpreter', 'none');
        if pout.saveWork
            pout.fielname_out = strrep(strrep(cname, ' = ', '_'), ' - ', '_');
            exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
        end
        k = k + 1;
    end

    % -- close topography figures
    k = 1;
    while k <= length(h)
        if isempty(strfind(h(k).Name, 'EEGLAB'))
            close(h(k));
        end
        k = k + 1;
    end

    % -- generate statistic-amplitude topographic maps
    h = nin_topoplot(cstat, cstat, 'scolumns', strcat(npeaks, '_amp_t'), 'crange', crange_topo);

    % -- add figure title and save output
    k = 1;
    while k <= length(h)
        set(0, 'currentfigure', h(k));
        cname = ['diff_', h(k).Name, ' = ', strrep(cdata.condition, '_all', '')];
        sgtitle(cname, 'interpreter', 'none');
        if pout.saveWork
            pout.fielname_out = strrep(strrep(cname, ' = ', '_'), ' - ', '_');
            exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
        end
        k = k + 1;
    end

    % -- close topography figures
    k = 1;
    while k <= length(h)
        if isempty(strfind(h(k).Name, 'EEGLAB'))
            close(h(k));
        end
        k = k + 1;
    end

    % -- TMS: HC vs ST, Dominant vs Contralesional, V1 vs V5
    if any(strcmpi(cvisitALL, 'V1')) && any(strcmpi(cvisitALL, 'V5'))
        ccondition = 'TMS_ST_V5_Contralesional_all - TMS_HC_V1_Dominant_all';
        crange_topo = [-2.5, 2.5];

        cdata =  nin_subselect_dstruct(tepf_avg_diff, 'condition', ccondition);
        cstat =  nin_subselect_dstruct(tepf_stat_topo, 'condition', ccondition);

        % -- generate peak-amplitude topographic maps
        h = nin_topoplot(cdata, cstat, 'scolumns', strcat(npeaks, '_amp'), 'crange', crange_topo);

        % -- add figure title and save output
        k = 1;
        while k <= length(h)
            set(0, 'currentfigure', h(k));
            cname = ['diff_', h(k).Name, ' = ', strrep(cdata.condition, '_all', '')];
            sgtitle(cname, 'interpreter', 'none');
            if pout.saveWork
                pout.fielname_out = strrep(strrep(cname, ' = ', '_'), ' - ', '_');
                exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
            end
            k = k + 1;
        end

        % -- close topography figures
        k = 1;
        while k <= length(h)
            if isempty(strfind(h(k).Name, 'EEGLAB'))
                close(h(k));
            end
            k = k + 1;
        end

        % -- generate statistic-amplitude topographic maps
        h = nin_topoplot(cstat, cstat, 'scolumns', strcat(npeaks, '_amp_t'), 'crange', crange_topo);

        % -- add figure title and save output
        k = 1;
        while k <= length(h)
            set(0, 'currentfigure', h(k));
            cname = ['diff_', h(k).Name, ' = ', strrep(cdata.condition, '_all', '')];
            sgtitle(cname, 'interpreter', 'none');
            if pout.saveWork
                pout.fielname_out = strrep(strrep(cname, ' = ', '_'), ' - ', '_');
                exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
            end
            k = k + 1;
        end

        % -- close topography figures
        k = 1;
        while k <= length(h)
            if isempty(strfind(h(k).Name, 'EEGLAB'))
                close(h(k));
            end
            k = k + 1;
        end
    end

    % -- TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V5
    if any(strcmpi(cvisitALL, 'V1')) && any(strcmpi(cvisitALL, 'V5'))
        ccondition = 'TMS_ST_V5_Ipsilesional_all - TMS_HC_V1_Nondominant_all';
        crange_topo = [-2.5, 2.5];

        cdata =  nin_subselect_dstruct(tepf_avg_diff, 'condition', ccondition);
        cstat =  nin_subselect_dstruct(tepf_stat_topo, 'condition', ccondition);

        % -- generate peak-amplitude topographic maps
        h = nin_topoplot(cdata, cstat, 'scolumns', strcat(npeaks, '_amp'), 'crange', crange_topo);

        % -- add figure title and save output
        k = 1;
        while k <= length(h)
            set(0, 'currentfigure', h(k));
            cname = ['diff_', h(k).Name, ' = ', strrep(cdata.condition, '_all', '')];
            sgtitle(cname, 'interpreter', 'none');
            if pout.saveWork
                pout.fielname_out = strrep(strrep(cname, ' = ', '_'), ' - ', '_');
                exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
            end
            k = k + 1;
        end

        % -- close topography figures
        k = 1;
        while k <= length(h)
            if isempty(strfind(h(k).Name, 'EEGLAB'))
                close(h(k));
            end
            k = k + 1;
        end

        % -- generate statistic-amplitude topographic maps
        h = nin_topoplot(cstat, cstat, 'scolumns', strcat(npeaks, '_amp_t'), 'crange', crange_topo);

        % -- add figure title and save output
        k = 1;
        while k <= length(h)
            set(0, 'currentfigure', h(k));
            cname = ['diff_', h(k).Name, ' = ', strrep(cdata.condition, '_all', '')];
            sgtitle(cname, 'interpreter', 'none');
            if pout.saveWork
                pout.fielname_out = strrep(strrep(cname, ' = ', '_'), ' - ', '_');
                exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
            end
            k = k + 1;
        end

        % -- close topography figures
        k = 1;
        while k <= length(h)
            if isempty(strfind(h(k).Name, 'EEGLAB'))
                close(h(k));
            end
            k = k + 1;
        end
    end

    % -- TMS: ST vs ST, Contralesional vs Contralesional, V2 vs V5
    if any(strcmpi(cvisitALL, 'V2')) && any(strcmpi(cvisitALL, 'V5'))
        ccondition = 'TMS_ST_V5_Contralesional_all - TMS_ST_V2_Contralesional_all';
        crange_topo = [-2.5, 2.5];

        cdata =  nin_subselect_dstruct(tepf_avg_diff, 'condition', ccondition);
        cstat =  nin_subselect_dstruct(tepf_stat_topo, 'condition', ccondition);

        % -- generate peak-amplitude topographic maps
        h = nin_topoplot(cdata, cstat, 'scolumns', strcat(npeaks, '_amp'), 'crange', crange_topo);

        % -- add figure title and save output
        k = 1;
        while k <= length(h)
            set(0, 'currentfigure', h(k));
            cname = ['diff_', h(k).Name, ' = ', strrep(cdata.condition, '_all', '')];
            sgtitle(cname, 'interpreter', 'none');
            if pout.saveWork
                pout.fielname_out = strrep(strrep(cname, ' = ', '_'), ' - ', '_');
                exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
            end
            k = k + 1;
        end

        % -- close topography figures
        k = 1;
        while k <= length(h)
            if isempty(strfind(h(k).Name, 'EEGLAB'))
                close(h(k));
            end
            k = k + 1;
        end

        % -- generate statistic-amplitude topographic maps
        h = nin_topoplot(cstat, cstat, 'scolumns', strcat(npeaks, '_amp_t'), 'crange', crange_topo);

        % -- add figure title and save output
        k = 1;
        while k <= length(h)
            set(0, 'currentfigure', h(k));
            cname = ['diff_', h(k).Name, ' = ', strrep(cdata.condition, '_all', '')];
            sgtitle(cname, 'interpreter', 'none');
            if pout.saveWork
                pout.fielname_out = strrep(strrep(cname, ' = ', '_'), ' - ', '_');
                exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
            end
            k = k + 1;
        end

        % -- close topography figures
        k = 1;
        while k <= length(h)
            if isempty(strfind(h(k).Name, 'EEGLAB'))
                close(h(k));
            end
            k = k + 1;
        end
    end

    % -- TMS: ST vs ST, Ipsilesional vs Ipsilesional, V2 vs V5
    if any(strcmpi(cvisitALL, 'V2')) && any(strcmpi(cvisitALL, 'V5'))
        ccondition = 'TMS_ST_V5_Ipsilesional_all - TMS_ST_V2_Ipsilesional_all';
        crange_topo = [-2.5, 2.5];

        cdata =  nin_subselect_dstruct(tepf_avg_diff, 'condition', ccondition);
        cstat =  nin_subselect_dstruct(tepf_stat_topo, 'condition', ccondition);

        % -- generate peak-amplitude topographic maps
        h = nin_topoplot(cdata, cstat, 'scolumns', strcat(npeaks, '_amp'), 'crange', crange_topo);

        % -- add figure title and save output
        k = 1;
        while k <= length(h)
            set(0, 'currentfigure', h(k));
            cname = ['diff_', h(k).Name, ' = ', strrep(cdata.condition, '_all', '')];
            sgtitle(cname, 'interpreter', 'none');
            if pout.saveWork
                pout.fielname_out = strrep(strrep(cname, ' = ', '_'), ' - ', '_');
                exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
            end
            k = k + 1;
        end

        % -- close topography figures
        k = 1;
        while k <= length(h)
            if isempty(strfind(h(k).Name, 'EEGLAB'))
                close(h(k));
            end
            k = k + 1;
        end

        % -- generate statistic-amplitude topographic maps
        h = nin_topoplot(cstat, cstat, 'scolumns', strcat(npeaks, '_amp_t'), 'crange', crange_topo);

        % -- add figure title and save output
        k = 1;
        while k <= length(h)
            set(0, 'currentfigure', h(k));
            cname = ['diff_', h(k).Name, ' = ', strrep(cdata.condition, '_all', '')];
            sgtitle(cname, 'interpreter', 'none');
            if pout.saveWork
                pout.fielname_out = strrep(strrep(cname, ' = ', '_'), ' - ', '_');
                exportgraphics(h(k), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
            end
            k = k + 1;
        end

        % -- close topography figures
        k = 1;
        while k <= length(h)
            if isempty(strfind(h(k).Name, 'EEGLAB'))
                close(h(k));
            end
            k = k + 1;
        end
    end

end

%% -- perform cluster-based permutation analysis

% -- create output directory for permutation results
pout.path_out_subfolder = [pout.path_out, 'Permutation\'];
if ~exist(pout.path_out_subfolder, 'dir') && pout.saveWork
    mkdir(pout.path_out_subfolder);
end

% -- define plotting parameters
latency = [25, 45, 70, 100, 180];
fs = 1000;
crange = [-5, 5];
crangel = {[15 35], [35 55], [60 80], [90 120], [170 190]};


% -- select data for HC and ST comparisons
cdata =  [];
k = 1;
while k <= length(cvisitALL)
    if strcmpi(cvisitALL{k}, 'V1')
        cdata =  [cdata, nin_subselect_dstruct(tepf, 'visit', 'V1', 'stim_side', 'Dominant', 'tphase', 'all'),...
            nin_subselect_dstruct(tepf, 'visit', 'V1', 'stim_side', 'Nondominant', 'tphase', 'all')];
    else
        cdata =  [cdata, nin_subselect_dstruct(tepf, 'visit', cvisitALL{k}, 'stim_side', 'Ipsilesional', 'tphase', 'all'),...
            nin_subselect_dstruct(tepf, 'visit', cvisitALL{k}, 'stim_side', 'Contralesional', 'tphase', 'all')];
    end
    k = k + 1;
end

ccdata = nin_function(cdata, @(x) x(:, 1:2:end-1), {'data'}, {'data'});
[ccdata.data_columns] = deal(cdata(1).data_columns(:, 1:2:end-1));

% -- group data by experimental condition
cdata_group = nin_group_data(ccdata, {'data'}, {'visit', 'stim_side', 'condition', 'tphase', ['stimulatio' ...
    'n']});
[cdata_group.data_rows] = deal(ccdata(1).data_rows);
[cdata_group.data_columns] = deal(ccdata(1).data_columns);

k = 1;
while k <= size(cdata_group, 2)

    % -- identify significant clusters around predefined TEP peaks
    [cclu] = nin_clustering_field(cdata_group(k), [], latency);
    cclu.visit = cdata_group(k).visit;
    cclu.stim_side = cdata_group(k).stim_side;
    cclu.condition = cdata_group(k).condition;
    cclu.tphase = cdata_group(k).tphase;
    cclu.stimulation = cdata_group(k).stimulation;
    % -- convert cluster mask for visualization
    cclu.p_new = cclu.p;
    cclu.p = ~cclu.mask;

    % -- store clustering results
    clu(k) = cclu;

    % -- generate cluster topographic maps
    h = nin_topoplot(clu(k), clu(k), 'crange', crange);

    k1 = 1;
    while k1 <= length(h)
        set(0, 'currentfigure', h(k1));
        cname = [cdata_group(k).stimulation, ': ', cdata_group(k).condition, ', ', cdata_group(k).visit, ', ', cdata_group(k).stim_side, ', ', cdata_group(k).tphase, ', ', strrep(h(k1).Name, '_', ' ')];
        sgtitle(cname);
        % -- save topographic map
        if pout.saveWork
            pout.fielname_out = char(nin_strsplit({strrep(strrep(strrep(cname, ': ', '_'), ', ', '_'), ' ', '_')}, 1, 7, 'spliter', '_'));
            exportgraphics(h(k1), [pout.path_out_subfolder, pout.fielname_out, '.tiff'], 'Resolution', 300);
        end
        k1 = k1 + 1;
    end

    % -- close generated figures
    k1 = 1;
    while k1 <= length(h)
        if isempty(strfind(h(k1).Name, 'EEGLAB'))
            close(h(k1));
        end
        k1 = k1 + 1;
    end

    k = k + 1;

end

clear cdata ccdata cdata_group h cname cclu k1

%% -- average activity across common significant channels

% -- prepare clustered TEP dataset
tepf_clustered = tepf;

% -- exclude combined phase data
tepf_clustered = tepf_clustered(strcmpi({tepf_clustered.tphase}, 'all'));
tepf_clustered = nin_function(tepf_clustered, @(x) x(:, 1:2:end-1), {'data'}, {'data'});
[tepf_clustered.data_columns] = deal(tepf_clustered(1).data_columns(1:2:end-1));
[tepf_clustered.data_rows] = deal({'Clustered'});

% -- preserve data for visualization
tepf_clustered_orig = tepf_clustered;

% -- create mask
cmask_DC = false(length(tepf(1).data_rows), length(tepf_clustered(1).data_columns), 6);
cmask_NI = false(length(tepf(1).data_rows), length(tepf_clustered(1).data_columns), 6);

% -- assign cluster masks for visit v2
cmask_DC(:, :, 2) = clu(strcmpi({clu.stim_side}, 'Contralesional') & strcmpi({clu.visit}, 'V2')).mask;
cmask_NI(:, :, 2) = clu(strcmpi({clu.stim_side}, 'Ipsilesional') & strcmpi({clu.visit}, 'V2')).mask;
% -- assign cluster masks for visit v5
cmask_DC(:, :, 5) = clu(strcmpi({clu.stim_side}, 'Contralesional') & strcmpi({clu.visit}, 'V5')).mask;
cmask_NI(:, :, 5) = clu(strcmpi({clu.stim_side}, 'Ipsilesional') & strcmpi({clu.visit}, 'V5')).mask;

k = 1;
while k <= size(tepf_clustered, 2)

    % -- select mask based on stimulation side and visit
    switch tepf_clustered(k).stim_side
        case {'Dominant', 'Contralesional'}
            cmask = squeeze(cmask_DC(:, :, str2num(strrep(tepf_clustered(k).visit, 'V', ''))));
        case {'Nondominant', 'Ipsilesional'}
            cmask = squeeze(cmask_NI(:, :, str2num(strrep(tepf_clustered(k).visit, 'V', ''))));
        otherwise
            cmask = false(length(tepf(1).data_rows), length(tepf_clustered(1).data_columns));
    end

    % -- apply cluster mask to amplitude data
    cdata = tepf_clustered(k).data;
    cdata(~cmask) = nan;
    % -- average values within the masked cluster
    cdata = mean(cdata, 'omitnan');
    tepf_clustered(k).data = cdata;

    k = k + 1;

end

clear cdata cname cmask cdata_time cdata_time2 cmask_time kv ks kp m n h th cdata1 cdata2 ix_time time tepf_clustered_plot

%% -- correlation TEP with clinical measures

% -- create output folder
pout.path_out_subfolder = [pout.path_out, 'Corr with clin\'];
if ~exist(pout.path_out_subfolder, 'dir') && pout.saveWork
    mkdir(pout.path_out_subfolder);
end

% -- define analysis parameters
stim_side = {'Contralesional', 'Ipsilesional'};
visit_ST = {'V2', 'V3', 'V4', 'V5', 'V6'};
ses_nr = 0:4;
clinM = {'moca', 'fmue', 'arat', 'cahai', 'fmue_hand'};
TEP = {'P25', 'N45', 'P70', 'N100', 'P180'};
pth = 0.05;

% -- iterate across stimulation sides
k = 1;
ks = 1;
while ks <= length(stim_side)

    % -- iterate across visits
    k1 = 1;
    while k1 <= length(visit_ST)

        visit1 = visit_ST{k1};
        ses_nr1 = ses_nr(k1);

        % -- select clinical data for current session
        ix_1 = [clin.ses_nr] == ses_nr1;
        clin_1 = clin(ix_1, :);
        % -- sort participants by participant id
        [C, ia] = sort({clin_1.part_id}');
        clin_1 = clin_1(ia);
        csub = {clin_1.part_id}';

        % -- select clustered tep data for current condition
        ix_1_MD = strcmpi({tepf_clustered.stim_side}, stim_side{ks}) & strcmpi({tepf_clustered.visit}, visit1);
        cMD_1 = tepf_clustered(ix_1_MD);

        % -- match participants between clinical and tep datasets
        [C, ia, ib] = intersect(csub, {cMD_1.sub});
        cclin_1 = clin_1(ia, :);
        cMD_1 = reshape([cMD_1(ib).data], 5, [])';

        % -- iterate across clinical measures
        km = 1;
        while km <= length(clinM)

            cclin = clinM{km};
            x = [cclin_1.(cclin)]';

            % -- iterate across tep components
            kt = 1;
            while kt <= length(TEP)

                % -- extract tep amplitudes
                cMD = [TEP{kt}, '_amp'];
                y = cMD_1(:, strcmpi(tepf_clustered(1).data_columns, cMD));
                % -- exclude missing values
                ix_nan = ~isnan(x) & ~isnan(y);
                % -- compute correlation
                if all(~ix_nan)
                    rho = nan(1, 1);
                    pval = nan(1, 1);
                else
                    [rho, pval] = corr(x(ix_nan), y(ix_nan));
                end
                % -- store correlation results
                clin_MD(k).visit = visit1;
                clin_MD(k).stim_side = stim_side{ks};
                clin_MD(k).clin = cclin;
                clin_MD(k).MD = cMD;
                clin_MD(k).x = x;
                clin_MD(k).y = y;
                clin_MD(k).r = rho;
                clin_MD(k).p = pval;
                clin_MD(k).n = length(x(ix_nan));

                k = k + 1;

                kt = kt + 1;

            end

            km = km + 1;

        end

        k1 = k1 + 1;

    end

    ks = ks + 1;

end

% -- save correlation results
if pout.saveWork
    save([pout.path_out_subfolder, 'Corr_results.mat'], 'clin_MD', '-v7.3');
end

% -- retain significant correlations
ix_keep = find([clin_MD.p] < pth);

% -- define figure formatting parameters
fW = 17.5;
fH = 18;
fFont = 'Ariel';
fFontSize = 9;
fFontSizeTick = 8;
fFontSizeSTitle = 10;
fFontSizeTitle = 11;
fFontWeight = 'bold';
fFontWeightTick = 'normal';
lineWidth = 1;
axesLineWidth = 0.75;
markerSize = 8;
alphaerrorBand = 0.2;
alphafreqHighlight = 0.25;

% -- generate scatter plots for significant correlations
k = 1;
while k <= length(ix_keep)

    h = figure('Color','w');
    scatter(clin_MD(ix_keep(k)).x, clin_MD(ix_keep(k)).y, markerSize, 'k', 'MarkerFaceColor', 'flat');
    hold on;
    h2 = lsline;
    h2.LineWidth = lineWidth;
    h2.Color = 'r';
    xlabel([upper(clin_MD(ix_keep(k)).clin), ' at ', clin_MD(ix_keep(k)).visit], 'Interpreter', 'none','FontName', fFont, 'FontSize', fFontSize);
    ylabel(['TEP - ', strrep(clin_MD(ix_keep(k)).MD, '_amp', ''), ' at ', clin_MD(ix_keep(k)).visit], 'Interpreter', 'none');
    text(0.05, 0.9, ['r = ', num2str(clin_MD(ix_keep(k)).r, '%.2f'), ' p = ', num2str(clin_MD(ix_keep(k)).p, '%.3f')], 'Units', 'normalized','FontName', fFont, 'FontSize', fFontSize);
    title(clin_MD(ix_keep(k)).stim_side, ...
        'FontName', fFont, ...
        'FontSize', fFontSizeSTitle, ...
        'FontWeight', fFontWeight, ...
        'interpreter', 'none');

    set(gca, 'FontName', fFont, ...
        'FontSize', fFontSizeTick, ...
        'FontWeight', fFontWeightTick, ...
        'LineWidth', axesLineWidth);

    % -- save figure
    if pout.saveWork
        saveas(h, [pout.path_out_subfolder, 'corr_', clin_MD(ix_keep(k)).clin, '_', strrep(clin_MD(ix_keep(k)).MD, 'inv', ''), '_', clin_MD(ix_keep(k)).visit, '_', clin_MD(ix_keep(k)).stim_side, '.fig']);
        exportgraphics(h, [pout.path_out_subfolder, 'corr_', clin_MD(ix_keep(k)).clin, '_', strrep(clin_MD(ix_keep(k)).MD, 'inv', ''), '_', clin_MD(ix_keep(k)).visit, '_', clin_MD(ix_keep(k)).stim_side, '.tiff'], 'Resolution', 300);
    end

    close(h);

    k = k + 1;

end

