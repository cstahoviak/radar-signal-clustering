function [ P ] = getTargets( Ntargets_max,MU,SIGMA,RADAR_SIM,AGP,chirp_params )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% get current time
t_now = toc;

% simulate radar targets {P}_i
allTargets = mvnrnd(MU,SIGMA);

if RADAR_SIM
    % NOTE (8/16): Not working yet. Still need to work with Christopher
    % on getting targets from his radar simulater (in progress)
    
    Ntargets_RDRSIM = 5;
    
    RCS = 50*ones(Ntargets_RDRSIM,1);               % radar cross section        [m^2]
    points = allTargets(1:Ntargets_RDRSIM,1:2);     % 2D target locations        [m]
    velocity = zeros(Ntargets_RDRSIM,1);            % target velocity            [m/s]
    AoA = zeros(Ntargets_RDRSIM,1);                 % target direction of travel [deg]
                                                    %     0 deg - moving left
                                                    %    90 deg - moving away from sensor 
                                                    %   180 deg - moving right 
                                                    %   270 deg - moving towards sensor
    
    target_attribute = [RCS, points, velocity, AoA];
    
    [ targets ] = func_fmcw_radar_simulator_2018_0815( target_attribute, ...
        AGP,chirp_params);
    P = [ones(64,1)*t_now, targets(:,2:5), targets(:,1)];
    
else
    % random number of targets between 0 and Ntargets_max
    Ntargets = randi(Ntargets_max);

    % sample Ntargets from array of Ntargets_max targets
    P = [ones(Ntargets,1)*t_now, ...
         datasample(allTargets,Ntargets,'Replace',false)];
end



end

