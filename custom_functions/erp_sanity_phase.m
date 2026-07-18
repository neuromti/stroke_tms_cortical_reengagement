function [sub_DC, sub_NI, crows, ccolumns, ix] = erp_sanity_phase(erp, sub, visit, demog, phases)

%% -- This local function removes sessions that are missing one or more phases

ix = true(length(erp), 1);

% -- availability matrix for dominant/contralesional conditions
sub_DC = false(length(sub), length(visit) + 1);
% -- availability matrix for nondominant/ipsilesional conditions
sub_NI = false(length(sub), length(visit) + 1);

% -- stores condition assignment for each subject
ccondition = cell(length(sub), 1);
ks = 1;
while ks <= length(sub)

    % -- select demographic information for the current subject
    cdemog = nin_subselect_dstruct(demog, 'sub', sub{ks});
    % -- store subject condition
    ccondition{ks} = cdemog.condition;

    kv = 1;
    while kv <= length(visit)

        % -- uses dominant and nondominant stimulation sides
        if strcmpi(visit{kv}, 'V1')
            [DC, ix_DC] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Dominant', 'stimulation', 'TMS');
            [NI, ix_NI] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Nondominant', 'stimulation', 'TMS');
            DC_S = [];
            NI_S = [];
        else
            % -- uses contralesional and contralesional stimulation sides
            [DC, ix_DC] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'stimulation', 'TMS');
            [NI, ix_NI] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'stimulation', 'TMS');
            [DC_S, ix_DC_S] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'stimulation', 'SHAM');
            [NI_S, ix_NI_S] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'stimulation', 'SHAM');
        end

        % -- verify that all required phases exist for the dominant/contralesional condition
        if ~isempty(DC)
            if size(DC, 2) ~= (length(phases) + 1)
                ix = ix & ~ix_DC;
            else
                sub_DC(ks, kv) = true;
            end
        end

        % -- verify that all required phases exist for the nondominant/ipsilesional condition
        if ~isempty(NI)
            if size(NI, 2) ~= (length(phases) + 1)
                ix = ix & ~ix_NI;
            else
                sub_NI(ks, kv) = true;
            end
        end

        % -- verify completeness of contralesional sham data
        if ~isempty(DC_S)
            if size(DC_S, 2) ~= (length(phases) + 1)
                ix = ix & ~ix_DC_S;
            else
                sub_DC(ks, kv + 1) = true;
            end
        end

        % -- verify completeness of ipsilesional sham data
        if ~isempty(NI_S)
            if size(NI_S, 2) ~= (length(phases) + 1)
                ix = ix & ~ix_NI_S;
            else
                sub_NI(ks, kv + 1) = true;
            end
        end

        kv = kv + 1;

    end

    ks = ks + 1;

end

%% -- print the number of subjects available for analysis at each visit

% -- V1
cV = 'V1';
cDC = sub_DC(:, strcmpi(visit, cV));
cDC = nnz(cDC);
cNI = sub_NI(:, strcmpi(visit, cV));
cNI = nnz(cNI);
disp(['V1 - Dominant: ', num2str(cDC)]);
disp(['V1 - Nondominant: ', num2str(cNI)]);

% -- V2
cV = 'V2';
cDC = sub_DC(:, strcmpi(visit, cV));
cDC = nnz(cDC);
cNI = sub_NI(:, strcmpi(visit, cV));
cNI = nnz(cNI);
disp(['V2 - Contralesional: ', num2str(cDC)]);
disp(['V2 - Ipsilesional: ', num2str(cNI)]);

% -- V3
cV = 'V3';
cDC = sub_DC(:, strcmpi(visit, cV));
cDC = nnz(cDC);
cNI = sub_NI(:, strcmpi(visit, cV));
cNI = nnz(cNI);
disp(['V3 - Contralesional: ', num2str(cDC)]);
disp(['V3 - Ipsilesional: ', num2str(cNI)]);

