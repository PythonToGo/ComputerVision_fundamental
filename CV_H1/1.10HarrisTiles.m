function [acc_array, features] = harris_detector(input_image, varargin)
    % In this function you are going to implement a Harris detector that extracts features
    % from the input_image.
    
    %% Input parser from task 1.7
    % segment_length    size of the image segment
    % k                 weighting between corner- and edge-priority
    % tau               threshold value for detection of a corner
    % do_plot           image display variable
    % min_dist          minimal distance of two features in pixels
    % tile_size         size of the tiles
    % N                 maximal number of features per tile
    input_parser_new

    %% Preparation for feature extraction from task 1.4
    % Ix, Iy            image gradient in x- and y-direction
    % w                 weighting vector
    % G11, G12, G22     entries of the Harris matrix
    image_preprocessing
    
    %% Feature extraction with the Harris measurement from task 1.5
    % corners           matrix containing the value of the Harris measurement for each pixel         
    harris_measurement
    
    %% Feature preparation from task 1.9
    %corners            Harris measurement for each pixel respecting the minimal distance
    %sorted_index       Index list of features sorted descending by thier strength
    feature_preprocessing
    
    %% Accumulator array
    [orig_h, orig_w] = size(input_image);
    tile_h = tile_size(1);
    tile_w = tile_size(2);
    
    num_tile_rows = ceil(orig_h / tile_h);
    num_tile_cols = ceil(orig_w / tile_w);

    acc_array = zeros(num_tile_rows, num_tile_cols);

    %% Final: allocate features (limit to expected max)
    max_features = min(N * num_tile_rows * num_tile_cols, length(sorted_index));
    features = zeros(2, max_features);

    %% Debug
    fprintf('[DEBUG] acc_array size: [%d %d]\n', size(acc_array, 1), size(acc_array, 2));
    fprintf('[DEBUG] sorted_index length: %d\n', length(sorted_index));
    fprintf('[DEBUG] requested max features: %d\n', max_features);
    fprintf('[DEBUG] features size: [%d %d]\n', size(features, 1), size(features, 2));

end