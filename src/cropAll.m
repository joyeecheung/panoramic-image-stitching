%% Crop the input images in batch
%  input:   images - A m * n * 3 * x array containing x images
%  output:  croppedImages - Array of cropped images
function croppedImages = cropAll(images)
    len = size(images, 4);
    for i = 1 : len
        croppedImages(:, :, :, i) = cropOne(images(:, :, :, i));
    end
end