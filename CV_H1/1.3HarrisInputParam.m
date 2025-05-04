function [segment_length, k, tau, do_plot] = harris_detector(input_image, varargin)
    % In this function you are going to implement a Harris detector that extracts features
    % from the input_image.

    %% Input parser
    p = inputParser;
    
    % required argument
    addRequired(p, 'input_image');
    
    % optional parameters
    addParameter(p, 'segment_length', 15, @(x) isnumeric(x) && mod(x,2)==1 && x > 0);
    addParameter(p, 'k', 0.05, @(x) isnumeric(x) && x > 0  && x < 1);
    addParameter(p, 'tau', 1e6, @(x) isnumeric(x) && x > 0);
    addParameter(p, 'do_plot', false, @(x) islogical(x));
    
    parse(p, input_image, varargin{:});
    
    % save value
    segment_length = p.Results.segment_length;
    k = p.Results.k;
    tau = p.Results.tau;
    do_plot = p.Results.do_plot;
    
end