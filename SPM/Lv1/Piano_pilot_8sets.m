% List of open inputs
nrun = X; % enter the number of runs here
jobfile = {'/Users/nivtik/Research/Scripts/MATLAB/SPM/Lv1/Piano_pilot_8sets_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('run', jobs, inputs{:});
