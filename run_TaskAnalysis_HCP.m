function run_TaskAnalysis_HCP(subjects)

path = '/Volumes/home/piano_hcp';
lvl1tasks = 'tfMRI_Piano_AP';
lvl1fsfs = 'tfMRI_Piano_AP';

lvl2task = 'NONE';
lvl2fsf = 'NONE';

lowresmesh = '32';
grayordinatesres = '2';
origsmoothingFWHM = '4';
finalsmoothingFWHM = '4';
confound = 'NONE';
temporalfilter = '100';
vba = 'NO';
regname = 'NONE';
parcellation = 'NONE';
parcellationfile = 'NONE';
for subject = subjects

make_fsf_hcp(subject);


syscommand(['/Volumes/HCP/HCPpipelines-master/TaskfMRIAnalysis/TaskfMRIAnalysis.sh --path=' path ' --subject=' num2str(subject)...
    ' --lvl1tasks=' lvl1tasks ' --lvl1fsfs=' lvl1fsfs ' --lvl2task=' lvl2task ' --lvl2fsf=' lvl2fsf ' --lowresmesh=' lowresmesh ...
    ' --grayordinatesres=' grayordinatesres ' --origsmoothingFWHM=' origsmoothingFWHM ' --confound=' confound... 
    ' --finalsmoothingFWHM=' finalsmoothingFWHM ' --temporalfilter=' temporalfilter ' --vba=' vba ' --regname=' regname...
    ' --parcellation=' parcellation ' --parcellationfile=' parcellationfile]);

syscommand(['feat /Volumes/home/piano_feat/' num2str(subject) '.feat/design.fsf']);

copyfile(['/Volumes/home/piano_feat/' num2str(subject) '+.feat'], ['/Volumes/home/piano_feat/' num2str(subject) '.feat/StandardVolumeFeat']);
rmdir(['/Volumes/home/piano_feat/' num2str(subject) '+.feat'], 's');

end
end