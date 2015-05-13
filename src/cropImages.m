function images = cropImages(oimages)
    for i = 1 : size(oimages, 4)
        images(:, :, :, i) = cropOneImage(oimages(:, :, :, i));
    end
end