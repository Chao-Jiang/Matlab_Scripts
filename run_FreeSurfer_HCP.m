function run_FreeSurfer_HCP(subject, myPath, bash_profile)

subjectDIR = [myPath '/' num2str(subject)];
t1 = [subjectDIR '/T1w/T1w_acpc_dc_restore.nii.gz'];
t1brain = [subjectDIR '/T1w/T1w_acpc_dc_restore_brain.nii.gz'];
t2 = [subjectDIR '/T1w/T2w_acpc_dc_restore.nii.gz'];

syscommand(['$HCPPIPEDIR/FreeSurfer/FreeSurferPipeline.sh --subject=' num2str(subject) ' --subjectDIR=' subjectDIR ' --t1=' t1...
    ' --t1brain=' t1brain ' --t2=' t2], bash_profile);
end