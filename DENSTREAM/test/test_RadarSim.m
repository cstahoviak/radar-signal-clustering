%% Test Radar Simulator

clc;
clear;
close ALL;

Ntargets_RDRSIM = 5;
    
RCS = 50*ones(Ntargets_RDRSIM,1);
points = [-10 10; 0 0; 10 10; 0 20; 5 50];
velocity = zeros(Ntargets_RDRSIM,1);
AoA = zeros(Ntargets_RDRSIM,1);

target_attribute = [RCS, points, velocity, AoA];
[ targets ] = func_fmcw_radar_simulator_2018_0721( target_attribute );

fprintf('MAX SNR = %f\n',max(targets(:,1)));
fprintf('MIN SNR = %f\n',min(targets(:,1)));

figure(1)
scatter(points(:,1),points(:,2),20,'kx'); hold on;
scatter(targets(:,2),targets(:,3),10,'filled')