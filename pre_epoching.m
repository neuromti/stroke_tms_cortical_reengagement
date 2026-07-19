% -------------------------------------------------------------------------
%  Project: INTENS 2019
%  Task:    Epoching data
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
pout.path_in = '/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/data_out/Cleaned_IA_23a/';

% -- define output directory
pout.path_out = '/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/data_out/';

% -- define supplementary directory and filename
pout.path_supplementary = '/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/Supplementary/';
pout.tms_file = ['TMS_pulses_', pout.pro_name, '.mat'];

%% -- create data out folder

% -- get current timestamp
ctime = nin_ctime;

% -- define output path
pout.path_out = [pout.path_out, 'Epoched_', pout.pro_name, filesep];
if ~exist(pout.path_out, 'dir') && pout.saveWork
    mkdir(pout.path_out);
end

%% - read TMS labels

% -- read the data and convert it into a structured format
load([pout.path_supplementary, pout.tms_file]);

%% -- epoched data subject by subject

% -- get input files
fileList = dir([pout.path_in '*.mat' ]);
fileList = {fileList.name};
fileList = fileList(~contains(fileList, 'analysis_report.mat'));

k = 1;
while k <= length(fileList)

    % -- define input file information
    x(k).path_in =  pout.path_in;
    x(k).filename_in = fileList{k};
    disp(['Loading file ', num2str(k), '/', num2str(length(fileList))]);

    try

        %% -- load data

        load([x(k).path_in, x(k).filename_in]);

        % -- initialize working structure
        if exist('rdata', 'var')
            cdata =  rdata;
            clear rdata
        end
        if size(cdata.eeg.ts, 1) > 1
            cdata.eeg.ts = cdata.eeg.ts';
        end

        %% -- epoche data

        % -- subselect TMS data for current subject
        % -- define filename split positions
        cTMS = nin_subselect_dstruct(TMS, 'filename', strrep(x(k).filename_in, '_cleaned.mat', '.mat'));
        id_event = num2cell(1:length(cTMS));
        [cTMS.id_event] = id_event{:};

        if ~all(isnan(cdata.lmarkers.index))

            %% -- epoch eeg data

            if ~isfield(cdata.eeg, 'estrate')
                [cdata.eeg.estrate] = deal(nan);
            end
            edata = nin_data_epoching(cdata.eeg, [cTMS.stimuli], 'direction', 'pre-post', 'win_len', 1);

            ix_e = cell2mat(cellfun(@isempty, {edata.id_event}, 'un', 0));
            if any(ix_e)
                ix_f = find(ix_e == false);
                nandata = nan(size(edata(ix_f(1)).data));
                datar =  edata(ix_f(1)).data_rows;
                datac =  edata(ix_f(1)).data_columns;
                nantime = edata(ix_f(1)).time;
                nanstrate = edata(ix_f(1)).strate;
                estrate = nan;
                ix_e = find(ix_e);
                k1 = 1;
                while k1 <= length(ix_e)
                    edata(ix_e(k1)).id_event = ix_e(k1);
                    k1 = k1 + 1;
                end
                [edata(ix_e).data] = deal(nandata);
                [edata(ix_e).data_rows] = deal(datar);
                [edata(ix_e).data_columns] = deal(datac);
                [edata(ix_e).time] = deal(nantime);
                [edata(ix_e).strate] = deal(nanstrate);
                [edata(ix_e).estrate] = deal(estrate);
            end

            %% -- correction of background oscillatory activity

            % -- get reference window indices
            [~, ix_pre] = intersect(edata(1).time, -1000:-1);

            % -- get correction window indices
            [~, ix_shift] = intersect(edata(1).time, -499:500);

            % -- extract epoch data
            dataOrig = {edata.data}';

            % -- initialize correction matrix
            dataCor = repmat({zeros(size(edata(1).data))}, size(edata, 2), 1);

            % -- correction
            k1 = 1;
            while k1 <= length(dataOrig)

                dataCor{k1, 1}(:, ix_shift') = dataOrig{k1, 1}(:, ix_pre');
                dataOrig{k1, 1} = dataOrig{k1} - dataCor{k1, 1};

                k1 = k1 + 1;

            end

            % -- update corrected data
            [edata.data] = dataOrig{:};

            %% -- merge EEG and EMG data

            edata = nin_merge_structures(edata, cTMS, {'id_event'});

            %% -- export data

            % -- define output filename
            x(k).path_out =  pout.path_out;
            x(k).filename_out = strrep(x(k).filename_in, '.mat', '_epoched.mat');

            % -- save output data
            if pout.saveWork
                save([x(k).path_out, x(k).filename_out], 'edata', '-v7.3');
            end

            % -- store processing status
            x(k).passed =  true;
            x(k).comment =  '';

        else

            % -- store missing marker information
            x(k).path_out =  '';
            x(k).filename_out = '';
            x(k).passed =  false;
            x(k).comment =  'markers are missing';

        end

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