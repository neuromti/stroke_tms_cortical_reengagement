% -------------------------------------------------------------------------
%  Project: INTENS 2019
%  Task:    Pulling data healthy control - Data Extraction and Conversion from XDF Files
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

% -- main directory containing subject folders and XDF files
pout.path_main = '/mnt/data/data08/RawData/2019_ST_IN-TENS/healthy_controls/';

% -- options passed to XDF loading function
pout.in_fetures = {'HandleClockSynchronization', false};

% -- base output directory
pout.path_out = '/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/data_out/';

%% -- create data out folder

% -- generate current timestamp
ctime = nin_ctime;

% -- create timestamped output directory
pout.path_out = [pout.path_out, 'Raw_HC_', ctime, filesep];
if ~exist(pout.path_out, 'dir') && pout.saveWork
    mkdir(pout.path_out);
end

%% -- select task for processing

task_name = '100RMT'; % 'IO', 'MSO'

%% -- load study protocols

% -- import participant information and recording metadata.
[~, ~, P] = xlsread('/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/Supplementary/Recordings_INTENS_2019.xlsx');
T = cell2table(P(2:end, :));
T.Properties.VariableNames = P(1, :);
P = table2struct(T);

% -- load L marker definitions
[~, ~, L] = xlsread('/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/Supplementary/TaskMarkers_L_INTENS_2019.xlsx');
T = cell2table(L(2:end, :));
T.Properties.VariableNames = L(1, :);
L = table2struct(T);

% -- load IMSD(SpongeBoB) marker definitions
[~, ~, S] = xlsread('/mnt/data/data09/FinalizedStudies/2026_INTENS_MSK/Supplementary/TaskMarkers_SD_INTENS_2019.xlsx');
T = cell2table(S(2:end, :));
T.Properties.VariableNames = S(1, :);
S = table2struct(T);

%% -- read xdf data subject by subject

% -- get all folders from the main directory
folderList = dir(pout.path_main);
folderList = {folderList([folderList.isdir]).name};
folderList = folderList(~ismember(folderList, {'.', '..'}));
folderList = folderList(~ismember(folderList, {'rejected'}));

%% -- constants

% -- phase channel
p_ch = 13;
% -- bipolar channel
s_ch = 11;
% -- minimum sample distance between tasks
diff_dp = 300000;
% -- minimum break duration
t_break = 10000;
% -- task markers
marker_fields = {'TMS_RMT_Start_1';...
    'TMS_RMT_Stop_1';...
    'TMS_IO_Start_1';...
    'TMS_IO_Stop_1';...
    'TMS_MSO_Start_1';...
    'TMS_MSO_Stop_1';...
    'TMS_RMT_Start_2';...
    'TMS_RMT_Stop_2';...
    'TMS_IO_Start_2';...
    'TMS_IO_Stop_2';...
    'TMS_MSO_Start_2';...
    'TMS_MSO_Stop_2';...
    'SHAM_RMT_Start_1';...
    'SHAM_RMT_Stop_1';...
    'SHAM_IO_Start_1';...
    'SHAM_IO_Stop_1';...
    'SHAM_MSO_Start_1';...
    'SHAM_MSO_Stop_1';...
    'SHAM_RMT_Start_2';...
    'SHAM_RMT_Stop_2';...
    'SHAM_IO_Start_2';...
    'SHAM_IO_Stop_2';...
    'SHAM_MSO_Start_2';...
    'SHAM_MSO_Stop_2'};
% -- visit labels
visits = {'pre1', 'pre2', 'post1', 'post2', 'pre3', 'pre4', 'post3', 'post4', 'post5', 'post6'};
% -- variables preserved during workspace cleanup
keep_vars = {'pout'; 'ctime'; 'task_name'; 'P'; 'L'; 'S'; 'p_ch'; 's_ch'; 'diff_dp'; 't_break'; 'marker_fields'; 'visits'; 'keep_vars'; 'folderList'; 'subfolderList'; 'fileList'; 'cname'; 'x'; 'c1'; 'k'};

