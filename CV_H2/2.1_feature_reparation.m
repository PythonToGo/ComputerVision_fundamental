function [no_pts1, no_pts2, Ftp1, Ftp2] = point_correspondence(I1, I2, Ftp1, Ftp2, varargin)
    % In this function you are going to compare the extracted features of a stereo recording
    % with NCC to determine corresponding image points.
    
    %% Input parser from task 2.1
    % window_length     side length of quadratic window
    % min_corr          threshold for the correlation of two features
    % do_plot           image display variable
    % Im1, Im2          input images (double)
    input_parser
    
    %% Feature preparation
    half_w = floor(window_length / 2);
    
    % image size
    [h1, w1] = size(Im1);
    [h2, w2] = size(Im2);
    
    % mask
    mask1 = Ftp1(1,:) > half_w & Ftp1(1,:) <= (w1 - half_w) & ...
            Ftp1(2,:) > half_w & Ftp1(2,:) <= (h1 - half_w);
    mask2 = Ftp2(1,:) > half_w & Ftp2(1,:) <= (w2 - half_w) & ...
            Ftp2(2,:) > half_w & Ftp2(2,:) <= (h2 - half_w);
    
    Ftp1 = Ftp1(:, mask1);
    Ftp2 = Ftp2(:, mask2);
    
    no_pts1 = size(Ftp1, 2);
    no_pts2 = size(Ftp2, 2);


end