function [T, R, lambda, P1, camC1, camC2] = reconstruction(T1, T2, R1, R2, correspondences, K)
    % This function estimates the depth information and thereby determines the 
    % correct Euclidean movement R and T. Additionally it returns the
    % world coordinates of the image points regarding image 1 and their depth information.
    
    %% Preparation from task 4.2
    % T_cell    cell array with T1 and T2 
    % R_cell    cell array with R1 and R2
    % d_cell    cell array for the depth information
    % x1        homogeneous calibrated coordinates
    % x2        homogeneous calibrated coordinates
    preparation
    
    %% R, T and lambda from task 4.3
    % T         reconstructed translation
    % R         reconstructed rotation
    % lambda    depth information
    R_T_lambda
    
    %% Calculation and visualization of the 3D points and the cameras
    N = size(correspondences, 2);
    P1 = zeros(3, N);
    for i=1:N
        P1(:, i) = lambda(i, 1) .* x1(:, i);  % camera 1 
    end
    
    figure(1)
    scatter3(P1(1,:), P1(2,:), P1(3,:));
    
    
    for i=1:N
        text(P1(1,i), P1(2,i), P1(3,i), num2str(i));
    end
    
    % cam 1 corner
    camC1 = [-0.2,0.2,0.2,-0.2; 0.2,0.2,-0.2,-0.2; 1,1,1,1];
    
    % cam 2 corner thorugh euclid transf
    camC2 = inv(R) * (camC1 - [T, T, T, T]);
    
    % plot
    camC1_plot = [camC1 camC1(:,1)];
    camC2_plot = [camC2 camC2(:,1)];
    figure(2)
    frame1 = plot3(camC1_plot(1,:), camC1_plot(2,:), camC1_plot(3,:), 'b');
    grid on;
    hold on;
    frame2 = plot3(camC2_plot(1,:), camC2_plot(2,:), camC2_plot(3,:), 'r');
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    campos([43, -22, -87]);
    camup([0, -1, 0]);
    legend([frame1, frame2], {'Cam1','Cam2'});
    end

    %% hat
    function W = hat(w)
    s
    size = size(w,1);
    if size == 3
        w_1 = w(1);
        w_2 = w(2);
        w_3 = w(3);
        W = [0, -w_3, w_2; w_3, 0, -w_1; -w_2, w_1, 0];
    else
        msg = 'Variable w has to be a 3-component vector!';
        error(msg);
    end
end