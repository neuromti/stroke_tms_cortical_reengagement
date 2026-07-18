function [fit_stat] = erp_ttest_sessions(myfit, sub_DC, sub_NI, sub)

%% -- This function perform predefined between-group and within-group t-test comparisons across visits and stimulation conditions

fit_stat = [];

% -- TMS and TMS: HC vs ST, Dominant vs Contralesional, V1 vs V2
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: HC vs ST, Dominant vs Ipsilesional, V1 vs V2
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: HC vs ST, Nondominant vs Contralesional, V1 vs V2
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: HC vs ST, Nondominant vs Ipsilesional, V1 vs V2
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and SHAM: HC vs ST, Dominant vs Contralesional, V1 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'SHAM';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and SHAM: HC vs ST, Dominant vs Ipsilesional, V1 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'SHAM';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and SHAM: HC vs ST, Nondominant vs Contralesional, V1 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'SHAM';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and SHAM: HC vs ST, Nondominant vs Ipsilesional, V1 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'SHAM';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Nondominant'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and SHAM: ST vs ST, Contralesional vs Contralesional, V6 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'SHAM';
cparam.cvisit1 = 'V6'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and SHAM: ST vs ST, Contralesional vs Ipsilesional, V6 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'SHAM';
cparam.cvisit1 = 'V6'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and SHAM: ST vs ST, Ipsilesional vs Ipsilesional, V6 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'SHAM';
cparam.cvisit1 = 'V6'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest2(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: HC vs HC, Dominant vs Nondominant, V1 vs V1
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V1'; cparam.cvisit2 = 'V1';
cparam.cstimside1 = 'Dominant'; cparam.cstimside2 = 'Nondominant';
cparam.ccondition1 = 'HC'; cparam.ccondition2 = 'HC';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Ipsilesional, V2 vs V2
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V2';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Ipsilesional, V3 vs V3
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V3';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Ipsilesional, V4 vs V4
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Ipsilesional, V5 vs V5
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Ipsilesional, V6 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V6'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(myfit, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

ix = sub_DC & sub_NI;
csub = sub(all(ix(:, 2:6), 2));
fit_te = myfit(ismember({myfit.sub}, csub));
fit_te = nin_subselect_dstruct(fit_te, 'stimulation', 'TMS');

clear ix csub

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V2 vs V3
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V3';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V2 vs V4
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V2 vs V5
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V2 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V3 vs V4
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V3 vs V5
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V3 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V4 vs V5
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V4 vs V5
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Contralesional vs Contralesional, V5 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Contralesional'; cparam.cstimside2 = 'Contralesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V2 vs V3
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V3';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V2 vs V4
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V2 vs V5
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V2 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V2'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V3 vs V4
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V4';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V3 vs V5
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V3 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V3'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V4 vs V5
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V5';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V4 vs V5
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V4'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

% -- TMS and TMS: ST vs ST, Ipsilesional vs Ipsilesional, V5 vs V6
cparam.cstim1 = 'TMS'; cparam.cstim2 = 'TMS';
cparam.cvisit1 = 'V5'; cparam.cvisit2 = 'V6';
cparam.cstimside1 = 'Ipsilesional'; cparam.cstimside2 = 'Ipsilesional';
cparam.ccondition1 = 'ST'; cparam.ccondition2 = 'ST';

cdata1 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit1, 'stimulation', cparam.cstim1, 'stim_side', cparam.cstimside1);
cdata2 = nin_subselect_dstruct(fit_te, 'visit', cparam.cvisit2, 'stimulation', cparam.cstim2, 'stim_side', cparam.cstimside2);
cstat = nin_ttest(cdata1, cdata2);
[cstat.stimulation] = deal([cparam.cstim1, ' vs. ', cparam.cstim2]);
[cstat.visit] = deal([cparam.cvisit1, ' vs. ', cparam.cvisit2]);
[cstat.stim_side] = deal([cparam.cstimside1, ' vs. ', cparam.cstimside2]);
[cstat.condition] = deal([cparam.ccondition1, ' vs. ', cparam.ccondition2]);
[cstat.p_columns] = deal({'amp', 'phase'});
[cstat.p_rows] = deal({'p'});

fit_stat = [fit_stat, cstat];

end