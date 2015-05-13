%Stich all images together
%Input: proj_images - input images
%       blendingType - 1: featering 2: Pyramid 3: multiBand
%Ouput: panormicImg
function finalImage = stitch(proj_images)
    curYshift = 0;
    yShiftSum = 0;
    for i = 1 : size(proj_images,4)-1
        disp(strcat('stitching image...',int2str(i)));
        Ia = proj_images(:,:,:,i);
        Ib = proj_images(:,:,:,i+1);
        [xshift, yshift] = translationMotion(Ia,Ib);
        yShiftSum = yShiftSum + yshift;
        curXshift = xshift;
        curYshift = -curYshift + yshift;
        if i == 1
            panoramicImg = featherTwoImages(Ia,Ib,curXshift,curYshift);
        else
            panoramicImg = featherTwoImages(panoramicImg,Ib,curXshift,curYshift);
        end
    end
    finalImage = panoramicImg;
    imwrite(finalImage,'../result/raw_stitched.jpg');
    finalImage = driftImage(panoramicImg, yShiftSum);
end

function finalImage = driftImage(inputImage, yShiftSum)
    disp('Remove drift');
    if(yShiftSum < 0)
        yShiftSum = -yShiftSum;
    end
    height = size(inputImage, 1) - yShiftSum*2 ;
    width = size(inputImage, 2);
    finalImage = zeros(height, width, 3);
    for i = 1 : height
        for j = 1 : width
            increment = (double(j) - 1 ) / (double(width) - 1) * yShiftSum*2;
            newHeightValue = uint32(i + increment);
            finalImage(i, j, :) = inputImage(newHeightValue, j, :);
        end
    end
    finalImage = uint8(cropOne(finalImage));
end
