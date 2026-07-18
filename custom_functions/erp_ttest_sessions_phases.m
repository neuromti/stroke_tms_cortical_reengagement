function [tep_stat] = erp_ttest_sessions_phases(mytep)

%% -- This function perform predefined phase-specific t-test comparisons across visits, stimulation sides, and participant groups

tep_stat = [];

% -- TMS and TMS: HC vs ST, Dominant vs Contralesional, V1 vs V2, 0 vs 0
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '0'; cparam.cphase2 = '0';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Dominant vs Contralesional, V1 vs V2, 45 vs 45
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '45'; cparam.cphase2 = '45';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Dominant vs Contralesional, V1 vs V2, 90 vs 90
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '90'; cparam.cphase2 = '90';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Dominant vs Contralesional, V1 vs V2, 135 vs 135
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '135'; cparam.cphase2 = '135';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Dominant vs Contralesional, V1 vs V2, 180 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '180'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Dominant vs Contralesional, V1 vs V2, 225 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '225'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Dominant vs Contralesional, V1 vs V2, 270 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '270'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Dominant vs Contralesional, V1 vs V2, 315 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '315'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V2, 0 vs 0
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '0'; cparam.cphase2 = '0';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V2, 45 vs 45
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '45'; cparam.cphase2 = '45';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V2, 90 vs 90
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '90'; cparam.cphase2 = '90';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V2, 135 vs 135
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '135'; cparam.cphase2 = '135';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V2, 180 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '180'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V2, 225 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '225'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V2, 270 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '270'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V2, 315 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '315'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs HC, Dominant vs Dominant, V1 vs V1, 0 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V1';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Dominant';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'HC';
cparam.cphase1 = '0'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs HC, Dominant vs Dominant, V1 vs V1, 45 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V1';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Dominant';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'HC';
cparam.cphase1 = '45'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs HC, Dominant vs Dominant, V1 vs V1, 90 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V1';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Dominant';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'HC';
cparam.cphase1 = '90'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs HC, Dominant vs Dominant, V1 vs V1, 135 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V1';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Dominant';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'HC';
cparam.cphase1 = '135'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs HC, Nondominant vs Nondominant, V1 vs V1, 0 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V1';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Nondominant';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'HC';
cparam.cphase1 = '0'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs HC, Nondominant vs Nondominant, V1 vs V1, 45 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V1';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Nondominant';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'HC';
cparam.cphase1 = '45'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs HC, Nondominant vs Nondominant, V1 vs V1, 90 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V1';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Nondominant';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'HC';
cparam.cphase1 = '90'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: HC vs HC, Nondominant vs Nondominant, V1 vs V1, 135 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V1';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Nondominant';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'HC';
cparam.cphase1 = '135'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V2 vs V2, 0 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '0'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V2 vs V2, 45 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '45'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V2 vs V2, 90 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '90'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V2 vs V2, 135 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '135'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V2 vs V2, 0 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '0'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V2 vs V2, 45 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '45'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V2 vs V2, 90 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '90'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V2 vs V2, 135 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '135'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V3 vs V3, 0 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V3';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '0'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V3 vs V3, 45 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V3';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '45'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V3 vs V3, 90 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V3';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '90'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V3 vs V3, 135 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V3';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '135'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V3 vs V3, 0 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V3';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '0'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V3 vs V3, 45 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V3';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '45'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V3 vs V3, 90 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V3';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '90'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V3 vs V3, 135 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V3';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '135'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V4 vs V4, 0 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '0'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V4 vs V4, 45 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '45'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V4 vs V4, 90 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '90'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V4 vs V4, 135 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '135'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V4 vs V4, 0 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '0'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V4 vs V4, 45 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '45'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V4 vs V4, 90 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '90'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V4 vs V4, 135 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '135'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V5 vs V5, 0 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '0'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V5 vs V5, 45 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '45'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];
% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V5 vs V5, 90 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '90'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];
% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V5 vs V5, 135 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '135'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V5 vs V5, 0 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '0'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V5 vs V5, 45 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '45'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];
% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V5 vs V5, 90 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '90'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];
% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V5 vs V5, 135 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '135'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V6 vs V6, 0 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V6'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '0'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V6 vs V6, 45 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V6'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '45'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V6 vs V6, 90 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V6'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '90'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V6 vs V6, 135 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V6'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '135'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V6 vs V6, 0 vs 180
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V6'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '0'; cparam.cphase2 = '180';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V6 vs V6, 45 vs 225
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V6'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '45'; cparam.cphase2 = '225';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V6 vs V6, 90 vs 270
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V6'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '90'; cparam.cphase2 = '270';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V6 vs V6, 135 vs 315
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V6'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';
cparam.cphase1 = '135'; cparam.cphase2 = '315';

cdata1 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1, 'tphase', cparam.cphase1);
cdata2 = nin_subselect_dstruct(mytep, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2, 'tphase', cparam.cphase2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.tphase] = deal([cparam.cphase1, ' vs. ', cparam.cphase2]);
[cstat.p_columns] = deal(nin_strsplit(mytep(1).data_columns(1), 2, 2, 'spliter', '_'));
[cstat.p_rows] = deal({'p'});

tep_stat = [tep_stat, cstat];

end