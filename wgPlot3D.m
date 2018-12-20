function wgPlot3D(adjMat,coord)
% function wgPlot3D(adjMat,coord)

% I.Tavor - June 2017
% Draw a 3D connectivity plot with weighted edges
%
% INPUT:
%   [adjMat] = N x N square adjacency matrix
%    [coord] = N x 3 vertex coordinates of the graph being plotted

% ================================================================ %
% get info:
numNodes       = length(adjMat);
pairs          = nchoosek(1:numNodes,2)';
myColormap_pos = hot(64); % use hot colors to present positive connections
myColormap_neg = flipud(cool(64));% use cool colors to present negative connections

myColormap     = cool2hot(128,[-1,1]);
myColormap_pos = myColormap(65:end,:);
myColormap_neg = myColormap(64:-1:1,:);

% plot all nodes:
figure;
scatter3(coord(:,1),coord(:,2),coord(:,3),150,[1 0 0],'fill');axis image; axis off
set(gcf,'color','w','position',[1700 300 700 1000]);
view(0,90);

tmp=triu(adjMat);
tmp(~~eye(length(tmp)))=0;
tmp_pos=reshape(tmp(tmp>0),[],1);
tmp_neg=reshape(tmp(tmp<0),[],1);

lim = .75.*max([tmp_pos; abs(tmp_neg)]);
lim = 3.28;
tmp=tmp./lim;

for i=1:length(pairs);
    val=tmp(pairs(1,i),pairs(2,i));
    if val>1
        myColor=myColormap_pos(end,:);
    elseif val>0
        myColor=myColormap_pos(ceil(val.*length(myColormap_pos)),:);
    elseif val<-1
        myColor=myColormap_neg(end,:);
    elseif val<0
        myColor=myColormap_neg(ceil(abs(val).*length(myColormap_neg)),:);
    elseif val==0
        continue
    end
  
    line(coord(pairs(:,i),1),coord(pairs(:,i),2),coord(pairs(:,i),3),'color',myColor,'LineWidth',2);
end

%% create colorbar:
%myColormap=[flipud(myColormap_neg);myColormap_pos];
minX=(min(coord(:,1))).*1.1;
maxX=(max(coord(:,1))).*1.1;

minY=(min(coord(:,2))).*1.2;

step=(maxX-minX)./128;
a=minX;
for i=1:128
    line([a a+step],[minY minY],'color', myColormap(i,:),'LineWidth',20);
    a=a+step;
end

text(minX,minY,num2str(-1.*lim,3),'HorizontalAlignment','left','color',[0.2,0.2,0.2],'FontSize',12)
text(maxX,minY,num2str(lim,3),'HorizontalAlignment','right','color',[0.2,0.2,0.2],'FontSize',12)
text((minX+maxX)./2,minY,'0.00','HorizontalAlignment','center','color',[0.9,0.9,0.9],'FontSize',12)


