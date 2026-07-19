% -------------------------------------------------------------------------
%  Project: INTENS 2019
%  Task:    gather ERP
% -------------------------------------------------------------------------

% -- clear workspace, close all figures, and clear command window
clear all; close all; clc;

% -- initialize project settings and enable saving of results
pout = def_pro('IA_23a', 'saveWork', false);

%% -- diary and load eeglab

if pout.saveWork
    % -- extract timestamp information from archive path
    time = strsplit(pout.archive_NIN_path, filesep);
    time = time{contains(time, 'NIN')};

    % -- create diary file for software version tracking
    diary([pout.archive_path, 'softare_version', strrep(time, 'NIN', ''), '.txt'])

    % -- display current MATLAB version
    disp(['Matlab ', version]);

    diary off
end

%% -- define input parameters

% -- define input directory
pout.path_in = ['/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/data_out/Epoched_', pout.pro_name, filesep];

% -- define output directory
pout.path_out = ['/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/ERP_', pout.pro_name, filesep];

%% -- create data out folder

if ~exist(pout.path_out, 'dir') && pout.saveWork
    mkdir(pout.path_out);
end

%% -- calculate erp data for each subject

% -- get input files
fileList = dir([pout.path_in '*.mat' ]);
fileList = {fileList.name};
fileList = fileList(~contains(fileList, 'analysis_report.mat'));

k = 1;
while k <= length(fileList)

    % -- define input file information
    x(k).path_in =  pout.path_in;
    x(k).filename_in = fileList{k};
    disp(['Loading file ', num2str(k), filesep, num2str(length(fileList))]);

    try

        %% -- load data

        load([x(k).path_in, x(k).filename_in]);

        %% -- reject bad epochs - replace data with NaN

        [edata(~([edata.valid] & [edata.valid_cleaning] & [edata.valid_distance])).data] = deal(NaN(size(edata(1).data, 1), size(edata(1).data, 2)));

        %% -- remove trials without phase markers

        ix_nan = isnan([edata.tphase]);
        Nnan = nnz(ix_nan);
        edata = edata(~ix_nan);

        %% -- calc ERPs by phase and frquency

        erp = nin_erp_gather(edata);

        %% -- filter data to 20 Hz and remove redundant entries

        erp = erp(strcmpi({erp.tfreq}, '20'));

        %% -- add missing fields

        [erp.filename] = deal(edata(1).filename);
        [erp.filename_new] = deal(edata(1).filename);
        [erp.Nnan] = deal(Nnan);
        [erp.session] = deal(edata(1).session);
        [erp.stimulation] = deal(edata(1).stimulation);
        [erp.Condition] = deal(edata(1).Condition);

        %% -- export data

        x(k).path_out =  pout.path_out;
        x(k).filename_out = strrep(x(k).filename_in, '.mat', '_ERP.mat');

        if pout.saveWork
            save([x(k).path_out, x(k).filename_out], 'erp', '-v7.3');
        end

        % -- store processing status
        x(k).passed =  true;
        x(k).comment =  '';

    catch

        % -- store processing error
        x(k).path_out =  '';
        x(k).filename_out = '';
        x(k).passed =  false;
        x(k).comment =  'error';

    end

    k  = k + 1;

end

%% -- save analysis report

if pout.saveWork
    save([pout.path_out, 'analysis_report.mat'], 'x');
end