% -- V4
cV = 'V4';
cDC = sub_DC(:, strcmpi(visit, cV));
cDC = nnz(cDC);
cNI = sub_NI(:, strcmpi(visit, cV));
cNI = nnz(cNI);
disp(['V4 - Contralesional: ', num2str(cDC)]);
disp(['V4 - Ipsilesional: ', num2str(cNI)]);

% -- V5
cV = 'V5';
cDC = sub_DC(:, strcmpi(visit, cV));
cDC = nnz(cDC);
cNI = sub_NI(:, strcmpi(visit, cV));
cNI = nnz(cNI);
disp(['V5 - Contralesional: ', num2str(cDC)]);
disp(['V5 - Ipsilesional: ', num2str(cNI)]);

% -- V6
cV = 'V6';
cDC = sub_DC(:, strcmpi(visit, cV));
cDC = nnz(cDC);
cNI = sub_NI(:, strcmpi(visit, cV));
cNI = nnz(cNI);
disp(['V6 - Contralesional: ', num2str(cDC)]);
disp(['V6 - Ipsilesional: ', num2str(cNI)]);

% -- SHAM
cDC = sub_DC(:, end);
cDC = nnz(cDC);
cNI = sub_NI(:, end);
cNI = nnz(cNI);
disp(['SHAM - Contralesional: ', num2str(cDC)]); % SHAM should be last column
disp(['SHAM - Ipsilesional: ', num2str(cNI)]);

% -- V1 D vs N
cV = 'V1';
cDC = sub_DC(:, strcmpi(visit, cV));
cNI = sub_NI(:, strcmpi(visit, cV));
cDCNI = nnz(cDC & cNI);
disp(['V1 - Dominant vs Nondominant: ', num2str(cDCNI)]);

% -- V2 D vs N
cV = 'V2';
cDC = sub_DC(:, strcmpi(visit, cV));
cNI = sub_NI(:, strcmpi(visit, cV));
cDCNI = nnz(cDC & cNI);
disp(['V2 - Dominant vs Nondominant: ', num2str(cDCNI)]);

% -- V3 D vs N
cV = 'V3';
cDC = sub_DC(:, strcmpi(visit, cV));
cNI = sub_NI(:, strcmpi(visit, cV));
cDCNI = nnz(cDC & cNI);
disp(['V3 - Dominant vs Nondominant: ', num2str(cDCNI)]);

% -- V4 D vs N
cV = 'V4';
cDC = sub_DC(:, strcmpi(visit, cV));
cNI = sub_NI(:, strcmpi(visit, cV));
cDCNI = nnz(cDC & cNI);
disp(['V4 - Dominant vs Nondominant: ', num2str(cDCNI)]);

% -- V5 D vs N
cV = 'V5';
cDC = sub_DC(:, strcmpi(visit, cV));
cNI = sub_NI(:, strcmpi(visit, cV));
cDCNI = nnz(cDC & cNI);
disp(['V5 - Dominant vs Nondominant: ', num2str(cDCNI)]);

% -- V6 D vs N
cV = 'V6';
cDC = sub_DC(:, strcmpi(visit, cV));
cNI = sub_NI(:, strcmpi(visit, cV));
cDCNI = nnz(cDC & cNI);
disp(['V6 - Dominant vs Nondominant: ', num2str(cDCNI)]);

%% -- count subjects with complete tms data across all visits v2-v6

% -- SHAM D vs N% -- SHAM D vs N
cDC = sub_DC(:, end);
cNI = sub_NI(:, end);
cDCNI = nnz(cDC & cNI);
disp(['SHAM - Dominant vs Nondominant: ', num2str(cDCNI)]);

% -- V1-V6
cDC = sub_DC(:, find(strcmpi(visit, 'V2')):find(strcmpi(visit, 'V6')));
cNI = sub_NI(:, find(strcmpi(visit, 'V2')):find(strcmpi(visit, 'V6')));
cDCNI = nnz(all(cDC & cNI, 2));
disp(['V1 - V6: ', num2str(cDCNI)]);

% -- create row labels for output tables
crows = [sub', ccondition];

% -- create column labels for output tables
ccolumns = [visit, {'SHAM'}];

end