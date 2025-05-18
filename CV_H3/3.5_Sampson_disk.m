function sd = sampson_dist(F, x1_pixel, x2_pixel)
    % This function calculates the Sampson distance based on the fundamental matrix F
    e3_dach = [0,-1,0; 1,0,0; 0,0,0];  % skew matrix e3
    numerator = diag(x2_pixel' * F * x1_pixel);
    numerator = (numerator .* numerator)';
    denominator_1 = (e3_dach * F * x1_pixel).^2;
    denominator_1 = denominator_1(1,:) + denominator_1(2,:) + denominator_1(3,:);
    denominator_2 = ((x2_pixel' * F * e3_dach).^2)';
    denominator_2 = denominator_2(1,:) + denominator_2(2,:) + denominator_2(3,:);
    sd = numerator ./ (denominator_1 + denominator_2);

end