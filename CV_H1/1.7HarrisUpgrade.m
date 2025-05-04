function [min_dist, tile_size, N] = harris_detector(input_image, varargin)
    % In this function you are going to implement a Harris detector that extracts features
    % from the input_image.
    
    %% Input parser
    p = inputParser;
    
    addRequired(p, 'input_image');
    
    addParameter(p, 'segment_length', 15, @(x) isnumeric(x) && mod(x,2)==1 && x > 0);
    addParameter(p, 'k', 0.05, @(x) isnumeric(x) && x > 0 && x < 1);
    addParameter(p, 'tau', 1e6, @(x) isnumeric(x) && x > 0);
    addParameter(p, 'do_plot', false, @(x) islogical(x));

    % New parameters
    addParameter(p, 'min_dist', 20, @(x) isnumeric(x) && isscalar(x) && x > 0);
    addParameter(p, 'tile_size', 200, @(x) isnumeric(x) && (isscalar(x) || (isvector(x) && numel(x)==2)));
    addParameter(p, 'N', 5, @(x) isnumeric(x) && isscalar(x) && x > 0);

    % Parse
    parse(p, input_image, varargin{:});

    % Get parsed values
    min_dist = p.Results.min_dist;
    tile_size_raw = p.Results.tile_size;
    N = p.Results.N;
    
    if isscalar(tile_size_raw)
        tile_size = [tile_size_raw, tile_size_raw];
    else
        tile_size = tile_size_raw(:)';  % ensure row vector [h w]
    end
    
end