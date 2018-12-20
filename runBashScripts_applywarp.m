
% A simple general script to loop through subject folder and running
% commands is the terminal
%%

rootdir='/Volumes/home/Research/Schizo/PreProc/Nback/140_vols'; % folder containing subject dirs
subjlist=dir(rootdir);
for i=4:length(subjlist)
    sub=subjlist(i).name;
    subroot=[rootdir '/' subjlist(i).name];
    disp(['Processing subject ' subjlist(i).name])
    %command=['bash /Volumes/home/Research/Scripts/Bash/freesurfer.sh ' subjlist(i).name(5:7) ' ' subjlist(i).folder '/' subjlist(i).name '/' subjlist(i).name '_T1w.nii.gz'];
    command=['applywarp -i ' subroot '/filtered_func_data_clean.nii.gz -o ' subroot '/filtered_func_data_clean_MNI.nii.gz -r ' subroot '/reg/standard.nii.gz -w ' subroot '/reg/example_func2standard_warp.nii.gz']; 
    system(command)
    disp([subjlist(i).name ' completed'])
end