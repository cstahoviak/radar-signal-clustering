function [ p_mc,o_mc ] = Merging( P,p_mc,o_mc,lambda,eps,beta,mu,distType,t_now,colors )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%%% INPUTS:
% p_mc      set of potential-micro-clusters
% o_mc      set of outlier-micro-clusters

% lamda     fading factor
% eps       radius of epsilon-neighborhood
% minPts    minimum number of points in a cluster, DBSCAN parameter
% beta      parameter to distinguish between relative weights of p- and o-micro-clusters
% mu        core micro-cluster weught, integer value
% Tp        checking period for cluster weights, i.e. "pruning" period
% t_now     current time

%%% OUTPUTS:
% p_mc      set of potential-micro-clusters
% o_mc      set of outlier-micro-clusters

%% BEGIN FUNCTION

% try to merge P(i) into the nearest p-micro-cluster
% NOTE: assumes that at least one p-mc is created after the initial result
% of DBSCAN clsutering, requires {beta,mu} to be tuned
index = findClosestMicroCluster( P,p_mc,distType );

% calculate new radius of p_mc if P is merged into it
p_mc_temp = updateMicroCluster( P,p_mc(index),lambda,t_now,'p' );

if p_mc_temp.radius <= eps
    % merge P into nearest p-micro-cluster, p_mc(index)
    p_mc(index) = p_mc_temp;
elseif isempty(o_mc)
    % create new o-micro-cluster at P because none currently exist
    disp('MERGING: no o-micro-clusters exist, create new')
    o_mc = updateMicroCluster( P,[],lambda,t_now,'o' );
else
%     disp('P_MC RADIUS > EPS')
    % try to merge P into nearest o-micro-cluster
    index = findClosestMicroCluster( P,o_mc,distType );
    
    % calculate new radius of o_mc if P is merged into it
    o_mc_temp = updateMicroCluster( P,o_mc(index),lambda,t_now,'o' );
%     fprintf('MERGING: new o-mc radius = %f\t eps = %f\n', ...
%             o_mc_temp.radius,eps);
    
    if o_mc_temp.radius <= eps
        % merge P into nearest o-micro-cluster, o_mc(index)
        o_mc(index) = o_mc_temp;
        
        if o_mc(index).weight >= beta*mu
            % create a new p-mc at c_o
            % NOTE: assumes at least one p-micro-cluster currently exists
            disp('MERGING: create new p-micro-cluster')
            p_mc_temp = rmfield(o_mc(index),'t0');
            p_mc_temp.color = colors(length(p_mc)+1,:);     % assign next color to new p-mc
            p_mc = [p_mc; p_mc_temp];
            
            % remove o_mc(index) from o-mc buffer
            o_mc(index) = [];
        end
        
    else
        disp('MERGING: add new o-micro-cluster to outlier-buffer')
        % create new o-micro-cluster at P and insert it into the o-mc buffer
        o_mc_new = updateMicroCluster( P,[],lambda,t_now,'o' );
        
        % in some cases where o_mc is instantiated as a row vector instead
        % of a column vector, this concatenation fails... problem NOT resolved
        o_mc = [o_mc; o_mc_new];
    end
    
    
end


end

