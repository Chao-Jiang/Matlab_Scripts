function [ cifti ] = ciftiopen(filename,caret7command)
%Open a CIFTI file by converting to GIFTI external binary first and then
%using the GIFTI toolbox
if(nargin<2)
    caret7command='/Applications/workbench/bin_macosx64/wb_command';
end
tic
unix([caret7command ' -cifti-convert -to-gifti-ext ' filename ' ' filename '.gii']);
toc

tic
cifti = gifti([filename '.gii']);
toc

unix([' rm ' filename '.gii ' filename '.gii.data']);

end

