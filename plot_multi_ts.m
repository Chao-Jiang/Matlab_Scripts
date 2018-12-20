function plot_multi_ts(data,col)
% plot_multi_ts(data(nxt,[col])
%
if(nargin<2)
    col='k';
end
[N,T]=size(data);

% figure
hold on
data = demean(data,2);
s    = std(data,0,2);

x    = 0:N-1;
x    = x*5*mean(s);

plot(1:T,data' + repmat(x,T,1),col);

set(gca,'ytick',x,'yticklabel',num2str((1:N)'))

grid on



