% set up sift feature toolbox
VLFEATROOT = '../vlfeat-0.9.20';
run(strcat(VLFEATROOT,'/toolbox/vl_setup'))

% read images
dataDir = '../data/testingImages/';
files = dir(strcat(dataDir, '*.jpg'));

disp('Start reading images');
images = readImages(files, dataDir);
disp('Finish reading images');

% focal length in pixels = (image largest dimension in pixels)
%                          * (focal length in mm) / (sensor width in mm)
f = size(images, 2) * 8.2 / 7.11;
% radial distortion constants
k1 = -0.17;
k2 = 0.2;
fprintf('f = %f, k1 = %f, k2 = %f\n', f, k1, k2);

disp('Cylindrical projection starts');
projectedImages = cylindricalProjection(images, f, k1, k2);
disp('Cylindrical projection ends');

disp('Image cropping starts');
croppedImages = cropAll(projectedImages);
disp('Image cropping ends');

disp('Image stiching starts');
finalImage = stitch(croppedImages);
disp('Image stiching ends');

imshow(finalImage);
imwrite(finalImage, '../result/final.jpg')
