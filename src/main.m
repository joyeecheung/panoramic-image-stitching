% set up sift feature toolbox
VLFEATROOT = '../vlfeat-0.9.20';
run(strcat(VLFEATROOT,'/toolbox/vl_setup'))
% read images
dirPath = '../data/test/';
files = dir(strcat(dirPath,'*.jpg'));

disp('Start reading images');
images = readImages(files,dirPath);
disp('Finish reading images');

%f = 595;
%f = 660.8799;
%f = size(images, 1);
f = 2000;
k1 = -0.18533;
k2 = 0.21517;
disp('Start cylindrical projection');
proj_images = cylindricalProjection(images,f,k1,k2);
disp('Finish cylindrical projection');

disp('Start cropping images');
crop_images = cropImages(proj_images);
disp('Finish cropping images');

disp('Start stiching images');
exposureCorrection = false;
finalImage = stitch(crop_images,1,exposureCorrection);
disp('Finish stiching images');
imwrite(finalImage, '../result/final.jpg')
