function DCM2HCP(subject, myPath, dcm_folder, bash_profile)

% this script takes dicom format raw data, and uses dcm2niix to convert to nifti format, 
% and builds the basis for the hcp style dir structure, for futher analysis with the hcp_pipelines
% note that each entry in dcm_scans has a correlating entry in nifti_folders, that points to the directory it needs to be stored in.
% thus, nifti_folders is not a unique array. if you input another entry
% (such as a new task fmri name), make sure you extend both lists appropriately. 

if ~exist('bash_profile', 'var')
    bash_profile = '/Users/georgieboy/.bash_profile';
end
if ~exist('study_folder', 'var')
    myPath = '/Volumes/homes/Shachar/piano_hcp';
end
if ~exist('dcm_folder', 'var')
    dcm_folder = '/Volumes/homes/Shachar/piano_raw';
end

answer = input('before you continue, make sure you deleted the extre spinecho fieldmaps. type 1 to continue: ');
if answer == 1
    dcm_scans =     {'MPRAGE',   'fMRI_Task_Piano_AP_SBRef', 'fMRI_Task_Piano_AP','tfMRI_TASK_Nbcak_AP_SBRef', 'tfMRI_TASK_Nbcak_AP', 'SpinEchoFieldMap_AP', 'SpinEchoFieldMap_PA', 'SpinEchoFieldMap_AP', 'SpinEchoFieldMap_PA', 'T2w',      'fMRI_REST_AP_SBRef','fMRI_REST_AP',  'fMRI_REST_PA_SBRef', 'fMRI_REST_PA',  'diff_PA_SBRef', 'diff_PA',   'diff_AP_64dir_D28.2d9.1_SBRef', 'diff_AP_64dir_D28.2d9.1'};
    nifti_folders = {'T1w_MPR1', 'tfMRI_Piano_AP',            'tfMRI_Piano_AP',   'tfMRI_TASK_Nbcak_AP',       'tfMRI_TASK_Nbcak_AP', 'tfMRI_Piano_AP',      'tfMRI_Piano_AP',      'tfMRI_TASK_Nbcak_AP', 'tfMRI_TASK_Nbcak_AP', 'T2w_SPC1', 'rfMRI_REST_AP',     'rfMRI_REST_AP', 'rfMRI_REST_PA',      'rfMRI_REST_PA', 'Diffusion',     'Diffusion', 'Diffusion',                     'Diffusion'};

    sub_folder = [myPath '/' num2str(subject) '/unprocessed/3T'];
    mkdir(sub_folder);
    sub_raw_data = fdir([dcm_folder '/subject' num2str(subject)]);

    for scan = 1:length(dcm_scans)
        scan_loc = find(contains(lower(sub_raw_data), lower(dcm_scans{scan})));
        if scan_loc
            if ismember('Ref', dcm_scans{scan})
                scan_loc = scan_loc(1);
            else
                scan_loc = scan_loc(end);
            end
            sub_dir = fdir(sub_folder);
            if ~any(ismember(sub_dir,nifti_folders{scan})) %dont try mkdir if dir is already made..
                mkdir([sub_folder '/' nifti_folders{scan}]);
            end
            syscommand(['$dcm2niix -o ' sub_folder '/' nifti_folders{scan} ' ' dcm_folder '/subject' num2str(subject) '/' sub_raw_data{scan_loc}], bash_profile);
       else
            disp(['no ' dcm_scans{scan} 'found in subjects raw data folder'])
        end
    end

    % copy fieldmaps to rfMRI folders aswell
    taskdir = fdir([myPath '/' num2str(subject) '/unprocessed/3T/tfMRI_Piano_AP']); 
    spinfiles = taskdir(contains(taskdir, 'SpinEcho'));
    for i = 1:length(spinfiles)
        copyfile([myPath '/' num2str(subject) '/unprocessed/3T/tfMRI_Piano_AP/' spinfiles{i}], [myPath '/' num2str(subject) '/unprocessed/3T/rfMRI_REST_AP'])
        copyfile([myPath '/' num2str(subject) '/unprocessed/3T/tfMRI_Piano_AP/' spinfiles{i}], [myPath '/' num2str(subject) '/unprocessed/3T/rfMRI_REST_PA'])
    end
else
    disp('see ya later')
end
end

    