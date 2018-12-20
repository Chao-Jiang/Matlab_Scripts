function concat_phases_nifti(subjects)
% cocnat ap and pa resting state images 
for subject = subjects
    AP = niftiread(['/Volumes/home/piano_hcp/' num2str(subject) '/MNINonLinear/Results/rfMRI_REST_AP/rfMRI_REST_AP.nii.gz']);
    
    mock_dtseries_AP = reshape(AP, [], 500);
    mock_dtseries_AP = detrend(mock_dtseries_AP')';
    
    
    PA = niftiread(['/Volumes/home/piano_hcp/' num2str(subject) '/MNINonLinear/Results/rfMRI_REST_PA/rfMRI_REST_PA.nii.gz']);
    
    mock_dtseries_PA = reshape(PA, [], 500);
    mock_dtseries_PA = detrend(mock_dtseries_PA')';
    
    
    % rid of negative values, and make sure out of brain values remain zero
    min_AP = min(mock_dtseries_AP(:));
    min_PA = min(mock_dtseries_PA(:));
    min_both = min([min_AP, min_PA]);
    to_add = abs(min_both)*1.5; % adding a little more than just the minimu, value, so to not make more even zeros
    mock_dtseries_AP = mock_dtseries_AP+to_add;
    mock_dtseries_PA = mock_dtseries_PA+to_add;
    %out of brain values that were zeros, are now with the value of
    %'to_add'. so we need to correct it
    AP_notzero_mask = AP(:) ~= 0;
    mock_dtseries_AP = reshape(mock_dtseries_AP(:).*AP_notzero_mask, size(mock_dtseries_AP));
    PA_notzero_mask = PA(:) ~= 0;
    mock_dtseries_PA = reshape(mock_dtseries_PA(:).*PA_notzero_mask, size(mock_dtseries_PA));
    
    concat_phases = reshape([mock_dtseries_AP(:, 126:375), mock_dtseries_PA(:, 126:375)], 91, 109, 91, 500);
    fname = ['/Volumes/home/piano_hcp/' num2str(subject) '/MNINonLinear/Results/rfMRI_REST_APPA_concat_500.nii'];
    my_info = niftiinfo(['/Volumes/home/piano_hcp/' num2str(subject) '/MNINonLinear/Results/rfMRI_REST_AP/rfMRI_REST_AP.nii.gz']);
    my_info.Filename = fname;
%     my_info.ImageSize = size(concat_phases);
%     my_info.raw.dim(5) = size(concat_phases, 4);
    niftiwrite(concat_phases,fname,my_info); 
end
end