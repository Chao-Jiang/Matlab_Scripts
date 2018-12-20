function p=pcorrcoef(x,cc)
% p=pcorrcoef(x,['corr'])
% Like corrcoef but gives partial correlation
% if second argument is 'corr', assumes first argument is a correlation
% matrix

if(nargin==2)
    if(strcmp(cc,'corr'))
        c=x;
    else
        c=corrcoef(x);        
    end
else
    c=corrcoef(x);
end
ic=-inv(c);
p=ic./repmat(sqrt(abs(diag(ic))),1,size(c,1))./repmat(sqrt(abs(diag(ic)')),size(c,1),1);
p(~~eye(size(c,1)))=0;