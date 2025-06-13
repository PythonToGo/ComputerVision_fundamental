function [repro_error, x2_repro] = backprojection(correspondences, P1, Image2, T, R, K)
    % This function calculates the mean error of the back projection
    % of the world coordinates P1 from image 1 in camera frame 2
    % and visualizes the correct feature coordinates as well as the back projected ones.
    numPoints = size(P1, 2);
    P2 = K * (R * P1 + repmat(T, 1, numPoints));
    
    % convert coord.
    x2_repro = P2 ./ P2(3, :);
    
    % plot
    figure(1)
    imshow(Image2);
    hold on
    plot(correspondences(3,:), correspondences(4,:), 'b*', 'MarkerSize', 6, 'LineWidth',1);
    hold on
    plot(x2_repro(1,:), x2_repro(2,:), 'r*', 'MarkerSize', 6, 'LineWidth',1);
    hold on
    plot([correspondences(3,:),x2_repro(1,:)],...
        [correspondences(4,:),x2_repro(2,:)], 'g-', 'LineWidth',1);
    hold on
    for i=1:numPoints
        str = int2str(i);
        text(correspondences(3,i), correspondences(4,i), str, 'Color', 'r');
        text(x2_repro(1,i), x2_repro(2,i), str, 'Color', 'b');
    end
    
    % mean error of BP
    onesArray = ones(1, numPoints);
    x2 = correspondences(3:4, :);
    x2 = [x2; onesArray]; 
    repro_error = 0;
    for j = 1:numPoints
        repro_error = repro_error + norm(x2(:, j) - x2_repro(:, j));
    end
    repro_error = repro_error ./ numPoints;
    
end