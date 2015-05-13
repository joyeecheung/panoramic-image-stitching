function [ imgout ] = pyramidExpand( img )

kw = 5; 
cw = .375; 
ker1d = [.25-cw/2 .25 cw .25 .25-cw/2];
kernel = kron(ker1d,ker1d')*4;

ker00 = kernel(1:2:kw,1:2:kw); % 3*3
ker01 = kernel(1:2:kw,2:2:kw); % 3*2
ker10 = kernel(2:2:kw,1:2:kw); % 2*3
ker11 = kernel(2:2:kw,2:2:kw); % 2*2

img = im2double(img);
sz = size(img(:,:,1));
osz = sz*2-1;
imgout = zeros(osz(1),osz(2),size(img,3));

for p = 1:size(img,3)
	img1 = img(:,:,p);
	img1ph = padarray(img1,[0 1],'replicate','both'); 
	img1pv = padarray(img1,[1 0],'replicate','both'); 
	
	img00 = imfilter(img1,ker00,'replicate','same');
	img01 = conv2(img1pv,ker01,'valid'); 
	img10 = conv2(img1ph,ker10,'valid');
	img11 = conv2(img1,ker11,'valid');
	
	imgout(1:2:osz(1),1:2:osz(2),p) = img00;
	imgout(2:2:osz(1),1:2:osz(2),p) = img10;
	imgout(1:2:osz(1),2:2:osz(2),p) = img01;
	imgout(2:2:osz(1),2:2:osz(2),p) = img11;
end

end