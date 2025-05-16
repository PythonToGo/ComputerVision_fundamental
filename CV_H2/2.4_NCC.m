function [NCC_matrix, sorted_index] = point_correspondence(I1, I2, Ftp1, Ftp2, varargin)
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
    
    %% NCC calculations
    [feat_dim, n1] = size(Mat_feat_1);
    [~, n2] = size(Mat_feat_2);
    
    NCC_matrix = zeros(n2, n1);  % image2 rows × image1 cols
    
    for x = 1:n2  % image2
        v2 = Mat_feat_2(:, x);
        for y = 1:n1  % image1
            v1 = Mat_feat_1(:, y);
            denom = norm(v1) * norm(v2);
            if denom > 0
                NCC_matrix(x, y) = dot(v1, v2) / denom;
            else
                NCC_matrix(x, y) = 0;
            end
        end
    end
    
    % clip
    NCC_matrix = max(min(NCC_matrix, 1), -1);
    
    % Threshold
    NCC_matrix(NCC_matrix < min_corr) = 0;
    
    [rows, cols, vals] = find(NCC_matrix);
    linear_indices = sub2ind(size(NCC_matrix), rows, cols);
    [~, sort_idx] = sort(vals, 'descend');
    sorted_index = linear_indices(sort_idx);
    
    