k = 1; c1 = 1;
while k <= length(folderList)

    % -- define current input path
    pout.path_in = [pout.path_main, folderList{k}, filesep];

    % -- get xdf files for current subject
    fileList = dir([pout.path_in '*TMS*.xdf' ]);
    fileList = {fileList.name};

    % -- store input information
    x(c1).path_in =  pout.path_in;
    x(c1).filename_in = fileList;
    x(c1).in_fetures = pout.in_fetures;

    try

        %% -- concatinate all data

        cvars = who;
        remove_vars = [setdiff(cvars, keep_vars); {'remove_vars'}];

        clear(remove_vars{:});

        ctime = [];
        k2 = 1;
        while k2 <= length(fileList)

            % -- store input information
            cx = x(c1);
            cx.filename_in = fileList{k2};

            disp(['Loading file ', num2str(k2), '/', num2str(length(fileList)), ' in folder ', num2str(k), '/', num2str(length(folderList))]);

            cname = char(nin_strsplit({cx.filename_in}, 3, 3, 'spliter', '_'));
            csession = 'pre1';

            %% -- load xdf data

            rdata = nin_read_xdf(cx);
            rdata_colaps(k2) = rdata;

            %% -- find markers for all tasks IMSD

            sb_data = rdata.sd.data(p_ch, :)';
            sb_time = rdata.sd.ts(1, :)';
            ctime = [ctime; sb_time(1, 1)];

            k2  = k2 + 1;

        end

        % -- concatenate recording blocks
        if exist('rdata_colaps', 'var')

            % -- sort recordings according to acquisition order
            [~, ix_sort] = sort(ctime);
            rdata_colaps = rdata_colaps(ix_sort);

            % -- handle single recording
            if size(rdata_colaps, 2) == 1

                rdata = rdata_colaps;

            else

                % -- initialize merged structure
                [rdata.filename_in] = ({rdata_colaps.filename_in})';
                rdata.lmarkers.ts = [];
                rdata.lmarkers.data = [];
                rdata.rdamarkers.data = [];
                rdata.rdamarkers.ts = [];
                rdata.markers.data = [];
                rdata.markers.ts = [];
                rdata.eeg.data = [];
                rdata.eeg.ts = [];
                rdata.eeg.strate = [];
                rdata.eeg.channels = [];
                rdata.eeg.unit = [];
                rdata.sd.data = [];
                rdata.sd.ts = [];
                rdata.sd.strate = [];

                % -- concatenate recording streams
                k2 = 1;
                while k2 <= size(rdata_colaps, 2)

                    rdata.lmarkers.ts = [rdata.lmarkers.ts, rdata_colaps(k2).lmarkers.ts];
                    rdata.lmarkers.data = [rdata.lmarkers.data, rdata_colaps(k2).lmarkers.data];
                    rdata.rdamarkers.data = [rdata.rdamarkers.data, rdata_colaps(k2).rdamarkers.data];
                    rdata.rdamarkers.ts = [rdata.rdamarkers.ts, rdata_colaps(k2).rdamarkers.ts];
                    rdata.markers.data = [rdata.markers.data, rdata_colaps(k2).markers.data];
                    rdata.markers.ts = [rdata.markers.ts, rdata_colaps(k2).markers.ts];
                    rdata.eeg.data = [rdata.eeg.data, rdata_colaps(k2).eeg.data];
                    rdata.eeg.ts = [rdata.eeg.ts, rdata_colaps(k2).eeg.ts];
                    rdata.eeg.strate = [rdata.eeg.strate, rdata_colaps(k2).eeg.strate];
                    rdata.eeg.channels = [rdata.eeg.channels, rdata_colaps(k2).eeg.channels];
                    rdata.eeg.unit = [rdata.eeg.unit, rdata_colaps(k2).eeg.unit];
                    rdata.sd.data = [rdata.sd.data, rdata_colaps(k2).sd.data];
                    rdata.sd.ts = [rdata.sd.ts, rdata_colaps(k2).sd.ts];
                    rdata.sd.strate = [rdata.sd.strate, rdata_colaps(k2).sd.strate];

                    k2  = k2 + 1;

                end

            end

            % -- average sampling rates across recordings
            rdata.eeg.strate = mean(rdata.eeg.strate);
            rdata.sd.strate = mean(rdata.sd.strate);

            % -- retain channel definition from first recording
            rdata.eeg.channels = rdata_colaps(1).eeg.channels;

            % -- preserve original merged recording
            rdata_orig = rdata;

            %% -- extract session-specific markers

            % -- subselect SB and Localite markers
            cS = nin_subselect_dstruct(S, 'Sub', cname, 'Session', csession);
            cL = nin_subselect_dstruct(L, 'Sub', cname, 'Session', csession);

            % -- RMT sb markers
            RMT_Start_S = [cS.TMS_RMT_Start_1, cS.TMS_RMT_Start_2, cS.SHAM_RMT_Start_1, cS.SHAM_RMT_Start_2];
            RMT_Stop_S = [cS.TMS_RMT_Stop_1, cS.TMS_RMT_Stop_2, cS.SHAM_RMT_Stop_1, cS.SHAM_RMT_Stop_2];

            % -- IO task sb markers
            IO_Start_S = [cS.TMS_IO_Start_1, cS.TMS_IO_Start_2, cS.SHAM_IO_Start_1, cS.SHAM_IO_Start_2];
            IO_Stop_S = [cS.TMS_IO_Stop_1, cS.TMS_IO_Stop_2, cS.SHAM_IO_Stop_1, cS.SHAM_IO_Stop_2];

            % -- MSO task sb markers
            MSO_Start_S = [cS.TMS_MSO_Start_1, cS.TMS_MSO_Start_2, cS.SHAM_MSO_Start_1, cS.SHAM_MSO_Start_2];
            MSO_Stop_S = [cS.TMS_MSO_Stop_1, cS.TMS_MSO_Stop_2, cS.SHAM_MSO_Stop_1, cS.SHAM_MSO_Stop_2];

            % -- RMT l markers
            RMT_Start_L = [cL.TMS_RMT_Start_1, cL.TMS_RMT_Start_2, cL.SHAM_RMT_Start_1, cL.SHAM_RMT_Start_2];
            RMT_Stop_L = [cL.TMS_RMT_Stop_1, cL.TMS_RMT_Stop_2, cL.SHAM_RMT_Stop_1, cL.SHAM_RMT_Stop_2];

            % -- IO task l markers
            IO_Start_L = [cL.TMS_IO_Start_1, cL.TMS_IO_Start_2, cL.SHAM_IO_Start_1, cL.SHAM_IO_Start_2];
            IO_Stop_L = [cL.TMS_IO_Stop_1, cL.TMS_IO_Stop_2, cL.SHAM_IO_Stop_1, cL.SHAM_IO_Stop_2];

            % -- MSO task l markers
            MSO_Start_L = [cL.TMS_MSO_Start_1, cL.TMS_MSO_Start_2, cL.SHAM_MSO_Start_1, cL.SHAM_MSO_Start_2];
            MSO_Stop_L = [cL.TMS_MSO_Stop_1, cL.TMS_MSO_Stop_2, cL.SHAM_MSO_Stop_1, cL.SHAM_MSO_Stop_2];

            %% -- identify complete task markers

            % -- valid RMT markers
            ix_RMT = ~isnan(RMT_Start_L) & ~isnan(RMT_Start_S) & ~isnan(RMT_Stop_L) & ~isnan(RMT_Stop_S);
            % -- valid IO markers
            ix_IO = ~isnan(IO_Start_L) & ~isnan(IO_Start_S) & ~isnan(IO_Stop_L) & ~isnan(IO_Stop_S);
            % -- valid MSO markers
            ix_MSO = ~isnan(MSO_Start_L) & ~isnan(MSO_Start_S) & ~isnan(MSO_Stop_L) & ~isnan(MSO_Stop_S);

            if any(ix_RMT) || any(ix_IO) || any(ix_MSO)

                %% -- find markers for all tasks spongebob

                % -- extract phase channel
                sb_data = rdata.sd.data(p_ch, :)';

                % -- identify continuous marker intervals
                markers = [];
                k2 = cS.TMS_RMT_Start_1;
                while k2 <= size(sb_data, 1)

                    ix_c = sb_data == sb_data(k2, 1);
                    diff_c = reshape(find(diff([0; ix_c; 0]) ~= 0), 2, []);
                    diff_c = diff_c(:, diff_c(1, :) >= k2);

                    markers = [markers; [sb_data(k2, 1), diff_c(1, 1), diff_c(2, 1)-1]];

                    k2 = diff_c(2, 1);

                end

                % -- initialize task marker indices
                RMT_Start_M = nan(1, length(RMT_Start_S));
                RMT_Stop_M = nan(1, length(RMT_Stop_S));
                IO_Start_M = nan(1, length(IO_Start_S));
                IO_Stop_M = nan(1, length(IO_Stop_S));
                MSO_Start_M = nan(1, length(MSO_Start_S));
                MSO_Stop_M = nan(1, length(MSO_Stop_S));
                % -- match SB task timestamps to detected markers
                k2 = 1;
                while k2 <= length(RMT_Start_M)

                    if ~isnan(RMT_Start_S(k2))
                        [~, ix_min_start] = min(abs((markers(:, 2) - RMT_Start_S(k2))));
                        [~, ix_min_stop] = min(abs((markers(:, 3) - RMT_Stop_S(k2))));
                        RMT_Start_M(k2) = ix_min_start;
                        RMT_Stop_M(k2) = ix_min_stop;
                    end

                    if ~isnan(IO_Start_S(k2))
                        [~, ix_min_start] = min(abs((markers(:, 2) - IO_Start_S(k2))));
                        [~, ix_min_stop] = min(abs((markers(:, 3) - IO_Stop_S(k2))));
                        IO_Start_M(k2) = ix_min_start;
                        IO_Stop_M(k2) = ix_min_stop;
                    end

                    if ~isnan(MSO_Start_S(k2))
                        [~, ix_min_start] = min(abs((markers(:, 2) - MSO_Start_S(k2))));
                        [~, ix_min_stop] = min(abs((markers(:, 3) - MSO_Stop_S(k2))));
                        MSO_Start_M(k2) = ix_min_start;
                        MSO_Stop_M(k2) = ix_min_stop;
                    end

                    k2 = k2 + 1 ;

                end

                % -- create global SpongeBoB marker indices
                ixS_RMT_Start = nan(1, length(RMT_Start_S));
                ixS_RMT_Stop = nan(1, length(RMT_Stop_S));
                ixS_RMT_Start(ix_RMT) = RMT_Start_S(ix_RMT);
                ixS_RMT_Stop(ix_RMT) = RMT_Stop_S(ix_RMT);

                ixS_IO_Start = nan(1, length(IO_Start_S));
                ixS_IO_Stop = nan(1, length(IO_Stop_S));
                ixS_IO_Start(ix_IO) = IO_Start_S(ix_IO);
                ixS_IO_Stop(ix_IO) = IO_Stop_S(ix_IO);

                ixS_MSO_Start = nan(1, length(MSO_Start_S));
                ixS_MSO_Stop = nan(1, length(MSO_Stop_S));
                ixS_MSO_Start(ix_MSO) = MSO_Start_S(ix_MSO);
                ixS_MSO_Stop(ix_MSO) = MSO_Stop_S(ix_MSO);

                %% -- create global Localite and EEG marker indices

                % -- convert index to the global (in lmarkers and eeg)
                ix_RMT_Start = nan(1, length(RMT_Start_L));
                ix_RMT_Stop = nan(1, length(RMT_Stop_L));
                ix_RMT_Start(ix_RMT) = RMT_Start_L(ix_RMT);
                ix_RMT_Stop(ix_RMT) = RMT_Stop_L(ix_RMT);

                ix_IO_Start = nan(1, length(IO_Start_L));
                ix_IO_Stop = nan(1, length(IO_Stop_L));
                ix_IO_Start(ix_IO) = IO_Start_L(ix_IO);
                ix_IO_Stop(ix_IO) = IO_Stop_L(ix_IO);

                ix_MSO_Start = nan(1, length(MSO_Start_L));
                ix_MSO_Stop = nan(1, length(MSO_Stop_L));
                ix_MSO_Start(ix_MSO) = MSO_Start_L(ix_MSO);
                ix_MSO_Stop(ix_MSO) = MSO_Stop_L(ix_MSO);

                %% -- extract specific task

                % -- select task-specific marker set
                switch task_name
                    case'100RMT'
                        ix_l_Start = ix_RMT_Start;
                        ix_l_Stop = ix_RMT_Stop;
                        ix_s_Start = ixS_RMT_Start;
                        ix_s_Stop = ixS_RMT_Stop;
                        ix_m_Start = RMT_Start_M;
                        ix_m_Stop = RMT_Stop_M;
                    case'IO'
                        ix_l_Start = ix_IO_Start;
                        ix_l_Stop = ix_IO_Stop;
                        ix_s_Start = ixS_IO_Start;
                        ix_s_Stop = ixS_IO_Stop;
                        ix_m_Start = IO_Start_M;
                        ix_m_Stop = IO_Stop_M;
                    case'MSO'
                        ix_l_Start = ix_MSO_Start;
                        ix_l_Stop = ix_MSO_Stop;
                        ix_s_Start = ixS_MSO_Start;
                        ix_s_Stop = ixS_MSO_Stop;
                        ix_m_Start = MSO_Start_M;
                        ix_m_Stop = MSO_Stop_M;
                end

            else

                ix_l_Start = [];
                ix_l_Stop = [];
                ix_s_Start = [];
                ix_s_Stop = [];
                ix_m_Start = [];
                ix_m_Stop = [];

            end

            % -- prepare task extraction
            if ~isempty(ix_l_Start) && ~isempty(ix_s_Start) && ~isempty(ix_m_Start)

                % -- extract subject information
                cSub = nin_subselect_dstruct(P, 'Sub', cname, 'Session', 'pre1');
                fSide = cSub.Stim_Side;

                % -- define stimulation side labels
                sideStim = {'Dominant', 'Nondominant'};
                if strcmpi(fSide, 'Nondominant')
                    sideStim = fliplr(sideStim);
                end
                if strcmpi(cSub.Parethic_Dominant_Side, 'L')
                    sideBrain = {'R', 'R'};
                else
                    sideBrain = {'L', 'L'};
                end
                sideBrain{1, strcmpi(sideStim, 'Dominant')} = cSub.Parethic_Dominant_Side;

                sideStim = [sideStim, sideStim];
                sideBrain = [sideBrain, sideBrain];

                % -- define output filenames
                name_out = [strcat(task_name, '_TMS_', cname, '_', csession, '_', sideStim(1:2)','.mat');...
                    strcat(task_name, '_SHAM_', cname, '_', csession, '_', sideStim(3:4)','.mat')];
                name_img_out = [strcat(task_name, '_TMS_', cname, '_', csession, '_', sideStim(1:2)','.png');...
                    strcat(task_name, '_SHAM_', cname, '_', csession, '_', sideStim(3:4)','.png')];

                switch task_name

                    % -- extract 100% RMT task
                    case '100RMT'

                        k2 = 1;
                        while k2 <= length(ix_l_Start)

                            if ~isnan(ix_l_Start(k2))

                                rdata = rdata_orig;

                                % -- retain task-specific Localite markers
                                rdata.lmarkers.data = rdata.lmarkers.data(ix_l_Start(k2):ix_l_Stop(k2));
                                rdata.lmarkers.ts = rdata.lmarkers.ts(ix_l_Start(k2):ix_l_Stop(k2));

                                % -- retain task-related EEG data
                                [diff_start, ix_start] = min(abs(rdata.eeg.ts - rdata.lmarkers.ts(1)));
                                [diff_stop, ix_stop] = min(abs(rdata.eeg.ts - rdata.lmarkers.ts(end)));
                                ix_start = ix_start - 5*rdata.eeg.strate;
                                ix_stop = ix_stop + 5*rdata.eeg.strate;
                                if ix_start < 1
                                    ix_start = 1;
                                end
                                if ix_stop > length(rdata.eeg.ts)
                                    ix_stop = length(rdata.eeg.ts);
                                end

                                rdata.eeg.data = rdata.eeg.data(:, ix_start:ix_stop);
                                rdata.eeg.ts = rdata.eeg.ts(:, ix_start:ix_stop);

                                % -- align Localite markers to EEG samples
                                rdata.lmarkers.index = nan(length(rdata.lmarkers.ts), 1);
                                % -- select motor cortex channel
                                if strcmpi(sideBrain{k2}, 'L')
                                    ch_C = strcmpi(rdata.eeg.channels, 'C3');
                                elseif strcmpi(sideBrain{k2}, 'R')
                                    ch_C = strcmpi(rdata.eeg.channels, 'C4');
                                end

                                k3 = 1;
                                while k3 <= length(rdata.lmarkers.ts)

                                    [~, ix_min] = min(abs(rdata.eeg.ts - rdata.lmarkers.ts(k3)));

                                    crange = ix_min-1*rdata.eeg.strate+1:ix_min+1*rdata.eeg.strate;
                                    cdata = rdata.eeg.data(ch_C, crange);
                                    % -- identify TMS artifact peak
                                    [pks, ix_peak] = findpeaks(cdata, 'MinPeakProminence', 500, 'NPeaks', 1);
                                    figure; plot(cdata); hold on; plot(ix_peak, pks, '*r', 'LineStyle', 'none');
                                    close(gcf);
                                    if ~isempty(ix_peak)
                                        rdata.lmarkers.index(k3) = crange(ix_peak);
                                    else
                                        rdata.lmarkers.index(k3) = ix_min;
                                    end
                                    k3 = k3 + 1;

                                end

                                % -- identify stimulation blocks separated by long pauses
                                portion_end = [find(diff(rdata.lmarkers.index) > t_break); length(rdata.lmarkers.index)];
                                portion_end_n = [];
                                k3 = 1;
                                k4 = k3 + 1;
                                while k3 <= length(portion_end) - 1 && k4 <= length(portion_end)

                                    cdiff = abs(portion_end(k3) - portion_end(k4));

                                    if cdiff >= 10
                                        portion_end_n = [portion_end_n; portion_end(k3); portion_end(k4)];
                                        k3 = k3 + 1;
                                        k4 = k3 + 1;
                                    else
                                        k4 = k4 + 1;
                                        f_flag = true;
                                        while k4 <= length(portion_end) && f_flag
                                            cdiff = abs(portion_end(k3) - portion_end(k4));
                                            if cdiff >= 10
                                                portion_end_n = [portion_end_n; portion_end(k3); portion_end(k4)];
                                                f_flag = false;
                                                k3 = k4;
                                                k4 = k3 + 1;
                                            else
                                                k4 = k4 + 1;
                                            end
                                        end
                                    end

                                end
                                portion_end_n = unique(portion_end_n);
                                portion_end = portion_end_n;

                                % -- assign block membership
                                rdata.lmarkers.portion = ones(length(rdata.lmarkers.index), 1);
                                k3 = 1;
                                while k3 <= length(portion_end)-1

                                    rdata.lmarkers.portion(portion_end(k3)+1:portion_end(k3+1)) = k3 + 1;

                                    k3 = k3 + 1;

                                end

                                % -- retain task-related SpongeBoB data
                                rdata.sd.data = rdata.sd.data(:, ix_s_Start(k2):ix_s_Stop(k2));
                                rdata.sd.ts = rdata.sd.ts(ix_s_Start(k2):ix_s_Stop(k2));
                                rdata.sd.markers = markers(ix_m_Start(k2):ix_m_Stop(k2), :);
                                rdata.sd.index = nan(size(rdata.sd.markers, 1), 1);

                                ix = rdata.sd.markers(1, 2):rdata.sd.markers(1, 2)+length(rdata.sd.ts)-1;
                                % -- detect stimulation pulses
                                [pks, ix_peak] = findpeaks(rdata.sd.data(s_ch, :), 'MinPeakProminence', 800, 'MinPeakDistance', 3500);

                                % -- correct pulse timing using detected peaks
                                rdata.sd.markers = [rdata.sd.markers, rdata.sd.markers(:, 2:3) + ix_peak(1)];

                                k3 = 1;
                                while k3 <= length(rdata.sd.markers)

                                    ix_m = find(ix == rdata.sd.markers(k3, 4));
                                    if isempty(ix_m)
                                        rdata.sd.index(k3) = NaN(1, 1);
                                    else
                                        rdata.sd.index(k3) = ix_m;
                                    end

                                    k3 = k3 + 1;

                                end

                                % -- identify stimulation blocks
                                portion_end = [find(diff(rdata.sd.index) > t_break); length(rdata.sd.index)];
                                portion_end_n = [];
                                k3 = 1;
                                k4 = k3 + 1;
                                while k3 <= length(portion_end) - 1 && k4 <= length(portion_end)

                                    cdiff = abs(portion_end(k3) - portion_end(k4));

                                    if cdiff >= 10
                                        portion_end_n = [portion_end_n; portion_end(k3); portion_end(k4)];
                                        k3 = k3 + 1;
                                        k4 = k3 + 1;
                                    else
                                        k4 = k4 + 1;
                                        f_flag = true;
                                        while k4 <= length(portion_end) && f_flag
                                            cdiff = abs(portion_end(k3) - portion_end(k4));
                                            if cdiff >= 10
                                                portion_end_n = [portion_end_n; portion_end(k3); portion_end(k4)];
                                                f_flag = false;
                                                k3 = k4;
                                                k4 = k3 + 1;
                                            else
                                                k4 = k4 + 1;
                                            end
                                        end
                                    end

                                end
                                portion_end_n = unique(portion_end_n);
                                portion_end = portion_end_n;

                                % -- visual quality-control of pulse alignment
                                f = figure;
                                plot(ix, rdata.sd.data(s_ch, :)); % data
                                hold on;
                                plot(ix(ix_peak), pks, '*r', 'LineStyle', 'none'); % stimuli
                                plot(rdata.sd.markers(:, 2)+ix_peak(1), (mean(pks)/2), '*g', 'LineStyle', 'none'); % corrected phase markers
                                plot(rdata.sd.markers(portion_end, 2)+ix_peak(1), (mean(pks)/2)+500, '*k', 'LineStyle', 'none'); % end of the portion of the pulses
                                title([sideStim{k2}, ': ', sideBrain{k2}, ' - ', cSub.Sub]);
                                ylabel({'Spongbob amplitude'; 'Green markers - corrected markers'});

                                % -- assign SpongeBoB block membership
                                rdata.sd.portion = ones(length(rdata.sd.index), 1);
                                k3 = 1;
                                while k3 <= length(portion_end)-1

                                    rdata.sd.portion(portion_end(k3)+1:portion_end(k3+1)) = k3 + 1;

                                    k3 = k3 + 1;

                                end

                                % -- match SpongeBoB phases with EEG markers
                                rdata.lmarkers.tphase = nan(length(rdata.lmarkers.index), 1);
                                % -- process aligned stimulation blocks
                                portions = intersect(unique(rdata.lmarkers.portion), unique(rdata.sd.portion));
                                k3 = 1;
                                while k3 <= length(portions)

                                    lmarkers_i = rdata.lmarkers.index(rdata.lmarkers.portion == portions(k3));
                                    sd_i = rdata.sd.index(rdata.sd.portion == portions(k3));
                                    markers_i = rdata.sd.markers(rdata.sd.portion == portions(k3), 1);

                                    lmarkers_i = lmarkers_i - lmarkers_i(1) + 1;
                                    sd_i = sd_i - sd_i(1) + 1;

                                    % -- assign stimulation phase to nearest EEG marker
                                    ctphase = nan(length(lmarkers_i), 1);
                                    k4 = 1;
                                    while k4 <= length(sd_i)

                                        [~, ix_min] = min(abs(lmarkers_i - sd_i(k4)));
                                        ctphase(ix_min) = markers_i(k4);

                                        k4 = k4 + 1;

                                    end

                                    rdata.lmarkers.tphase(rdata.lmarkers.portion == portions(k3)) = ctphase;
                                    k3 = k3 + 1;

                                end

                                %% -- export data

                                if pout.saveWork
                                    save([pout.path_out, name_out{k2}], 'rdata', '-v7.3');
                                    exportgraphics(f, [pout.path_out, name_img_out{k2}], 'Resolution', 300);
                                end

                                close(f);

                            end

                            k2 = k2 + 1;

                        end

                    case 'IO'

                    case 'MSO'

                end

                % -- processing completed successfully
                x(c1).path_out =  pout.path_out;
                x(c1).filename_out = name_out(~isnan(ix_l_Start));
                x(c1).passed =  true;
                x(c1).error =  0;

            else

                % -- required markers are missing
                x(c1).passed =  false;
                x(c1).error =  'file is uncompleted';

            end

        else

            % -- required markers are missing
            x(c1).passed =  false;
            x(c1).error =  'file is uncompleted';

        end

    catch ME

        x(c1).passed =  false;
        x(c1).error =  ME.stack.line;

    end

    if pout.saveWork
        save([pout.path_out, 'transfer_report.mat'], 'x');
    end

    c1 = c1 + 1;

    k = k + 1;

end

