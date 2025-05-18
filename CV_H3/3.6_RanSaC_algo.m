function [correspondences_robust, largest_set_F] = F_ransac(correspondences, varargin)
    % This function implements the RANSAC algorithm to determine 
    % robust corresponding image points
       
    %% Input parser
    % Known variables:
    % epsilon       estimated probability
    % p             desired probability
    % tolerance     tolerance to belong to the consensus-set
    % x1_pixel      homogeneous pixel coordinates
    % x2_pixel      homogeneous pixel coordinates
    input_parser
        
    %% RANSAC algorithm preparation
    % Pre-initialized variables:
    % k                     number of necessary points
    % s                     iteration number
    % largest_set_size      size of the so far biggest consensus-set
    % largest_set_dist      Sampson distance of the so far biggest consensus-set
    % largest_set_F         fundamental matrix of the so far biggest consensus-set
    ransac_preparation
    
    %% RANSAC algorithm
    biggestSet = [];
    numFeatures = size(correspondences, 2);
    for i = 1:s
        kIndex = randi([1, numFeatures], k, 1); % random k 
        kCorrespondence = correspondences(:,kIndex); % random k corresp. point
        F = epa(kCorrespondence);
        sd = sampson_dist(F, x1_pixel, x2_pixel);
        consensusSet = [];
        sumDistance = 0;
        for m = 1:size(sd, 2)
            if sd(m) < tolerance

                satisfiedPairs = [x1_pixel(1:2, m); x2_pixel(1:2, m)];
                consensusSet = [consensusSet satisfiedPairs];
                sumDistance = sumDistance + sd(m);  % sum: sampson distance
            end
        end
        numCorPair = size(consensusSet, 2); 

        if numCorPair > largest_set_size || ...
                (numCorPair == largest_set_size && sumDistance < largest_set_dist)
            biggestSet = consensusSet;
            largest_set_size = numCorPair;
            largest_set_dist = sumDistance;
            largest_set_F = F;
        end
    end
    % final consensus set
    correspondences_robust = biggestSet;

end