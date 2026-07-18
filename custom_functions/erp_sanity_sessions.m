function [sub_DC, sub_NI, crows, ccolumns, ix_S, ix_V] = erp_sanity_sessions(erp, sub, visit, demog)

%% -- This local function removes subjects and sessions that do not contain both stimulation sides and/or all required visits

% -- logical index of records belonging to sessions with complete stimulation-side pairs
ix_S = false(length(erp), 1);

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

        % -- keep only sessions where both tms stimulation sides are available
        if ~isempty(DC) && ~isempty(NI)
            % -- mark corresponding records for inclusion
            ix_S = ix_S | ix_DC;
            ix_S = ix_S | ix_NI;

            % -- mark visit as available for both stimulation sides
            sub_DC(ks, kv) = true;
            sub_NI(ks, kv) = true;
        end

        % -- keep only sessions where both sham stimulation sides are available
        if ~isempty(DC_S) && ~isempty(NI_S)
            % -- mark corresponding records for inclusion
            ix_S = ix_S | ix_DC_S;
            ix_S = ix_S | ix_NI_S;
            % -- store sham availability in the last column
            sub_DC(ks, end) = true;
            sub_NI(ks, end) = true;
        end

        kv = kv + 1;

    end

    ks = ks + 1;

end

% -- create row labels for output tables
crows = [sub', ccondition];

% -- create column labels for output tables
ccolumns = [visit, {'SHAM'}];

% -- include all healthy-control records from v1 tms
[HC, ix_HC] = nin_subselect_dstruct(erp, 'visit', 'V1', 'stimulation', 'TMS');
% -- include all sham records from v6
[SHAM, ix_SHAM] = nin_subselect_dstruct(erp, 'visit', 'V6', 'stimulation', 'SHAM');
ix_V = false(length(erp), 1);

% -- retain healthy-control records
ix_V = ix_V | ix_HC;
% -- retain sham records
ix_V = ix_V | ix_SHAM;
ks = 1;
while ks <= length(sub)

    % -- stores visit completeness for the current subject
    ix_V_total =  false(length(erp), 1);
    kv = 2;
    while kv <= length(visit)

        % -- select all tms records for the current visit
        [cV, ix_cv] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stimulation', 'TMS');

        if ~isempty(cV)
            % -- accumulate records from available visits
            ix_V_total = ix_V_total | ix_cv;
            kv = kv + 1;
        else
            % -- reject subject if any required visit is missing
            ix_V_total =  false(length(erp), 1);
            kv = length(visit) + 1;
        end

    end

    % -- retain subjects with complete visit coverage
    ix_V = ix_V | ix_V_total;

    ks = ks + 1;

end

end