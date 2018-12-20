% List of open inputs
nrun = X; % enter the number of runs here
jobfile = {'/Users/nivtik/Research/Scripts/SPM/Preproc/Urine_Preproc_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
