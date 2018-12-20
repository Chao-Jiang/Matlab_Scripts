function concat_cope_cifti(subjects, cont_num)

study_feat = '/Volumes/home/piano_feat/';
input_str = '';
for subject = subjects
    input_str = [input_str study_feat num2str(subject) '.feat/GrayordinatesStats/cope' num2str(cont_num) '.dtseries.nii '];
end
output_str = ['/Volumes/home/piano_feat/group_analysis_files/copes/concatenated_cope' num2str(cont_num) '_sub' num2str(subjects(1)) '-' num2str(subjects(end)) '.dtseries.nii '];
syscommand(['wb_shortcuts -cifti-concatenate ' output_str input_str]);
end