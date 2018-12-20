%% Project 4D NIfTI onto the surface

% nii data should be already preprocessed and in MNI space

fname='data_standard'; % should include file path if not in the same folder

Lsurf='./HCP_PhaseII_Q1_Unrelated20.L.midthickness.32k_fs_LR.surf.gii';
Rsurf='./HCP_PhaseII_Q1_Unrelated20.R.midthickness.32k_fs_LR.surf.gii';

% Volume to surface projection
commandA=['wb_command -volume-to-surface-mapping ' fname '.nii.gz ' Lsurf ' tmpL.func.gii -trilinear'];
commandB=['wb_command -volume-to-surface-mapping ' fname '.nii.gz ' Rsurf ' tmpR.func.gii -trilinear'];

system(commandA);
system(commandB);

% Combine Left/Right into the same file
commandC=['wb_command -cifti-create-dense-timeseries TEMP.dtseries.nii ' ...
    '-left-metric tmpL.func.gii -right-metric tmpR.func.gii'];

system(commandC);

% Remove unwanted medial region

[tempCifti,BM]=open_wbfile('./ica_LR_MATCHED.dtseries.nii');
cifti=open_wbfile('TEMP.dtseries.nii');

numVols     = size(cifti.cdata,2);

data=zeros(length(tempCifti.cdata),numVols);

data(BM{1}.DataIndices,:)=cifti.cdata(BM{1}.SurfaceIndices,:);
data(BM{2}.DataIndices,:)=cifti.cdata(BM{2}.SurfaceIndices+str2double(BM{1}.SurfaceNumberOfVertices),:);

tempCifti.cdata=data;

ciftisave(tempCifti,[fname '.dtseries.nii']);

% Do cleanup

!rm tmpL.func.gii tmpR.func.gii TEMP.dtseries.nii
