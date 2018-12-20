function [cope,varcope,stats] = fsl_glm(x,y,c)
% [cope,varcope,stats] = fsl_glm(x,y,[c=Identity])
% stats.{t,p,z,dof}
%
% S. Jbabdi 03/14

if(nargin<3)
    if(size(x,2)<100)
        c = eye(size(x,2));
    else
        c = 1;
    end
end

% pseudo-inverse
[u,s,v] = svd(x,0);
s = diag(s);
tol = max(size(x)) * eps(norm(s,inf));
r1 = sum(s > tol)+1;
v(:,r1:end) = [];
u(:,r1:end) = [];
s(r1:end) = [];
s = 1./s(:);
invx = bsxfun(@times,v,s.')*u';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


beta = invx*y;
cope = c*beta;
r    = y-x*beta;
dof  = size(r,1)-rank(x);

sigma_sq = sum(r.^2)/dof;

invxx   = bsxfun(@times,v,s.^2')*v';
varcope = diag((c*invxx*c')) * sigma_sq;
t       = cope./sqrt(varcope);
% p       = tcdf(t,dof); % 1-sided p-value for t-stat
t(isnan(t))=0;
stats.t   = t;
% stats.p   = p;
stats.dof = dof;
stats.z   = (2^0.5)*erfinv(1-2*betainc(dof./(dof+t.^2),dof/2,1/2)/2);
stats.z   = stats.z .* sign(t);
stats.ss  = sigma_sq;
