function sdata = fsl_lpfilter(data,freq,TR)
% sdata = fsl_lpfilter(data,freq,TR)
%
% data is NxT (with N<=100)
% TR in seconds
% freq in Hz
%
% S. Jbabdi 08/14
addpath([getenv('FSLDIR') '/etc/matlab']);

HWHM  = 1/freq;
sigma = round(HWHM/sqrt(2*log(2)) / TR)/6;
% sigma = 1/freq / TR;
% disp(sigma);

nx=20;%nx=2;
ny=20;%ny=1;
nz=1;
nt=size(data,2);

[~,tmpfile]=unix('tmpnam');
tmpfile=deblank(tmpfile);

box = zeros(nx*ny*nz,nt);
box(1:size(data,1),:)=data;
box = reshape(box,[nx ny nz nt]);
save_avw(box,tmpfile,'f',[1 1 1]);
unix(['fslmaths ' tmpfile ' -bptf -1 ' num2str(sigma) ' ' tmpfile '_lp']);
sdata = read_avw([tmpfile '_lp']);
sdata = reshape(sdata,nx*ny*nz,nt);
sdata = sdata(1:size(data,1),:);
