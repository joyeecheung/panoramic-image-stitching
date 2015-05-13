%% Blend two images together
%  input:   image1 - A m * n * 3 array
%           image2 - A m * n * 3 array
%           xshift
%  output:  cropped - The cropped image

%Stich two images together
%Input: image1, image2 - two images
%       xshift, yshift - x and y shift
%Output: newImg - result image
function newImg = featherTwoImages(image1, image2, xshift, yshift)
    % make sure image1 and image2 are good when xshift > 0
    if xshift < 0
        xshift = -xshift;
        yshift = -yshift;

        % swap
        temp = image2;
        image2 = image1;
        image1 = temp;
    end

    h1 = size(image1, 1);
    w1 = size(image1, 2);
    h2 = size(image2, 1);
    w2 = size(image2, 2);

    rxdim = max(w1, xshift + w2);
    rydim = max(h2, h1) + 2 * abs(yshift);

    ybase = int32(abs(ceil(yshift)));
    xbase = 0;
    newImg = double(zeros(ybase+int32(rydim), xbase+int32(rxdim),3));

    %Assign the first image
    for y = 1 : h1
        for x = 1 : w1
            newImg(y+ybase,x+xbase,:) = double(image1(y,x,:));
        end
    end


    %imshow(newImg)

    xboundary = xbase + size(image1,2);
    %yboundary = ybase + size(image1,1);
    w = 0.5;
    %Blend the second image

    overlap_width = xboundary-xshift;

    for y = 1 : h2
        for x = 1 : w2
            nx = int32(x + xshift + xbase);
            ny = int32(y + yshift + ybase);
            %check whether it is overlap
            if nx < xboundary
                w = 1-double(nx-xshift)/double(overlap_width);
                newImg(ny,nx,:) = w*newImg(ny,nx,:)...
                    + (1-w)*double(image2(y,x,:));
            else
                newImg(ny,nx,:) = double(image2(y,x,:));
            end  
        end
    end
    newImg = uint8(newImg);
    %imshow(newImg)
end
