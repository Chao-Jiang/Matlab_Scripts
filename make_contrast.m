function make_contrast(C,filename)
% make_contrast(C,outfile)

[n,p]=size(C);
fid=fopen(filename,'Wt');
for i=1:n
  fprintf(fid,'/ContrastName%d\t"contrast%d"\n',i,i);
end
fprintf(fid,'/NumWaves\t%d\n',p);
fprintf(fid,'/NumContrasts\t%d\n',n);
fprintf(fid,'/PPheights\t');
for i=1:p
  fprintf(fid,'1\t');
end
fprintf(fid,'\n\n/Matrix\n');
for i=1:n
  for j=1:p
    fprintf(fid,'%f\t',C(i,j));
  end
  fprintf(fid,'\n');
end
fclose(fid);
