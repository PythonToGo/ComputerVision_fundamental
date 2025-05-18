function [epsilon, p, tolerance, x1_pixel, x2_pixel] = F_ransac(correspondences, varargin)
    % This function implements the RANSAC algorithm to determine 
    % robust corresponding image points
    %% Input parser
    % Known variables:
    % epsilon       estimated probability
    % p             desired probability
    % tolerance     tolerance to belong to the consensus-set
    % x1_pixel      homogeneous pixel coordinates
    % x2_pixel      homogeneous pixel coordinates


    defaultEpsilon = 0.5;
    defaultP = 0.5;
    defaultTolerance = 0.01;
    
    parser = inputParser;
    addParameter(parser, 'epsilon', defaultEpsilon, @(x) isnumeric(x) && (x > 0) && (x < 1));
    addParameter(parser, 'probability',defaultP, @(x) isnumeric(x) && (x > 0) && (x < 1));
    addParameter(parser, 'tolerance', defaultTolerance, @(x) isnumeric(x));
    
    parse(parser, varargin{:});
    
    numFeatures = size(correspondences, 2);
    onesArray = ones(1, numFeatures);
    x1_pixel = correspondences(1:2, :);
    x1_pixel = [x1_pixel; onesArray];  % homo coord 
    x2_pixel = correspondences(3:4, :);
    x2_pixel = [x2_pixel; onesArray];
    
    epsilon = parser.Results.epsilon;
    p = parser.Results.probability;
    tolerance = parser.Results.tolerance;
    
end