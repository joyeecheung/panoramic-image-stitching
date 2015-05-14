%% Crop the black edges out of the input image
%  input:   image - A m * n * 3 array
%  output:  cropped - The cropped image
function cropped = cropOne(image)
    h = size(image, 1);
    w = size(image, 2);

    marginLeft = 1;
    while sum(image(:, marginLeft)) == 0
        marginLeft = marginLeft + 1;
    end

    marginRight = w;
    while sum(image(:, marginRight)) == 0
        marginRight = marginRight - 1;
    end

    marginTop = 1;
    while sum(image(marginTop, marginLeft:marginRight)) == 0
        marginTop = marginTop + 1;
    end

    marginBottom = h;
    while sum(image(marginBottom, marginLeft:marginRight)) == 0
        marginBottom = marginBottom - 1;
    end

    fprintf('left = %f, right = %f,', marginLeft, marginRight);
    fprintf('top = %f, bottom = %f\n', marginTop, marginBottom);
    cropped = imcrop(image, [marginLeft marginTop marginRight-marginLeft marginBottom-marginTop]);
end