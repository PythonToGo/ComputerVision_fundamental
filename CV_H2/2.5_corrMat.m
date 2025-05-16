function cor = point_correspondence(I1, I2, Ftp1, Ftp2, varargin)
    % In this function you are going to compare the extracted features of a stereo recording
    % with NCC to determine corresponding image points.
    
    %% Input parser from task 2.1
    % window_length         side length of quadratic window
    % min_corr              threshold for the correlation of two features
    % do_plot               image display variable
    % Im1, Im2              input images (double)
    input_parser
    
    %% Feature preparation from task 2.2
    % no_pts1, no_pts 2     number of features remaining in each image
    % Ftp1, Ftp2            preprocessed features
    feature_preprocessing
    
    %% Normalization from task 2.3
    % Mat_feat_1            normalized windows in image 1
    % Mat_feat_2            normalized windows in image 2
    window_normalization
    
    %% NCC from task 2.4
    % NCC_matrix            matrix containing the correlation between the image points
    % sorted_index          sorted indices of NCC_matrix entries in decreasing order of intensity
    ncc_calculation
    
    %% Correspondeces
    [n2, n1] = size(NCC_matrix);  % rows = image2 features, cols = image1 features
    
    matched_img1 = false(1, n1);  % Only image1 (column) side must not repeat
    cor = [];  % Correspondences [4 x K]
    
    for i = 1:length(sorted_index)
        [x, y] = ind2sub(size(NCC_matrix), sorted_index(i));  % x = img2 idx, y = img1 idx
    
        if ~matched_img1(y)
            p1 = Ftp1(:, y);  % image1: [x1; y1]
            p2 = Ftp2(:, x);  % image2: [x2; y2]
            cor = [cor, [p1; p2]];
            matched_img1(y) = true;
        end
    end
    
    fprintf("Expected number of correspondences: %d\n", sum(NCC_matrix(:) > 0));
    fprintf("Actual number of matched correspondences: %d\n", size(cor, 2));

    
    
end