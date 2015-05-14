function main
    % set up vlfeat for SIFT
    VLFEATROOT = '../vlfeat-0.9.20';
    run(strcat(VLFEATROOT, '/toolbox/vl_setup'))

    % read images
    dataDir = '../data2/testingImages/';
    files = dir(strcat(dataDir, '*.jpg'));

    disp('Start reading images');
    images = readImages(files, dataDir);
    disp('Finish reading images');

    % focal length in pixels = (image width in pixels)
    %                          * (focal length in mm) / (sensor width in mm)
    f = size(images, 2) * 8.2 / 7.11;  % NIKON E990
    % radial distortion constants
    k1 = -0.18;
    k2 = 0.21;
    fprintf('f = %f, k1 = %f, k2 = %f\n', f, k1, k2);

    disp('Cylicndrical projection starts');
    projectedImages = cylindrical(images, f, k1, k2);
    disp('Cylindrical projection ends');

    disp('Image cropping starts');
    croppedImages = cropAll(projectedImages);
    disp('Image cropping ends');

    disp('Image stiching starts');
    [stitched, yshift_total] = stitch(croppedImages);
    disp('Image stiching ends');

    fprintf('yshift_total = %f\n', yshift_total);
    imwrite(stitched, '../result/stitched_raw.jpg')

    disp('Drift correcting starts');
    corrected = correctDrift(stitched, yshift_total);
    disp('Drift correcting ends');

    imshow(corrected);
    imwrite(corrected, '../result/final.jpg')
end