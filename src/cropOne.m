%% Crop the black edges out of the input image
%  input:   image - A m * n * 3 array
%  output:  cropped - The cropped image
function cropped = cropOne(image)
    h = size(image, 1);
    w = size(image, 2);

    marginLeft = 0;
    numBlack = h;
    while numBlack == h
        marginLeft = marginLeft + 1;
        numBlack = 0;
        for j = 1 : h
            if sum(image(j, int32(marginLeft), :) == 0) == 3
                numBlack = numBlack + 1;
            end
        end
    end

    marginRight = w + 1;
    numBlack = h;
    while numBlack == h
        marginRight = marginRight - 1;
        numBlack = 0;
        for j = 1 : h
            if sum(image(j, int32(marginRight), :) == 0) == 3
                numBlack = numBlack + 1;
            end
        end
    end

    marginTop = 1;
    while sum(image(int32(marginTop), marginLeft+1, :) == 0) == 3 || ...
        sum(image(int32(marginTop), marginRight-1, :) == 0) == 3
        marginTop = marginTop +1;
    end
    
    marginBottom = h;
    while sum(image(int32(marginTop), marginLeft+1, :) == 0) == 3 || ...
        sum(image(int32(marginTop), marginRight-1, :) == 0) == 3
        marginBottom = marginBottom - 1;
    end

    cropped = imcrop(image, [marginLeft marginTop marginRight-marginLeft marginBottom-marginTop]);
end