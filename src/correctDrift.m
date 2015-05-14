%% Correct for drift in stitched panorama
%  input:   image        - the stitched panorama
%           yshift_total - total shift of y direction
%  output:  panorama     - The corrected panorama
function panorama = correctDrift(image, yshift_total)
    if(yshift_total < 0)
        yshift_total = -yshift_total;
    end

    height = size(image, 1) - yshift_total * 2 ;
    width = size(image, 2);

    panorama = zeros(height, width, 3);

    for y = 1 : height
        for x = 1 : width
            delta = (double(x) - 1) / (double(width) - 1) * yshift_total * 2;
            newHeight = uint32(y + delta);
            panorama(y, x, :) = image(newHeight, x, :);
        end
    end

    panorama = uint8(cropOne(panorama));
end
