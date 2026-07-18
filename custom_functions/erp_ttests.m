function [cstat, cstat_topo, cdata_diff] = erp_ttests(param, test, tepf, tepf_avg)

%% -- This function perform statistical comparisons between two predefined ERP/TEP datasets

% -- extract comparison parameters
cstim1 = param.cstim1; cstim2 = param.cstim2;
cvisit1 = param.cvisit1; cvisit2 = param.cvisit2;
cstimside1 = param.cstimside1; cstimside2 = param.cstimside2;
cphase1 = param.cphase1; cphase2 = param.cphase2;

% -- select datasets corresponding to the requested experimental conditions
cdataX = nin_subselect_dstruct(tepf, 'stimulation', cstim1, 'visit', cvisit1, 'stim_side', cstimside1, 'tphase', cphase1);
cdataY = nin_subselect_dstruct(tepf, 'stimulation', cstim2, 'visit', cvisit2, 'stim_side', cstimside2, 'tphase', cphase2);

% -- perform paired or independent-samples t-test
switch test
    case 'ttest'
        cstat = nin_ttest(cdataX, cdataY);
    case 'ttest2'
        cstat = nin_ttest2(cdataX, cdataY);
end
% -- create descriptive label for the statistical comparison
cstim_side = [strcat(cdataX(1).stimulation, '_', cdataX(1).Condition, '_', cdataX(1).visit, '_', cdataX(1).stim_side, '_', cphase1),...
    ' - ',...
    strcat(cdataY(1).stimulation, '_', cdataY(1).Condition, '_', cdataY(1).visit, '_', cdataY(1).stim_side, '_', cphase2)];
[cstat.condition] = deal(cstim_side);

% -- organize t-statistics and p-values into a topographical structure
cstat_topo = [];
% -- collect channel-wise statistical results
k1 = 1;
while k1 <= size(cstat, 2)
    cstat_topo.data(:, k1) = cstat(k1).t';
    cstat_topo.p(:, k1) = cstat(k1).p';
    k1 = k1 + 1;
end
% -- assign channel labels and comparison information
cstat_topo.data_rows = deal(cdataX(1).data_rows);
cstat_topo.data_columns = strcat({cstat.name}, '_t');
cstat_topo.condition = deal(cstim_side);

switch test
    case 'ttest'
        cdata = [cstat(1).x, cstat(1).y];
        cdata = nin_group_data(cdata, {'data'}, {'stimulation', 'visit', 'stim_side', 'tphase', 'Condition'});
        [cdata.data_rows] = deal([cstat(1).x(1).data_rows]);
        [cdata.data_columns] = deal([cstat(1).x(1).data_columns]);
        cdata = nin_function(cdata, @(x) nnz(squeeze(~isnan(x(1, 1, :)))), {'data'}, {'n'});
        cdata = nin_function(cdata, @(x) size(x, 3), {'data'}, {'N'});
        cdata = nin_function(cdata, @(x) nanmean(x, 3), {'data'}, {'data'});
        cstim_side = strcat({cdata.stimulation}, '_', {cdata.Condition}, '_', {cdata.visit}, '_', {cdata.stim_side}, '_', {cphase1, cphase2});
        [cdata.condition] = cstim_side{:};
    case 'ttest2'
        cdata = [nin_subselect_dstruct(tepf_avg, 'stimulation', cstim1, 'visit', cvisit1, 'stim_side', cstimside1, 'tphase', cphase1);...
            nin_subselect_dstruct(tepf_avg, 'stimulation', cstim2, 'visit', cvisit2, 'stim_side', cstimside2, 'tphase', cphase2)];
        cstim_side = strcat({cdata.stimulation}, '_', {cdata.Condition}, '_', {cdata.visit}, '_', {cdata.stim_side}, '_', {cphase1, cphase2});
        [cdata.condition] = cstim_side{:};
end

% -- store source data, sample sizes, and channel information for plotting
[cdata_diff.dataX] = cdata(1).data;
[cdata_diff.dataY] = cdata(2).data;
[cdata_diff.dataXn] = cdata(1).n;
[cdata_diff.dataYn] = cdata(2).n;
[cdata_diff.data] = cdata(1).data - cdata(2).data;
[cdata_diff.data_rows] = deal(cdata(1).data_rows);
[cdata_diff.data_columns] = deal(cdata(1).data_columns);
[cdata_diff.condition] = [cdata(1).condition ' - ' cdata(2).condition];

end