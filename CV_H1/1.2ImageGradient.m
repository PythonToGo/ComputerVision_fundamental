function [Fx, Fy] = sobel_xy(input_image)
    % In this function you have to implement a Sobel filter 
    % that calculates the image gradient in x- and y- direction of a grayscale image.
    
    % input image double
    input_image = double(input_image);
    
    % soebel kernel
    Sx = [ -1  0  1;
           -2  0  2;
           -1  0  1 ];
    
    Sy = [ -1  -2  -1;
            0   0   0;
            1   2   1 ];
    
    % convolve
    Fx = conv2(input_image, rot90(Sx, 2), 'same');
    Fy = conv2(input_image, rot90(Sy, 2), 'same');
    
end