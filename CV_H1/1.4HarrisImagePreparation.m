function [Ix, Iy, w, G11, G22, G12] = harris_detector(input_image, varargin)
    % In this function you are going to implement a Harris detector that extracts features
    % from the input_image.
    
    %% Input parser from task 1.3
    % segment_length    size of the image segment
    % k                 weighting between corner- and edge-priority
    % tau               threshold value for detection of a corner
    % do_plot           image display variable
    input_parser
    
    %% Preparation for feature extraction
    % Check if it is a grayscale image
    if ndims(input_image) ~= 2
        error('Image format has to be NxMx1');
    end
    
    input_image = double(input_image);
    
    % Approximation of the image gradient
    [Ix, Iy] = sobel_xy(input_image);
    
    % Weighting
    sigma = segment_length / 6;
    half_len = floor(segment_length / 2);
    x = -half_len : half_len;
    w = exp(-x .^ 2/ (2 * sigma ^ 2));
    w = w / sum(w); % normalization
    
    % Harris Matrix G
    Ix2 = Ix .^ 2;
    Iy2 = Iy .^ 2;
    Ixy = Ix .* Iy;
    
    G11 = conv2(w, w', Ix2, 'same');
    G22 = conv2(w, w', Iy2, 'same');
    G12 = conv2(w, w', Ixy, 'same');
    
    
end