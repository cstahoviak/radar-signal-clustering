function [ index ] = findClosestMicroCluster( P,mc,type )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% ToDo:
% 1. Figure out how to create an nx1 array from all the values of the same
%    field in an array of structs

%% BEGIN FUNCTION

Nmc = length(mc);     
dist = zeros(Nmc,1);

for i=1:Nmc
    if strcmp(type,'mahal')
        % find closest micro-cluster based on Mahalanobis distance

        Y = [P(2:3), P(6)];                         % observation P(i)
        X = [mc(i).center, mc(i).peakVal];  % reference

        dist(i) = pdist2(X,Y,'mahalanobis');

    elseif strcmp(type,'euclid')
        % find closest micro-cluster based on Euclidean distance

        Y = P(2:3);         % observation P(i)
        X = mc(i).center;   % reference

        dist(i) = pdist2(X,Y,'euclidean');

    elseif strcmp(type,'hamming')
        % find closest micro-cluster based on Hamming distance

    else
        % return ERROR

    end
    
end

% get index of minimum distance value
[~,index] = min(dist);

end

