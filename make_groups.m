function make_groups(C,filename)
% make_groups(C,outfile)

[n,p]=size(C);
fid=fopen(filename,'Wt');
fprintf(fid,'/NumWaves\t%d\n',p);
fprintf(fid,'/NumPoints\t%d\n',n);

fprintf(fid,'\n\n/Matrix\n');
for i=1:n
  for j=1:p
    fprintf(fid,'%f\t',C(i,j));
  end
  fprintf(fid,'\n');
end
fclose(fid);
