%%
%img=niftiread('filterd_func_standard_merged.nii.gz');

myInfo=niftiinfo('filterd_func_standard_merged.nii.gz');
myInfo.Filename='';

vecImg=reshape(img,[],768);

wholeBrainMask = find(vecImg(:,1)~=0);

A=demean(vecImg(wholeBrainMask,1:384),2);
B=demean(vecImg(wholeBrainMask,385:end),2);

newImg=vecImg;
newImg(wholeBrainMask,1:384)=A+4000;
newImg(wholeBrainMask,385:end)=B+4000;

newImg4D=reshape(newImg,91,109,91,768);

niftiwrite(newImg4D,'filtered_func_standard_merged_demeaned',myInfo);

%%
figure;
plot_multi_ts(vecImg(mask_idx(idx),:));
figure;
plot_multi_ts(newImg(mask_idx(idx),:));