function updateClusterPlot( ax,MIN,MAX,p_mc,o_mc )

Legends = {};

% plot all p-micro-clusters
for i=1:length(p_mc)
    Style = '.';
    MarkerSize = 10;
    Color = p_mc(i).color;
    Legends{end+1} = ['Cluster #' num2str(i)];
    
    X = p_mc(i).points(:,2);
    Y = p_mc(i).points(:,3);

    plot(ax,X,Y,Style,'MarkerSize',MarkerSize,'Color',Color);
%     xlim([MIN(1)-5 MAX(1)+5]); ylim([MIN(2)-5 MAX(2)+5]);
    xlim([MIN(1) MAX(1)]); ylim([MIN(2) MAX(2)]);
    hold on;
    
    % plot radius of p-micro-cluster
    viscircles(ax,p_mc(i).center,p_mc(i).radius,...
               'Color',Color,'LineWidth',1);
    hold on;
end

for i=1:length(o_mc)
    Style = '.';
    MarkerSize = 10;
    Color = 'k';
    Legends{end+1} = ['O-Cluster #' num2str(i)];
    
    X = o_mc(i).points(:,2);
    Y = o_mc(i).points(:,3);

    plot(ax,X,Y,Style,'MarkerSize',MarkerSize,'Color',Color);
%     xlim([MIN(1)-5 MAX(1)+5]); ylim([MIN(2)-5 MAX(2)+5]);
    xlim([MIN(1) MAX(1)]); ylim([MIN(2) MAX(2)]);
    hold on;
    
end
hold on;
grid on;
% legend(Legends);
% legend('Location', 'NorthEastOutside');

end