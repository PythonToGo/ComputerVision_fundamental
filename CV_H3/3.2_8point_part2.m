function [EF] = epa(correspondences, K)
    % Depending on whether a calibrating matrix 'K' is given,
    % this function calculates either the essential or the fundamental matrix
    % with the eight-point algorithm.
    
    %% First step of the eight-point algorithm from task 3.1
    % Known variables:
    % x1, x2        homogeneous (calibrated) coordinates       
    % A             matrix A for the eight-point algorithm
    % V             right-singular vectors
    epa_part1
    
    %% Estimation of the matrices
    G_s = V(:, 9);  % min. opt. problem
    G = reshape(G_s, [3,3]);  % from [1,9] to [3,3]
    [U_G, S_G, V_G] = svd(G);
    % check rotation matrices
    if det(U_G) ~= 1
        U_G = U_G * [1 0 0;0 1 0;0 0 -1];
    end
    if det(V_G) ~= 1
        V_G = V_G * [1 0 0;0 1 0;0 0 -1];
    end
    if nargin == 2  % given K
        sigma = diag([1,1,0]);  % normalize
        EF = U_G * sigma * V_G';
    else 
        sigma = S_G;
        sigma(3,3) = 0;  % smallst SV = 0 
        EF = U_G * sigma * V_G';
    end

    
end