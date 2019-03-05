function [ p_mc,o_mc ] = generateMicroClusters( P,idx,t_now,lambda,beta,mu,colors )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% NOTE:
% 1. DBSCAN outliers are assigned an idx value of zero and will not be
%    assigned to either p- or o-micro-clusters
% 2. For the initial scan, only p-micro-clusters should be generated, with
%    weight equal to sum(2^0) = N, the number of points in the cluster.

% UNFINISHED:
% 1. radius calculation from Definition 3.4 is yielding imaginary
%    numbers...
% 2. Use repmat() to init array of micro-cluster structs

%% BEGIN FUNCTION

% init micro-cluster struct - how to init array of empty structs?
% ANS: Use repmat - https://stackoverflow.com/questions/13664090/how-to-initialize-an-array-of-structs-in-matlab
p_mc = struct([]);
o_mc = struct([]);

% loop through each cluster identified by DBSCAN
for i=1:max(idx)
    cluster_idx = (idx == i);
    
    % create new micro-cluster
    points = P(cluster_idx,:);
    mc = updateMicroCluster( points,[],lambda,t_now,'' );
                     
   if mc.weight >= beta*mu
       % add unique color to p-micro-cluster
       mc.color = colors(i,:);
       
       % assign micro-cluster to list of p-micro-clusters
       if isempty(p_mc)
           % create new array of p-micro-clusters
           p_mc = mc;
       else
           % append current micro-cluster to array of p-micro-clusters
           p_mc = [p_mc; mc];
       end 
   else
       % add initializtion time to o-micro-cluster
       mc.to = t_now;
       
       % assign micro-cluster to list of o-micro-clusters
       if isempty(o_mc)
           % create new array of o-micro-clusters
           o_mc = mc;
       else
           % append current micro-cluster to array of p-micro-clusters
           o_mc = [o_mc; mc];
       end
   end
    
end


end

