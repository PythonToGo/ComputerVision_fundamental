function [x1, x2, A, V] = epa(correspondences, K)
    % Depending on whether a calibrating matrix 'K' is given,
    % this function calculates either the essential or the fundamental matrix
    % with the eight-point algorithm.
    %% First step of the eight-point algorithm from task 3.1
    % Known variables:
    % x1, x2        homogeneous (calibrated) coordinates
    % A             matrix A for the eight-point algorithm
    % V             right-singular vectors


    numFeatures = size(correspondences, 2);
    onesArray = ones(1, numFeatures);
    x1 = correspondences(1:2, :);
    % homo coordinates
    x1 = [x1; onesArray];  
    x2 = correspondences(3:4, :);
    x2 = [x2; onesArray];
    if nargin == 2  %  calibrating matrix
        x1 = inv(K) * x1;
        x2 = inv(K) * x2;
    end
    A = zeros(numFeatures, 9);
    for i = 1:numFeatures
        x1_sample = x1(:, i);  % i-th sample
        x2_sample = x2(:, i);
        A(i, :) = kron(x1_sample, x2_sample)';  % cronecker product on i th sample 
    end
    [U, S, V] = svd(A);

end
