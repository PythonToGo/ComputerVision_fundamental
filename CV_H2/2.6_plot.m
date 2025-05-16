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
    
    %% Correspondeces from task 2.5
    % cor                   matrix containing all corresponding image points
    correspondence
    
    %% Visualize the correspoinding image point pairs
    if do_plot
        figure;
        
        Im1_norm = (Im1 - min(Im1(:))) / (max(Im1(:)) - min(Im1(:)) + eps);
        Im2_norm = (Im2 - min(Im2(:))) / (max(Im2(:)) - min(Im2(:)) + eps);

        
        Im1_rgb = repmat(Im1_norm, [1 1 3]);
        Im2_rgb = repmat(Im2_norm, [1 1 3]);
        
        overlay = 0.5 * Im1_rgb + 0.5 * Im2_rgb;
        
        imshow(overlay); hold on;
        
        for i = 1:size(cor, 2)
            x1 = cor(1, i); y1 = cor(2, i);
            x2 = cor(3, i); y2 = cor(4, i);
            
            plot(x1, y1, 'ro', 'MarkerSize', 6, 'LineWidth', 1.5);
            plot(x2, y2, 'bo', 'MarkerSize', 6, 'LineWidth', 1.5);
            
            line([x1, x2], [y1, y2], 'Color', 'g', 'LineWidth', 1);
        end
        
        title('Corresponding Points Overlay (Image1 + Image2)');
        hold off;
        
end