function make_conn_mat(subjects)

parcellation = open_wbfile('/Volumes/HCP/Parcellation/Q1-Q6_RelatedValidation210.CorticalAreas_dil_Final_Final_Areas_Group_Colors.32k_fs_LR.dlabel.nii');
parcellation = parcellation.cdata;

for subject = subjects
    dtseries_AP = open_wbfile(['/Volumes/home/piano_hcp/' num2str(subject) '/MNINonLinear/Results/rfMRI_REST_AP/rfMRI_REST_AP_Atlas.dtseries.nii']);
    dtseries_AP = dtseries_AP.cdata;
    dtseries_AP = detrend(dtseries_AP')';
    
    dtseries_PA = open_wbfile(['/Volumes/home/piano_hcp/' num2str(subject) '/MNINonLinear/Results/rfMRI_REST_PA/rfMRI_REST_PA_Atlas.dtseries.nii']);
    dtseries_PA = dtseries_PA.cdata;
    dtseries_PA = detrend(dtseries_PA')';
    
    dtseries_APPA_500 = [dtseries_AP(:, 126:375) dtseries_PA(:, 126:375)];
    dtseries_APPA_1000 = [dtseries_AP dtseries_PA];
    
    for area = 1:360
        area_dtseries_AP = mean(dtseries_AP(parcellation==area,:),1);
        parcellated_dtseries_AP(area, :) = area_dtseries_AP;
        
        area_dtseries_PA = mean(dtseries_PA(parcellation==area,:),1);
        parcellated_dtseries_PA(area, :) = area_dtseries_PA;
        
        area_dtseries_APPA_500 = mean(dtseries_APPA_500(parcellation==area,:),1);
        parcellated_dtseries_APPA_500(area, :) = area_dtseries_APPA_500;
        
        area_dtseries_APPA_1000 = mean(dtseries_APPA_1000(parcellation==area,:),1);
        parcellated_dtseries_APPA_1000(area, :) = area_dtseries_APPA_1000;
    end
    CM_AP = corr(parcellated_dtseries_AP');
    CM_PA = corr(parcellated_dtseries_PA');
    CM_APPA_500 = corr(parcellated_dtseries_APPA_500');
    CM_APPA_1000 = corr(parcellated_dtseries_APPA_1000');
    
    figarray(1) = figure('Name', 'AP');
    imagesc(CM_AP, [-0.8, 0.8])
    axis square
    
    figarray(2) = figure('Name', 'PA');
    imagesc(CM_PA, [-0.8, 0.8])
    axis square
    
    figarray(3) = figure('Name', 'AP_PA_500');
    imagesc(CM_APPA_500, [-0.8, 0.8])
    axis square
    
    figarray(4) = figure('Name', 'AP_PA_1000');
    imagesc(CM_APPA_1000, [-0.8, 0.8])
    axis square
    
    sub_dir = ['/Volumes/home/piano_hcp/' num2str(subject)];
    save([sub_dir '/conn_matrices.mat'], 'CM_AP','CM_PA', 'CM_APPA_500', 'CM_APPA_1000');  
    savefig(figarray, [sub_dir '/conn_figs.fig']);
end
end
