function [ p_mc,o_mc ] = DENSTREAM( P,p_mc,o_mc,lambda,eps,beta,mu,Tp,distType,t_now,colors )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%%% INPUTS:
% p_mc      potential-micro-clusters
% o_mc      outlier-micro-clusters

% lamda     fading factor
% eps       radius of epsilon-neighborhood
% minPts    minimum number of points in a cluster, DBSCAN parameter
% beta      parameter to distinguish between relative weights of p- and o-micro-clusters
% mu        core micro-cluster weught, integer value
% Tp        checking period for cluster weights, i.e. "pruning" period
% t_now     current time

%%% OUTPUTS:
% p_mc      potential-micro-clusters
% o_mc      outlier-micro-clusters

%% BEGIN FUNCTION

Ntargets = size(P,1);

% What if no iniitial clusters are created??
% Run DBSCAN on next scan of targets to try to create initial set of
% p-micro-clusters? (Implemented this solution) Other alternatives?
 
% loop through all points in current radar scan
for i=1:Ntargets
    % not sure if I should used t_now passed to the DENSTREAM function
    % call, or create a new t_now at each iteration of this loop
    t_now = toc;
    
    % merge current target into cluster map
    [ p_mc,o_mc ] = Merging( P(i,:),p_mc,o_mc,lambda,eps,beta,mu, ...
                              distType,t_now,colors );
end
% disp('FINISHED MERGING ALL TARGETS')

Np_mc = length(p_mc);
No_mc = length(o_mc);

% if current time is multiple of "pruning" interval
% disp(mod(round(t_now),Tp))
if ~mod(round(t_now),Tp)
    disp('DENSTREAM: pruning interval reached')
    
    % p-micro-cluster "pruning"
    if ~isempty(p_mc)
        i = 1;
        count = 1;
        while count <= Np_mc
            if p_mc(i).weight < beta*mu
                % delete o-micro-cluster
                fprintf('DENSTREAM: p-micro-cluster %d deleted\n',count)
                p_mc(i) = [];
            else
                i = i+1;
            end
            count = count+1; 
        end
    end
    
    % o-micro-cluster "pruning"
    if ~isempty(o_mc)
        i = 1;
        count = 1;
        while count <= No_mc
            xi = (2^(-lambda*(t_now - o_mc(i).t0 + Tp)) - 1) / ...
                 (2^(-lambda*Tp) - 1);
            if o_mc(i).weight < xi
                % delete o-micro-cluster
                fprintf('DENSTREAM: o-micro-cluster %d deleted\n',count)
                o_mc(i) = [];
            else
                i = i+1;
            end
            count = count+1; 
        end
    end
     
end % end if mod(t_now,Tp)

end

