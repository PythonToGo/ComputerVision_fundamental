function gray_image = rgb_to_gray(input_image)
    % This function is supposed to convert a RGB-image to a grayscale image.
    % If the image is already a grayscale image directly return it.
    
    % check grayscale
    if ndims(input_image) == 2
        gray_image = input_image;
        return;
    end
    % conert double
    input_image = double(input_image);
    
   % RGB
   R = input_image(:,:,1);
   G = input_image(:,:,2);
   B = input_image(:,:,3);
   
   gray = 0.299 * R + 0.587 * G + 0.114 * B;
   
   gray_image = uint8(gray);
    

end