function features = harris_detector(input_image, varargin)
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
    % sorted_index      sorted indices of features in decreasing order of feature strength
    feature_preprocessing
    
    %% Accumulator array from task 1.10
    % acc_array         accumulator array which counts the features per tile
    % features          empty array for storing the final features
    accumulator_array
    
    %% Feature detection with minimal distance and maximal number of features per tile

    Cake = cake(min_dist);
    [ck_h, ck_w] = size(Cake);
    offset_h = floor(ck_h / 2);
    offset_w = floor(ck_w / 2);
    
    feature_count = 0;
    
    for i = 1:length(sorted_index)
        [y_raw, x_raw] = ind2sub(size(corners), sorted_index(i));
        
        % padding
        y = y_raw - min_dist;
        x = x_raw - min_dist;
        
        % out of range -> skip
        if x < 1 || x > size(input_image, 2) || ...
           y < 1 || y > size(input_image, 1)
            continue;
        end
    
        tile_y = ceil(y / tile_size(1));
        tile_x = ceil(x / tile_size(2));
    
        if tile_y > size(acc_array,1) || tile_x > size(acc_array,2)
            continue;
        end
    
        if acc_array(tile_y, tile_x) >= N
            continue;
        end
    
        if corners(y_raw, x_raw) == 0 
            continue;
        end
    
        % features
        feature_count = feature_count + 1;
        features(:, feature_count) = [x; y];
        acc_array(tile_y, tile_x) = acc_array(tile_y, tile_x) + 1;
    
        % Cake mask range
        y_start = y_raw - offset_h;
        y_end   = y_raw + offset_h;
        x_start = x_raw - offset_w;
        x_end   = x_raw + offset_w;
    
        % clip
        y_start = max(1, y_start);
        y_end   = min(size(corners,1), y_end);
        x_start = max(1, x_start);
        x_end   = min(size(corners,2), x_end);
    
        cy_start = max(1, 1 + (1 - y_raw + offset_h));
        cx_start = max(1, 1 + (1 - x_raw + offset_w));
        cy_end   = ck_h - max(0, y_end - y_raw - offset_h);
        cx_end   = ck_w - max(0, x_end - x_raw - offset_w);
    
        % apply
        corners(y_start:y_end, x_start:x_end) = ...
            corners(y_start:y_end, x_start:x_end) .* ...
            Cake(cy_start:cy_end, cx_start:cx_end);
    end
    
    % trim features
    features = features(:, 1:feature_count);
    
    
    % Debugging info
    fprintf('[DEBUG] final feature_count = %d\n', feature_count);
    fprintf('[DEBUG] final features size = [%d %d]\n', size(features,1), size(features,2));
    fprintf('[DEBUG] x max = %d, y max = %d\n', max(features(1,:)), max(features(2,:)));
    fprintf('[DEBUG] image size = [%d %d]\n', size(input_image,1), size(input_image,2));
    
    % Plot Routine
    plotting
    
end