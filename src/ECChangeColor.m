function curImage = ECChangeColor(curImage, prevImage, nextImage)

RATIO = [0.0, 0.0, 1.0]; % curImage, minLumImage, maxLumImage

curLumMap =  0.2125 * curImage(:,:,1) + 0.7154 * curImage(:,:,2) + 0.0721 * curImage(:,:,3);
prevLumMap =  0.2125 * prevImage(:,:,1) + 0.7154 * prevImage(:,:,2) + 0.0721 * prevImage(:,:,3);
nextLumMap =  0.2125 * nextImage(:,:,1) + 0.7154 * nextImage(:,:,2) + 0.0721 * nextImage(:,:,3);

curAveLum = calcAveLum(curLumMap);
prevAveLum = calcAveLum(prevLumMap);
nextAveLum = calcAveLum(nextLumMap);
if(prevAveLum > nextAveLum) 
    temp = prevAveLum;
    prevAveLum = nextAveLum;
    nextAveLum = temp;
end

aveLumArray = [curAveLum, prevAveLum, nextAveLum]
interpolatedLum = 0;
for i = 1 : 3
    interpolatedLum = interpolatedLum + RATIO(i) * double(aveLumArray(i));
end

interpolatedLum
curImage = updateImage(curImage, interpolatedLum, curAveLum);
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
            if(lumMap(i, j) > 60)
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

function image = updateImage(image, interLum, curLum)
    height = size(image, 1);
    width = size(image, 2);
    for i = 1 : height
        for j = 1 : width
            if(interLum > curLum)
                for k = 1 : 3
                    image(i, j, k) = double(image(i, j, k)) * double(120) / double(curLum);
                    if(image(i, j, k) > 255)
                        image(i, j, k) = 255;
                    end
                end
            end
        end
    end
    image = uint8(image);
end
