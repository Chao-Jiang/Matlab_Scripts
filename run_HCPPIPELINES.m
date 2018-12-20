function run_HCPPIPELINES(subject, myPath, dcm_folder, bash_profile)
% path = the path to the working directory of your project (e.g. /Volumes/homes/Shachar/piano_hcp).
% default is the directory for the piano project on Shachar's volume. 
% subject = the number of the subject you wish to process
% dcm_folder = the path to your raw data folder, where you. e.g. -
% /Volumes/homes/Shachar/piano_Raw. see DCM2HCP for further documentation
% bash_profile = the path to your bash profile
% e.g.'/Users/georgieboy/.bash_profile.' look for the needed variables in /Volumes/HCP/HCPpipelines-master/run_the_pipline/example_bash_profile

if ~exist('bash_profile', 'var')
    bash_profile = '/Users/georgieboy/.bash_profile';
end
if ~exist('path', 'var')
    myPath = '/Volumes/homes/Shachar/piano_hcp';
end
if ~exist('dcm_folder', 'var')
    dcm_folder = '/Volumes/homes/Shachar/piano_raw';
end

DCM2HCP(subject, myPath, dcm_folder, bash_profile);
disp('***finished converting to nifti***')
run_PreFreeSurfer_HCP(subject, myPath, bash_profile);
disp('***finished running PreFreeSurfer pipeline***')
run_FreeSurfer_HCP(subject, myPath, bash_profile);
disp('***finished running FreeSurfer pipeline***')
run_PostFreeSurfer_HCP(subject, myPath, bash_profile);
disp('***finished running PostFreeSurfer pipeline***')
run_fMRIVolume_HCP(subject, myPath, dcm_folder, bash_profile);
disp('***finished running fMRIVolume pipeline***')
run_fMRISurface_HCP(subject, myPath, dcm_folder, bash_profile);
disp('***finished running fMRISurface pipeline***')


% open some views
% mninonlin = [path '/' num2str(subject) '/MNINonLinear'];
% t1 = [mninonlin '/T1w_restore_brain.nii.gz '];
% spec_file = [mninonlin '/' num2str(subject) '.164k_fs_LR.wb.spec' ];
% mni_2mm_brain = '/usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz ';
% surf_temp_dir = '/Volumes/HCP/HCP_WB_Tutorial_1.0';
% L_inflated = [surf_temp_dir '/Q1-Q6_R440.L.inflated.164k_fs_LR.surf.gii '];
% L_midthick = [surf_temp_dir '/Q1-Q6_R440.L.midthickness.164k_fs_LR.surf.gii '];
% R_inflated = [surf_temp_dir '/Q1-Q6_R440.R.inflated.164k_fs_LR.surf.gii '];
% R_midthick = [surf_temp_dir '/Q1-Q6_R440.R.midthickness.164k_fs_LR.surf.gii '];
% 
% syscommand(['wb_view ' L_inflated L_midthick R_inflated R_midthick spec_file '&']);
% syscommand(['fsleyes ' mni_2mm_brain t1 '&']);

end
