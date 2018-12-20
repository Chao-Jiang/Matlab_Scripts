function run_ttest(Names)
% function run_ttest(Names)
% ----------------------------------------------------------------------- %
% April 2016 - Ido
% This function performs a paired t-test of a set of NIfTI images. 
% The input argument 'Names' should be a cell array with the Name_ID of the
% subjects (e.g. 4 letters: "ADFA"). 
% The function assumes that the pre images will have '1' after the subject
% ID and '2' after the subject ID for the post images.
% Reading and writing of NIfTI files is done using the NIfTI toolbox
% (should be in the matlab path).
% ----------------------------------------------------------------------- %

% ------------------------- starting variables: ------------------------- %
% changes this the fit your requirements:
imgPath     ='C:\my_data';
filePrefix  ='sww';           % assuming that postprocessing was done with SPM
fileSuffix  ='_MD_C_native_'; % assuming preprocessing was done with ExploreDTI
DTI_contrast= 'MD';           % can work with MD/FA/L1/L2/L3 etc.
% ----------------------------------------------------------------------- %

% load a representative image (the first) to get the image dimensions

fullName=[imgPath '\' filePrefix Names{1} '1' fileSuffix DTI_contrast '.nii'];
Nii=load_nii(fullName);
img=Nii.img;
dim=size(img);

% Set an empty varibale to containe all the data:
allPreData=zeros([dim length(Names)]);
allPostData=zeros([dim length(Names)]);

% ------------------------- Open all the images: ------------------------ %
% Run on all subjects:
for i=1:length(Names)
    % load the pre image:
    fullName=[imgPath '\' filePrefix Names{i} '1' fileSuffix DTI_contrast '.nii'];
    Nii=load_nii(fullName);
    allPreData(:,:,:,i)=Nii.img;
    % load the post image:
    fullName=[imgPath '\' filePrefix Names{i} '2' fileSuffix DTI_contrast '.nii'];
    Nii=load_nii(fullName);
    allPostData(:,:,:,i)=Nii.img;
end
% ----------------------------------------------------------------------- %

% ------------------------- Perform statistics: ------------------------- %
% Create an empty variable to save the p_values for all voxels:
pVals=zeros(dim);

for Z=1:dim(3) % run on all slices
    disp(['Start of slice #' num2str(Z)]);
    for Y=1:dim(2) % run on all columns
        for X=1:dim(1) % run on all rows
            % get data of a single voxel in one vector:
            preData=squeeze(allPreData(X,Y,Z,:)); 
            postData=squeeze(allPostData(X,Y,Z,:));
            % perform a paired t-test using Matlab built-in code:
            [h,p]=ttest(preData,postData);
            % save the calculate p value in a 3D variable
            pVals(X,Y,Z)=p;
        end
    end
    disp(['End of Slice #' num2str(Z)]);
end
% ----------------------------------------------------------------------- %
% save results as NIfTI (to be visualized outside matlab (e.g. in MRIcroN)
Nii.img=pVals;
save_nii(Nii,'Results.nii');

end
