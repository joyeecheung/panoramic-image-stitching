%Stich two images together
%Input: image1, image2 - two images
%       xshift, yshift - x and y shift
%Output: newImg - result image
function blendedImg = ECPyramidBlending(image1, image2, xshift, yshift)

%ensure we have image1 and image2 while xshift > 0
if xshift < 0
    xshift = -xshift;
    yshift = -yshift;
    temp = image2;
    image2 = image1;
    image1 = temp;
end

rxdim = max(size(image1,2), xshift + size(image2,2));
rydim = max(size(image2,1),size(image1,1))+2*abs(yshift);

ybase = int32(abs(ceil(yshift)));
xbase = 0;
newImage1 = double(zeros(ybase+int32(rydim), xbase+int32(rxdim),3));
newImage2 = double(zeros(ybase+int32(rydim), xbase+int32(rxdim),3));
maska = double(zeros(ybase+int32(rydim), xbase+int32(rxdim),3));
maskb = double(zeros(ybase+int32(rydim), xbase+int32(rxdim),3));

%Assign the first image
for y = 1 : size(image1,1)
    for x = 1 : size(image1,2)
        newImage1(y+ybase,x+xbase,:) = double(image1(y,x,:));
        sum = image1(y, x, 1) + image1(y, x, 2) + image1(y, x, 3);
        %maska(y + ybase, x + xbase, :) = 1;
        if(sum == 0) 
            maska(y + ybase, x + xbase, :) = 0;
        else 
            maska(y + ybase, x + xbase, :) = 1;
        end
    end
end

%imshow(maska)
for y = 1 : size(image2,1)
    for x = 1 : size(image2,2)
        newImage2(y + ybase + yshift,x + xbase + xshift,:) = double(image2(y,x,:));
        %maskb(y + ybase + yshift,x + xbase + xshift,:) = 1;
        sum = image2(y, x, 1) + image2(y, x, 2) + image2(y, x, 3);
        if(sum == 0) 
            maskb(y + ybase + yshift,x + xbase + xshift, :) = 0;
        else 
            maskb(y + ybase + yshift,x + xbase + xshift, :) = 1;
        end
    end
end
newImage1 = uint8(newImage1);
newImage2 = uint8(newImage2);

blendedImg = pyramidBlend(newImage1, newImage2, maska);
height = size(blendedImg, 1);
width = size(blendedImg, 2);
for i = 1 : height
    for j = 1 : width
        for k = 1 : 3
        blendedImg(i, j, k) = blendedImg(i, j, k) * 255;
        end
    end
end
blendedImg = uint8(blendedImg);
%imshow(blendedImg)

end
