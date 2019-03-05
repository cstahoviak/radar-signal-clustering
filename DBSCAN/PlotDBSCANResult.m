function PlotDBSCANResult( ax,X,IDX,colors )

k = max(IDX);
Legends = {};

for i=0:k
    Xi = X(IDX==i,:);
    if i~=0
        Style = '.';
        MarkerSize = 10;
        Color = colors(i,:);
        Legends{end+1} = ['Cluster #' num2str(i)];
    else
        Style = '.';
        MarkerSize = 10;
        Color = [0 0 0];
        if ~isempty(Xi)
            Legends{end+1} = 'Noise';
        end
    end
    if ~isempty(Xi)
        plot(ax,Xi(:,1),Xi(:,2),Style,'MarkerSize',MarkerSize,'Color',Color);
    end
    hold on;
end
% hold off;
grid on;
% legend(Legends);
% legend('Location', 'NorthEastOutside');

end