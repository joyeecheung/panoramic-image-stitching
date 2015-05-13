function ECTest(imageName)
    image = imread(imageName);
    lumMap =  0.2125 * image(:,:,1) + 0.7154 * image(:,:,2) + 0.0721 * image(:,:,3);
    aveLum = calcAveLum(lumMap)
    figure
    subplot(2, 2, 1);
    imhist(lumMap)
    subplot(2, 2, 2);
    imshow(image);
    subplot(2, 2, 3);
    image2 = updateImage(image, 120, aveLum);
    lumMap2 =  0.2125 * image2(:,:,1) + 0.7154 * image2(:,:,2) + 0.0721 * image2(:,:,3);
    imhist(lumMap2);
    subplot(2, 2, 4);
    imshow(image2);
    aveLum = calcAveLum(lumMap2)
end

function aveLum = calcAveLum(lumMap)
    height = size(lumMap, 1);
    width = size(lumMap, 2);
    sumAll = 0;
    sumWhite = 0;
    sumBlack = 0;
    countWhite = 0;
    countBlack = 0;
    for i = 1 : height
        for j = 1 : width
            sumAll = sumAll + double(lumMap(i, j));
            if(lumMap(i, j) > 200)
                sumWhite = sumWhite + double(lumMap(i, j));
                countWhite = countWhite + 1;
            end
%             if(lumMap(i, j) < 20)
%                 sumBlack = sumBlack + double(lumMap(i, j));
%                 countBlack = countBlack + 1;
%             end
        end
    end

    aveLum = (sumAll - sumWhite - sumBlack) / (height * width - countWhite - countBlack);
end

function image2 = updateImage(image, interLum, curLum)
    height = size(image, 1);
    width = size(image, 2);
    for i = 1 : height
        for j = 1 : width
            %if(interLum > curLum)
                for k = 1 : 3
                    image(i, j, k) = double(image(i, j, k)) * double(90) / double(curLum);
                    if(image(i, j, k) > 255)
                        image(i, j, k) = 255;
                    end
                end
            %end
        end
    end
    image2 = uint8(image);
end