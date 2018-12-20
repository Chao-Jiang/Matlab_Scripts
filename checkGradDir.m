function checkGradDir(bvecFileName)
% function checkGradDir(bvecFileName)
% Check the distribution of the diffusion gradient scheme (based on help
% page of FSL's Eddy);
% Input argument can be a bvec file name of a matlab nX3 array

if ischar(bvecFileName)
    bvecs = load(bvecFileName);
elseif size(bvecFileName,1)==3
    bvecs=bvecFileName;
elseif size(bvecFileName,2)==3
    bvecs=bvecFileName';
else
    fprintf(2,'Illegal input!\n');
    return
end

figure('position',[100 100 500 500]);
plot3(bvecs(1,:),bvecs(2,:),bvecs(3,:),'*r');
axis([-1 1 -1 1 -1 1]);
axis vis3d;
rotate3d

end