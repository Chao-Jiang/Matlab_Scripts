function run_PreFreeSurfer_HCP(subject, myPath, bash_profile)
% path = the path to the working directory of your project. default is the
% directory for the piano project on Shachar's volume. 
% subject = the number of the subject you wish to process

if ~exist('path', 'var')
    myPath = '/Volumes/homes/Shachar/piano_hcp';
end

full_path_unproc = [myPath '/' num2str(subject) '/unprocessed/3T'];
t1_dir = fdir([full_path_unproc '/T1w_MPR1']);
t1 = [full_path_unproc '/T1w_MPR1/' t1_dir{contains(t1_dir, 'nii')}]; % would not work if there are more nii files in the folder. this is meant to not pick json file.
t2_dir = fdir([full_path_unproc '/T2w_SPC1']);
t2 = [full_path_unproc '/T2w_SPC1/' t2_dir{contains(t2_dir, 'nii')}]; % would not work if there are more nii files in the folder. this is meant to not pick json file.

brainsize = '150';

fmri_dir = fdir([full_path_unproc '/tfMRI_Piano_AP']);
SEPhaseNeg = fmri_dir{contains(fmri_dir, 'FieldMap_AP') & contains(fmri_dir, 'nii')};
SEPhasePos = fmri_dir{contains(fmri_dir, 'FieldMap_PA') & contains(fmri_dir, 'nii')};

t1templatebrain = '/Volumes/HCP/HCPpipelines-master/global/templates/MNI152_T1_1mm_brain.nii.gz';
t1template = '/Volumes/HCP/HCPpipelines-master/global/templates/MNI152_T1_1mm.nii.gz';

seechospacing = '0.000564992';
seunwarpdir = 'y';
unwarpdir = 'y';

t1samplespacing = 'NONE';
t2samplespacing = 'NONE';
gdcoeffs = 'NONE';

avgrdcmethod = '${SPIN_ECHO_METHOD_OPT}';
topupconfig = '$HCPPIPEDIR/global/config/b02b0.cnf';

syscommand(['$HCPPIPEDIR/PreFreeSurfer/PreFreeSurferPipeline.sh --path=' myPath ' --subject=' num2str(subject) ' --t1=' t1...
   ' --t2=' t2 ' --brainsize=' brainsize ' --SEPhaseNeg= ' SEPhaseNeg ' --SEPhasePos=' SEPhasePos...
   ' --seechospacing=' seechospacing ' --seunwarpdir=' seunwarpdir ' --t1samplespacing=' t1samplespacing...
   ' --t2samplespacing=' t2samplespacing ' --unwarpdir=' unwarpdir ' --gdcoeffs=' gdcoeffs...
   ' --avgrdcmethod=' avgrdcmethod ' --topupconfig=' topupconfig ' --t1templatebrain=' t1templatebrain ' --t1template=' t1template], bash_profile);




