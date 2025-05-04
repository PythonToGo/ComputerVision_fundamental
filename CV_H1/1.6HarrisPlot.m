function features = harris_detector(input_image, varargin)
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
    
    %% Feature extraction with the Harris measurement from task 1.5
    % features          detected features
    % corners           matrix containing the value of the Harris measurement for each pixel
    harris_measurement
    
    %% Plot
    if do_plot
        imshow(uint8(input_image)); hold on;
        
        x = features(1, :);
        y = features(2, :);
        
        % plot scatter
        scatter(x, y, 36, 'r', 's', 'filled');
        
        if false
            plot(x, y);
        end
        
        title('Detected Harris Corners');
        hold off;
    end
    
    
end