function run_melodic(subjects)
melodir = '/Volumes/home/piano_melodic/';
for subject = subjects
    res_path = ['/Volumes/home/piano_hcp/' num2str(subject) '/MNINonLinear/Results'];
    res_dir = fdir(res_path);
    AP = 'rfMRI_REST_AP';
    if any(contains(res_dir, AP))
        make_fsf_melodic(subject, 'AP');
        disp(['start running melodic on AP for subject number ' num2str(subject)]);
        syscommand(['feat ' melodir num2str(subject) '/design_AP.fsf'])
        disp(['finished running melodic on AP for subject number ' num2str(subject)]);
    end
    PA = 'rfMRI_REST_PA';
    if any(contains(res_dir, PA))
        make_fsf_melodic(subject, 'PA');
        disp(['start running melodic on PA for subject number ' num2str(subject)]);
        syscommand(['feat ' melodir num2str(subject) '/design_PA.fsf'])
        disp(['finished running melodic on PA for subject number ' num2str(subject)]);
    end
end