%%
genName='10_T1w_MPRAGE_RL_T1w_MPRAGE_RL_20180228130331_10';
myInfo=niftiinfo(['c1' genName]);

for i=1:3
    img=double(niftiread(['c' num2str(i) genName]));
    img=img.*myInfo.MultiplicativeScaling;
    eval(['c' num2str(i) '=img;']);
end

%%

myMask=c1+c2+c3;

myMask=double(myMask>0.5);

for i=1:size(myMask,3)
    mySlice=myMask(:,:,i);
    mySlice=imfill(mySlice,'holes');
    myMask(:,:,i)=mySlice;
    
end

%%
myImg=niftiread('m10_T1w_MPRAGE_RL_T1w_MPRAGE_RL_20180228130331_10');   
myInfo=niftiinfo('m10_T1w_MPRAGE_RL_T1w_MPRAGE_RL_20180228130331_10');
niftiwrite(myImg.*myMask,myInfo.Filename,myInfo);