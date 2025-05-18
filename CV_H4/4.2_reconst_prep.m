function [T_cell, R_cell, d_cell, x1, x2] = reconstruction(T1, T2, R1, R2, correspondences, K)
    %% Preparation

    % T    cell array with T1 and T2
    % R    cell array with R1 and R2
    % d    cell array for the depth information
    % x1   homogeneous calibrated coordinates
    % x2   homogeneous calibrated coordinates% 4 possibilities to combie T and R
    
    
    T_cell = {T1, T2, T1, T2};
    R_cell = {R1, R1, R2, R2};
    N = size(correspondences, 2); 
    onesArray = ones(1, N);
    x1 = correspondences(1:2, :);
    x1 = [x1; onesArray];  % homo coord
    x2 = correspondences(3:4, :);
    x2 = [x2; onesArray];
    
    x1 = inv(K) * x1;
    x2 = inv(K) * x2;
    
    d_cell = {zeros(N,2), zeros(N,2), zeros(N,2), zeros(N,2)};
end