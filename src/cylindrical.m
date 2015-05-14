%% Apply Cylindrical Projection to the image
%  input:   images - A m * n * 3 * x array containing x images
%           f      - focal length of the camera
%           k1, k2 - radial distortion coefficients of the camera
%  output:  projectedImages - The projected images
function projectedImages = cylindrical(images, f, k1, k2)
    projectedImages = zeros(size(images));

    width = size(images, 2);
    height = size(images, 1);
    xc = width / 2;
    yc = height / 2;

    % formula from the lecture notes
    for x = 1 : width
        theta = (x - xc) / f;
        for y = 1 : height
            h = (y - yc) / f;
            xHat = sin(theta);
            yHat = h;
            zHat = cos(theta);
            
            xn = xHat / zHat;
            yn = yHat / zHat;
            r = xn^2 + yn^2;
            
            xd = xn * (1 + k1 * r + k2 * r^2);
            yd = yn * (1 + k1 * r + k2 * r^2);
            
            xi = int64(f * xd + xc);
            yi = int64(f * yd + yc);
            
            if (xi > 0 && xi <= width && yi > 0 && yi <= height)
                projectedImages(y, x, :, :) = uint8(images(yi, xi, :, :));
            end
        end
    end

    projectedImages = uint8(projectedImages);
end