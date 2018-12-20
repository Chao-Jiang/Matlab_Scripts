
% A simple general script to loop through subject folder and running
% commands is the terminal
%%

rootdir='/Volumes/home/Research/Schizo/PreProc/Nback/140_vols'; % folder containing subject dirs
subjlist=dir(rootdir);
for i=23:length(subjlist)
    sub=subjlist(i).name;
    subroot=[rootdir '/' subjlist(i).name];
    disp(['Processing subject ' subjlist(i).name])
    %command=['bash /Volumes/home/Research/Scripts/Bash/freesurfer.sh ' subjlist(i).name(5:7) ' ' subjlist(i).folder '/' subjlist(i).name '/' subjlist(i).name '_T1w.nii.gz'];
    command=['/Volumes/home/Software/MRI_software/fix1.066/fix ' subroot ' /Volumes/home/Research/Schizo/PreProc/Nback/FIX/Nback_training.RData 20']; 
    system(command)
    disp([subjlist(i).name ' completed'])
end