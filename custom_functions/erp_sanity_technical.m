function [sanity_file_DC, sanity_file_NI, ix_keep] = erp_sanity_technical(erp, sub, visit, demog, cphase)

%% -- This local function removes ERP recordings affected by technical issues

% -- initialize keep flag for all ERP records
[erp.keep] = deal(true);
sanity_header = {'sub', 'condition', 'phase', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6', 'SHAM', 'comment'};

% -- preallocate sanity check summary tables for dominant and nondominant stimulation
sanity_file_DC = cell(length(sub), length(sanity_header));
sanity_file_NI = cell(length(sub), length(sanity_header));

% -- loop through all subjects
ks = 1;
while ks <= length(sub)

    % -- extract subject-specific ERP and demographic data
    csub = nin_subselect_dstruct(erp, 'sub', sub{ks});
    cdemog = nin_subselect_dstruct(demog, 'sub', sub{ks});

    sanity_file_DC(ks, :) = {'0/0'};
    sanity_file_DC(ks, strcmpi(sanity_header, 'sub')) = sub(ks);
    sanity_file_DC(ks, strcmpi(sanity_header, 'phase')) = {cphase};
    sanity_file_DC{ks, strcmpi(sanity_header, 'comment')} = '';
    sanity_file_DC{ks, strcmpi(sanity_header, 'condition')} = cdemog.condition;

    sanity_file_NI(ks, :) = {'0/0'};
    sanity_file_NI(ks, strcmpi(sanity_header, 'sub')) = sub(ks);
    sanity_file_NI(ks, strcmpi(sanity_header, 'phase')) = {cphase};
    sanity_file_NI{ks, strcmpi(sanity_header, 'comment')} = '';
    sanity_file_NI{ks, strcmpi(sanity_header, 'condition')} = cdemog.condition;

    % -- flag subjects with missing ERP data
    if isempty(csub)

        sanity_file_DC{ks, strcmpi(sanity_header, 'comment')} = 'demog is missing';
        sanity_file_NI{ks, strcmpi(sanity_header, 'comment')} = 'demog is missing';

    else

        % -- loop through visits and determine which recordings should be retained
        kv = 1;
        while kv <= length(visit)

            switch visit{kv}
                case 'V1'

                    [cvisit1, ix1] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Dominant', 'tphase', cphase);
                    [cvisit2, ix2] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Nondominant', 'tphase', cphase);

                    if ~isempty(cvisit1)
                        n1 = cvisit1.N;
                        nc1 = cvisit1.n;
                    else
                        n1 = 0;
                        nc1 = 0;
                        [erp(ix1).keep] = deal(false);
                    end
                    if ~isempty(cvisit2)
                        n2 = cvisit2.N;
                        nc2 = cvisit2.n;
                    else
                        n2 = 0;
                        nc2 = 0;
                        [erp(ix2).keep] = deal(false);
                    end

                    sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc1), '/', num2str(n1)];
                    sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc2), '/', num2str(n2)];

                case 'V2'

                    [cvisit1, ix1] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'session', 'pre1', 'tphase', cphase);
                    [cvisit2, ix2] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'session', 'pre1', 'tphase', cphase);
                    [cvisit3, ix3] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'session', 'pre2', 'tphase', cphase);
                    [cvisit4, ix4] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'session', 'pre2', 'tphase', cphase);

                    if ~isempty(cvisit1)
                        n1 = cvisit1.N;
                        nc1 = cvisit1.n;
                    else
                        n1 = 0;
                        nc1 = 0;
                        [erp(ix1).keep] = deal(false);
                    end
                    if ~isempty(cvisit2)
                        n2 = cvisit2.N;
                        nc2 = cvisit2.n;
                    else
                        n2 = 0;
                        nc2 = 0;
                        [erp(ix2).keep] = deal(false);
                    end
                    if ~isempty(cvisit3)
                        n3 = cvisit3.N;
                        nc3 = cvisit3.n;
                    else
                        n3 = 0;
                        nc3 = 0;
                        [erp(ix3).keep] = deal(false);
                    end
                    if ~isempty(cvisit4)
                        n4 = cvisit4.N;
                        nc4 = cvisit4.n;
                    else
                        n4 = 0;
                        nc4 = 0;
                        [erp(ix4).keep] = deal(false);
                    end

                    N1 = n1 + n2;
                    N2 = n3 + n4;

                    if N1 > N2

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc1), '/', num2str(n1)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc2), '/', num2str(n2)];

                        [erp(ix3).keep] = deal(false);
                        [erp(ix4).keep] = deal(false);

                    elseif N1 < N2

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc3), '/', num2str(n3)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} =  [num2str(nc4), '/', num2str(n4)];

                        [erp(ix1).keep] = deal(false);
                        [erp(ix2).keep] = deal(false);

                    else

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc1), '/', num2str(n1)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} =  [num2str(nc2), '/', num2str(n2)];

                        if n1 ~= 0
                            [erp(ix3).keep] = deal(false);
                            [erp(ix4).keep] = deal(false);
                        end

                    end

                case 'V3'

                    [cvisit1, ix1] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'session', 'post1', 'tphase', cphase);
                    [cvisit2, ix2] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'session', 'post1', 'tphase', cphase);
                    [cvisit3, ix3] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'session', 'post2', 'tphase', cphase);
                    [cvisit4, ix4] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'session', 'post2', 'tphase', cphase);

                    if ~isempty(cvisit1)
                        n1 = cvisit1.N;
                        nc1 = cvisit1.n;
                    else
                        n1 = 0;
                        nc1 = 0;
                        [erp(ix1).keep] = deal(false);
                    end
                    if ~isempty(cvisit2)
                        n2 = cvisit2.N;
                        nc2 = cvisit2.n;
                    else
                        n2 = 0;
                        nc2 = 0;
                        [erp(ix2).keep] = deal(false);
                    end
                    if ~isempty(cvisit3)
                        n3 = cvisit3.N;
                        nc3 = cvisit3.n;
                    else
                        n3 = 0;
                        nc3 = 0;
                        [erp(ix3).keep] = deal(false);
                    end
                    if ~isempty(cvisit4)
                        n4 = cvisit4.N;
                        nc4 = cvisit4.n;
                    else
                        n4 = 0;
                        nc4 = 0;
                        [erp(ix4).keep] = deal(false);
                    end

                    N1 = n1 + n2;
                    N2 = n3 + n4;

                    if N1 > N2

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc1), '/', num2str(n1)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc2), '/', num2str(n2)];

                        [erp(ix3).keep] = deal(false);
                        [erp(ix4).keep] = deal(false);

                    elseif N1 < N2

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc3), '/', num2str(n3)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} =  [num2str(nc4), '/', num2str(n4)];

                        [erp(ix1).keep] = deal(false);
                        [erp(ix2).keep] = deal(false);

                    else

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc1), '/', num2str(n1)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} =  [num2str(nc2), '/', num2str(n2)];

                        if n1 ~= 0
                            [erp(ix3).keep] = deal(false);
                            [erp(ix4).keep] = deal(false);
                        end

                    end

                case 'V4'

                    [cvisit1, ix1] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'session', 'pre3', 'tphase', cphase);
                    [cvisit2, ix2] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'session', 'pre3', 'tphase', cphase);
                    [cvisit3, ix3] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'session', 'pre4', 'tphase', cphase);
                    [cvisit4, ix4] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'session', 'pre4', 'tphase', cphase);

                    if ~isempty(cvisit1)
                        n1 = cvisit1.N;
                        nc1 = cvisit1.n;
                    else
                        n1 = 0;
                        nc1 = 0;
                        [erp(ix1).keep] = deal(false);
                    end
                    if ~isempty(cvisit2)
                        n2 = cvisit2.N;
                        nc2 = cvisit2.n;
                    else
                        n2 = 0;
                        nc2 = 0;
                        [erp(ix2).keep] = deal(false);
                    end
                    if ~isempty(cvisit3)
                        n3 = cvisit3.N;
                        nc3 = cvisit3.n;
                    else
                        n3 = 0;
                        nc3 = 0;
                        [erp(ix3).keep] = deal(false);
                    end
                    if ~isempty(cvisit4)
                        n4 = cvisit4.N;
                        nc4 = cvisit4.n;
                    else
                        n4 = 0;
                        nc4 = 0;
                        [erp(ix4).keep] = deal(false);
                    end

                    N1 = n1 + n2;
                    N2 = n3 + n4;

                    if N1 > N2

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc1), '/', num2str(n1)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc2), '/', num2str(n2)];

                        [erp(ix3).keep] = deal(false);
                        [erp(ix4).keep] = deal(false);

                    elseif N1 < N2

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc3), '/', num2str(n3)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} =  [num2str(nc4), '/', num2str(n4)];

                        [erp(ix1).keep] = deal(false);
                        [erp(ix2).keep] = deal(false);

                    else

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc1), '/', num2str(n1)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} =  [num2str(nc2), '/', num2str(n2)];

                        if n1 ~= 0
                            [erp(ix3).keep] = deal(false);
                            [erp(ix4).keep] = deal(false);
                        end

                    end

                case 'V5'

                    [cvisit1, ix1] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'session', 'post3', 'tphase', cphase);
                    [cvisit2, ix2] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'session', 'post3', 'tphase', cphase);
                    [cvisit3, ix3] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'session', 'post4', 'tphase', cphase);
                    [cvisit4, ix4] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'session', 'post4', 'tphase', cphase);

                    if ~isempty(cvisit1)
                        n1 = cvisit1.N;
                        nc1 = cvisit1.n;
                    else
                        n1 = 0;
                        nc1 = 0;
                        [erp(ix1).keep] = deal(false);
                    end
                    if ~isempty(cvisit2)
                        n2 = cvisit2.N;
                        nc2 = cvisit2.n;
                    else
                        n2 = 0;
                        nc2 = 0;
                        [erp(ix2).keep] = deal(false);
                    end
                    if ~isempty(cvisit3)
                        n3 = cvisit3.N;
                        nc3 = cvisit3.n;
                    else
                        n3 = 0;
                        nc3 = 0;
                        [erp(ix3).keep] = deal(false);
                    end
                    if ~isempty(cvisit4)
                        n4 = cvisit4.N;
                        nc4 = cvisit4.n;
                    else
                        n4 = 0;
                        nc4 = 0;
                        [erp(ix4).keep] = deal(false);
                    end

                    N1 = n1 + n2;
                    N2 = n3 + n4;

                    if N1 > N2

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc1), '/', num2str(n1)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc2), '/', num2str(n2)];

                        [erp(ix3).keep] = deal(false);
                        [erp(ix4).keep] = deal(false);

                    elseif N1 < N2

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc3), '/', num2str(n3)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} =  [num2str(nc4), '/', num2str(n4)];

                        [erp(ix1).keep] = deal(false);
                        [erp(ix2).keep] = deal(false);

                    else

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc1), '/', num2str(n1)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} =  [num2str(nc2), '/', num2str(n2)];

                        if n1 ~= 0
                            [erp(ix3).keep] = deal(false);
                            [erp(ix4).keep] = deal(false);
                        end

                    end

                case 'V6'

                    [cvisit1, ix1] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'session', 'post5', 'tphase', cphase);
                    [cvisit2, ix2] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'session', 'post5', 'tphase', cphase);
                    [cvisit3, ix3] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'session', 'post6', 'stimulation', 'TMS', 'tphase', cphase);
                    [cvisit4, ix4] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'session', 'post6', 'stimulation', 'TMS', 'tphase', cphase);
                    [cvisit5, ix5] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Contralesional', 'session', 'post6', 'stimulation', 'SHAM', 'tphase', cphase);
                    [cvisit6, ix6] = nin_subselect_dstruct(erp, 'sub', sub{ks}, 'visit', visit{kv}, 'stim_side', 'Ipsilesional', 'session', 'post6', 'stimulation', 'SHAM', 'tphase', cphase);

                    if ~isempty(cvisit1)
                        n1 = cvisit1.N;
                        nc1 = cvisit1.n;
                    else
                        n1 = 0;
                        nc1 = 0;
                        [erp(ix1).keep] = deal(false);
                    end
                    if ~isempty(cvisit2)
                        n2 = cvisit2.N;
                        nc2 = cvisit2.n;
                    else
                        n2 = 0;
                        nc2 = 0;
                        [erp(ix2).keep] = deal(false);
                    end
                    if ~isempty(cvisit3)
                        n3 = cvisit3.N;
                        nc3 = cvisit3.n;
                    else
                        n3 = 0;
                        nc3 = 0;
                        [erp(ix3).keep] = deal(false);
                    end
                    if ~isempty(cvisit4)
                        n4 = cvisit4.N;
                        nc4 = cvisit4.n;
                    else
                        n4 = 0;
                        nc4 = 0;
                        [erp(ix4).keep] = deal(false);
                    end

                    N1 = n1 + n2;
                    N2 = n3 + n4;

                    if N1 > N2

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc1), '/', num2str(n1)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc2), '/', num2str(n2)];

                        [erp(ix3).keep] = deal(false);
                        [erp(ix4).keep] = deal(false);

                    elseif N1 < N2

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc3), '/', num2str(n3)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} =  [num2str(nc4), '/', num2str(n4)];

                        [erp(ix1).keep] = deal(false);
                        [erp(ix2).keep] = deal(false);

                    else

                        sanity_file_DC{ks, strcmpi(sanity_header, visit{kv})} = [num2str(nc1), '/', num2str(n1)];
                        sanity_file_NI{ks, strcmpi(sanity_header, visit{kv})} =  [num2str(nc2), '/', num2str(n2)];

                        if n1 ~= 0
                            [erp(ix3).keep] = deal(false);
                            [erp(ix4).keep] = deal(false);
                        end

                    end

                    if ~isempty(cvisit5)
                        n5 = cvisit5.N;
                        nc5 = cvisit5.n;
                    else
                        n5 = 0;
                        nc5 = 0;
                        [erp(ix5).keep] = deal(false);
                    end
                    if ~isempty(cvisit6)
                        n6 = cvisit6.N;
                        nc6 = cvisit6.n;
                    else
                        n6 = 0;
                        nc6 = 0;
                        [erp(ix6).keep] = deal(false);
                    end
                    sanity_file_DC{ks, strcmpi(sanity_header, 'SHAM')} = [num2str(nc5), '/', num2str(n5)];
                    sanity_file_NI{ks, strcmpi(sanity_header, 'SHAM')} = [num2str(nc6), '/', num2str(n6)];

            end

            kv = kv + 1;

        end

    end

    ks = ks + 1;

end

% -- append header row to sanity check output tables
sanity_file_DC = [sanity_header; sanity_file_DC];
sanity_file_NI = [sanity_header; sanity_file_NI];

ix_keep = [erp.keep]';

end

