function Yr = regress_out(Y,X,keepmean)
% Yr = regress_out(Y,X,[keapmean=true])
% produces Yr after regressing X out of Y
%
% Y is NxP and X is NxQ

if(nargin<3)
    keepmean=true;
end
m=0;
if(keepmean)
    m=repmat(mean(Y),size(Y,1),1);
end

M=[ones(size(X,1),1) X];

Yr = Y - (M*(pinv(M)*(Y))) + m;

% figure
% subplot(1,2,1),hold on
% plot(X,Y,'k.')
% plot(X,M*(pinv(M)*Y),'r');
% subplot(1,2,2),hold on
% plot(X,Yr,'.');
