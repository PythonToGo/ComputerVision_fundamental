function [window_length, min_corr, do_plot, Im1, Im2] = point_correspondence(I1, I2, Ftp1, Ftp2, varargin)
    % In this function you are going to compare the extracted features of a stereo recording
    % with NCC to determine corresponding image points.
    
    %% Input parser
    p = inputParser;
    
    % define default
    default_window_length = 25;
    default_min_corr = 0.95;
    default_do_plot = false;
    
    %valid func
    validNumber = @(x) isnumeric(x) && isscalar(x);
    validOdd = @(x) validNumber(x) && mod(x,2) == 1 && x > 0;
    validLogical = @(x) islogical(x) && isscalar(x);

    
    % add optional parameters
    addParameter(p, 'window_length', default_window_length, validOdd);
    addParameter(p, 'min_corr', default_min_corr, validNumber);
    addParameter(p, 'do_plot', default_do_plot, validLogical);
    
    % parse input
    parse(p, varargin{:});
    window_length = p.Results.window_length;
    min_corr = p.Results.min_corr;
    do_plot = p.Results.do_plot;
    
    Im1 = double(I1);
    Im2 = double(I2);

end