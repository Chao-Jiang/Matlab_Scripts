function make_design(M,filename)
% make_design(M,outfile)

[n,p]=size(M);
fid=fopen(filename,'Wt');
fprintf(fid,'/NumWaves\t%d\n',p);
fprintf(fid,'/NumPoints\t%d\n',n);
fprintf(fid,'/PPheights\t');
for i=1:p
  fprintf(fid,'1\t');
end
fprintf(fid,'\n\n/Matrix\n');
for i=1:n
  for j=1:p
    fprintf(fid,'%f\t',M(i,j));
  end
  fprintf(fid,'\n');
end
fclose(fid);
