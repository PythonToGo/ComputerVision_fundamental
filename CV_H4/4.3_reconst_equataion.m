function [T, R, lambda, M1, M2] = reconstruction(T1, T2, R1, R2, correspondences, K)
    %% Preparation from task 4.2
    % T_cell    cell array with T1 and T2 
    % R_cell    cell array with R1 and R2
    % d_cell    cell array for the depth information
    % x1        homogeneous calibrated coordinates
    % x2        homogeneous calibrated coordinates
    preparation
    
    %% Reconstruction
    N = size(correspondences, 2); 
    M1 = zeros(3*N, N+1);
    M2 = zeros(3*N, N+1);
    
    % all possible combi
    for i = 1:4
        x1_cell = mat2cell(x1, 3, ones(1,N)); 
        x2_cell = mat2cell(x2, 3, ones(1,N));
        % x hat
        x1_hat = cellfun(@(a) hat(a), x1_cell, 'UniformOutput', false);
        x2_hat = cellfun(@(a) hat(a), x2_cell, 'UniformOutput', false);
        T = T_cell{i};
        R = R_cell{i};
        
        
        for j = 1:N
            M1(3*j-2:3*j, j) = x2_hat{j} * R * x1_cell{j};
            M1(3*j-2:3*j, N+1) = x2_hat{j} * T;
            M2(3*j-2:3*j, j) = x1_hat{j} * R' * x2_cell{j};
            M2(3*j-2:3*j, N+1) = -x1_hat{j} * R' * T;
        end
        
        
        % svd
        [~,~,V1] = svd(M1);
        [~,~,V2] = svd(M2);
        
        d1 = V1(:, end);
        d2 = V2(:, end);
        
        
        % normalize - gamma <- 1
        d1 = d1./d1(end, :);
        d2 = d2./d2(end, :);
        
        d_cell{i} = [d1(1:end-1, :), d2(1:end-1,:)];
    end
    
    indexPositive = cellfun(@(a) find(a>0), d_cell, 'UniformOutput', false);
    numPositive = cellfun(@length, indexPositive, 'UniformOutput', false);
    numPositive = cell2mat(numPositive);
    [~, maxIndex] = max(numPositive);
    R = R_cell{maxIndex};
    T = T_cell{maxIndex};
    lambda = d_cell{maxIndex};

    
end