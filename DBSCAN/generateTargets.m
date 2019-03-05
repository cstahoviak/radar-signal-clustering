function [ P ] = generateTargets( Ntargets,max,min )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% init P
P = zeros(Ntargets,4);

for i=1:Ntargets
    xy_cov = rand();
    MU = [(max(1) - min(1))*rand() + min(1);
          (max(2) - min(2))*rand() + min(2);
          (max(3) - min(3))*rand() + min(3)];

    SIGMA = [abs(max(1) - min(1)*rand() + min(1)), xy_cov, 0;
             xy_cov, (max(2) - min(2))*rand() + min(2), 0;
             0, 0, (max(3) - min(3))*rand() + min(3)];

    % simulate data from multivariate random distribution
    P(i,1:3) = mvnrnd(MU,SIGMA);

%     P(i).x       = data(1);
%     P(i).y       = data(2);
%     P(i).peakVal = data(3);

end

% add time data to points - same for all points in a single scan
P(:,4) = rem(now,1);

end

