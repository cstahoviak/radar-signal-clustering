function [ P,idx ] = denstream_init( ax,Ntargets_max,MU,SIGMA,eps,minPts,MIN,MAX,waitTime,colors,RADAR_SIM,AGP,chirp_params )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% init array of targets
P = [];

idx = zeros(Ntargets_max,1);
while sum(idx) == 0
    % simulate radar targets {P}_i
    [ targets ] = getTargets( Ntargets_max,MU,SIGMA,RADAR_SIM,AGP,chirp_params );
    P = [P; targets];
   
    % plot initial points before DBSCAN clustering
    scatter(ax,P(:,2),P(:,3),15,'kx'); grid on;
%     xlim([MIN(1)-5 MAX(1)+5]); ylim([MIN(2)-5 MAX(2)+5]);
    xlim([MIN(1) MAX(1)]); ylim([MIN(2) MAX(2)]);
    pause(waitTime);

    % Apply DBSCAN to the first set of points {P} to initilize the online process
    idx = DBSCAN( P(:,2:3),eps,minPts );
end
% hold on;

% plot DBSCAN results - does this assign the same colors to the
% p-micro-clusters that I assign to them in generateMicroClusters()??
PlotDBSCANResult(ax,P(:,2:3),idx,colors);
grid on; hold on;
title(['DBSCAN Clustering (\epsilon = ' num2str(eps) ', minPts = ' num2str(minPts) ')']);
% xlim([MIN(1)-5 MAX(1)+5]); ylim([MIN(2)-5 MAX(2)+5]);
xlim([MIN(1) MAX(1)]); ylim([MIN(2) MAX(2)]);
pause(waitTime);

end

