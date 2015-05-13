function imgo = pyramidBlend(imga, imgb, maska)
%imga = im2double(imread('../testImg/img3.jpg'));
%imgb = im2double(imread('../testImg/img4.jpg')); % size(imga) = size(imgb)
%imga = imresize(imga,[size(imgb,1) size(imgb,2)]);
[M N ~] = size(imga);

level = 5;
limga = generatePyramid(imga,'lap',level); % the Laplacian pyramid
limgb = generatePyramid(imgb,'lap',level);

%maska = zeros(size(imga));
%maska(:,1:v,:) = 1;
maskb = 1-maska;
gaussian = fspecial('gauss',10,5); % feather the border
maska = imfilter(maska,gaussian,'replicate'); 
maskb = imfilter(maskb,gaussian,'replicate');
%imshow(maskb)
%imshow(maskb)

limgo = cell(1,level); % the blended pyramid
for p = 1:level
	[Mp Np ~] = size(limga{p});
	maskap = imresize(maska,[Mp Np]);
	maskbp = imresize(maskb,[Mp Np]);
	limgo{p} = limga{p}.*maskap + limgb{p}.*maskbp;
end
imgo = pyramidReconstruct(limgo);
%figure,imshow(imgo) % blend by pyramid
%imgo1 = maska.*imga+maskb.*imgb;
%figure,imshow(imgo1) % blend by feathering
end