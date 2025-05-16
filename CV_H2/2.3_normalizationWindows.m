function [Mat_feat_1, Mat_feat_2] = point_correspondence(I1, I2, Ftp1, Ftp2, varargin)
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
    
    %% Normalization
    half_w = floor(window_length / 2);
    win_size = window_length^2;
    
    no_pts1 = size(Ftp1, 2);
    no_pts2 = size(Ftp2, 2);
    
    Mat_feat_1 = zeros(win_size, no_pts1);
    Mat_feat_2 = zeros(win_size, no_pts2);
    
    % ftp1
    for i = 1:no_pts1
        x = round(Ftp1(1,i));
        y = round(Ftp1(2,i));
        window = Im1(y - half_w : y + half_w, x - half_w : x + half_w);
        w_vec = window(:);
        w_norm = (w_vec - mean(w_vec)) / std(w_vec);
        Mat_feat_1(:, i) = w_norm;
    end
    
    % ftp2
    for i = 1:no_pts2
        x = round(Ftp2(1,i));
        y = round(Ftp2(2,i));
        window = Im2(y - half_w : y + half_w, x - half_w : x + half_w);
        w_vec = window(:);
        w_norm = (w_vec - mean(w_vec)) / std(w_vec);
        Mat_feat_2(:, i) = w_norm;
    end
    
end