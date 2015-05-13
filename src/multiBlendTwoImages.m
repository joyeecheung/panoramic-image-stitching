%MultiBand two images together
%Based on http://www.cs.bath.ac.uk/brown/papers/iccv2003.pdf
%Input: image1, image2 - two images
%       xshift, yshift - x and y shift
%Output: newImg - result image


function newImg = multiBlendTwoImages(image1, image2, xshift, yshift)
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
newImg = double(zeros(int32(rydim), xbase+int32(rxdim),3));

%Assign the first image
for y = 1 : size(image1,1)
    for x = 1 : size(image1,2)
        newImg(y+ybase,x+xbase,:) = double(image1(y,x,:));
    end
end
xboundary = xbase + size(image1,2);

%Get the overlap region
minY = 1;
while sum(image2(int32(minY),1,:) == 0) == 3
    minY = minY +1;
end
    
maxY = size(image2,1);
while sum(image2(int32(maxY),1,:) == 0) == 3 || sum(newImg(int32(maxY+ybase+yshift),1,:) == 0) == 3
    maxY = maxY - 1;
end
minnY = max(1,ybase+yshift);  
maxnY = min(size(newImg,1),minnY + maxY - minY);

minnX = xshift;
maxnX = xboundary;
minX = 1;
maxX = xboundary-xshift;

maskb = zeros(size(image2,1),size(image2,2));

for y = 1 : size(image2,1)
    for x = 1 : size(image2,2)
        nx = floor(x + xshift+xbase);
        ny = floor(y + yshift+ybase);
        %check whether it is overlap
        if nx < xboundary || sum(newImg(ny,nx,:) == 0) == 0
            maskb(y,x) = 1;
        else
            newImg(ny,nx,:) = double(image2(y,x,:));
        end  
    end
end

yi = [minnY, maxnY];
xi = [minnX, maxnX];
%{
imshow(uint8(newImg));
hold on;
rectangle('Position', [minnX, minnY, maxnX-minnX, maxnY-minnY],'LineWidth',2, 'EdgeColor','b');
figure;
return;
%}
im2 = newImg;
im1 = image2;


im1 = imcrop(im1, [minX, minY, maxX-minX, maxY-minY]);
mk = maskb(minY:maxY,minX:maxX);
im1 = imresize(im1, [max(yi)-min(yi)+1, max(xi)-min(xi)+1]);

im1t = cat(3, ones(size(im2(:,:,1))) * mean(mean(im1(:,:,1))),...
              ones(size(im2(:,:,1))) * mean(mean(im1(:,:,2))),...
              ones(size(im2(:,:,1))) * mean(mean(im1(:,:,3))));    
im1t(min(yi):max(yi), min(xi):max(xi),:) = im1;



im1_size = size(im1);
im1 = im1t;  
mk = imresize(mk, [max(yi)-min(yi)+1, max(xi)-min(xi)+1], 'bilinear');
mask = zeros(size(im2));
mask(min(yi):max(yi), min(xi):max(xi),1) = mk;
mask(min(yi):max(yi), min(xi):max(xi),2) = mk;
mask(min(yi):max(yi), min(xi):max(xi),3) = mk;

im1p{1} = im1;
im2p{1} = im2;
mp{1} = im2double(mask);

M = floor(log2(max(im1_size)));

for n = 2 : M
    im1p{n} = imresize(im1p{n-1}, 0.5);
    im2p{n} = imresize(im2p{n-1}, 0.5);
    mp{n} = imresize(mp{n-1}, 0.5, 'bilinear');
end

for n = 1 : M-1
    im1p{n} = im1p{n} - imresize(im1p{n+1}, [size(im1p{n},1), size(im1p{n},2)]);
    im2p{n} = im2p{n} - imresize(im2p{n+1}, [size(im2p{n},1), size(im2p{n},2)]);   
end   
 
for n = 1 : M
    imp{n} = im1p{n} .* mp{n} + im2p{n} .* (1-mp{n});
end

im = imp{M};
for n = M-1 : -1 : 1
    im = imp{n} + imresize(im, [size(imp{n},1) size(imp{n},2)]);
end


newImg = uint8(im);

end
