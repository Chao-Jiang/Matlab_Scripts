function do_applyWarp(parent_dir)

% executes applywarp through the terminal for the complete dir
% input path should be the 'stats' folder under your feat folder
% if no input is given, the function will prompt a finder window for you to
% choose a dir

%shachar gal, 3/06/2018

if ~exist('parent_dir', 'var')
parentDir=uigetdir('/Users/nivtik/Research','Select directory'); %choose stats dir within the feat dir
end

myZstats=fdir([parentDir '/zstat*']); %extracts the warped targets
standardImg ='/usr/local/fsl/data/standard/MNI152lin_T1_2mm_brain.nii.gz';

for cont = 1:length(myZstats)

unwarped_path = [parentDir '/' myZstats{cont}]; % in volume
warped_path = [unwarped_path(1:(end-7)) '_warped.nii.gz']; % out volume
warp_mat = [parentDir(1:(end-5)) 'reg/example_func2standard_warp.nii.gz']; %warp matrix from reg dir
command=['applywarp -i ' unwarped_path ' -o ', warped_path ' -r ' standardImg ' -w ' warp_mat]; % applywarp command for usage in terminal
system(command);
end