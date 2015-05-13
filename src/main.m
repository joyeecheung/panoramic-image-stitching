% set up sift feature toolbox
VLFEATROOT = '../vlfeat-0.9.20';
run(strcat(VLFEATROOT,'/toolbox/vl_setup'))

% read images
dirPath = '../data/testingImages/';
files = dir(strcat(dirPath,'*.jpg'));

disp('Start reading images');
images = readImages(files,dirPath);
disp('Finish reading images');

%f = 595;
%f = 660.8799;
%f = size(images, 1);
% focal length in pixels = (image largest dimension in pixels)
%                          * (focal length in mm) / (sensor width in mm)
f = size(images, 2) * 8.2 / 7.11;  % portrait layout -> image height
% radial distortion constants
k1 = -0.15;
k2 = 0;
fprintf('f = %f, k1 = %f, k2 = %f\n', f, k1, k2);
%k1 = -0.18533;
%k2 = 0.21517;
disp('Start cylindrical projection');
proj_images = cylindricalProjection(images, f, k1, k2);
disp('Finish cylindrical projection');

disp('Start cropping images');
crop_images = cropImages(proj_images);
disp('Finish cropping images');

disp('Start stiching images');
finalImage = stitch(crop_images);
disp('Finish stiching images');
imshow(finalImage);
imwrite(finalImage, '../result/final.jpg')
