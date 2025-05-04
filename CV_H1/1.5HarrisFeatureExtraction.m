function [H, corners, features] = harris_detector(input_image, varargin)
    % In this function you are going to implement a Harris detector that extracts features
    % from the input_image.
    
    %% Input parser from task 1.3
    % segment_length    size of the image segment
    % k                 weighting between corner- and edge-priority
    % tau               threshold value for detection of a corner
    % do_plot           image display variable
    input_parser

    %% Preparation for feature extraction from task 1.4
    % Ix, Iy            image gradient in x- and y-direction
    % w                 weighting vector
    % G11, G12, G22     entries of the Harris matrix
    image_preprocessing
    
    %% Feature extraction with the Harris measurement
    %% Harris Measurement
    H = (G11 .* G22 - G12.^2) - k * (G11 + G22).^2;

    % Apply threshold tau
    corners = H;
    corners(H < tau) = 0;

    % Remove borders
    margin = ceil(segment_length / 2);
    corners(1:margin, :) = 0;
    corners(end-margin+1:end, :) = 0;
    corners(:, 1:margin) = 0;
    corners(:, end-margin+1:end) = 0;

    % Get coordinates of remaining features
    [y, x] = find(corners > 0);
    features = [x'; y'];

    %% Optional: Plot detected features
    if do_plot
        figure; imshow(uint8(input_image)); hold on;
        plot(x, y, 'r+', 'MarkerSize', 6, 'LineWidth', 1.5);
        hold off;
    end

    %% Debugging output
    fprintf('[DEBUG] H size: [%d %d]\n', size(H,1), size(H,2));
    fprintf('[DEBUG] corners non-zero: %d\n', nnz(corners));
    fprintf('[DEBUG] features count: %d\n', size(features,2));
    fprintf('[DEBUG] x max = %d, y max = %d\n', max(features(1,:)), max(features(2,:)));

    
end