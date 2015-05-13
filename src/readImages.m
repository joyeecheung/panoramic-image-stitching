%% Read image files under a directory and return them as an array
%  input:   files - filenames
%         dataDir - directory under which the files reside
%  output:  images - A m * n * 3 * x array containing x images
function images = readImages(files, dataDir)
    len = length(files);
    imagesSize = size(imread(strcat(dataDir, files(1).name)));

    images = zeros([imagesSize len]);
    for i = 1 : len
        images(:, :, :, i) = imread(strcat(dataDir, files(i).name));
    end

    images = uint8(images);
end