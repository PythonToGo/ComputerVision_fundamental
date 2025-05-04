function [corners, sorted_index] = harris_detector(input_image, varargin)
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
    % features          detected features
    harris_measurement
    
    %% Feature preparation
    [H, W] = size(corners);
    corners_padded = zeros(H + 2 * min_dist, W + 2 * min_dist);
    corners_padded(min_dist + 1 : min_dist + H, min_dist + 1 : min_dist + W) = corners;
    corners = corners_padded;
    
    % 2. Get linear indices of non-zero entries
    corner_indices = find(corners);                % linear indices (column-wise)
    
    % 3. Get corresponding Harris values
    corner_values = corners(corner_indices);
    
    % 4. Sort descending
    [~, sort_order] = sort(corner_values, 'descend');
    sorted_index = corner_indices(sort_order);



    
end