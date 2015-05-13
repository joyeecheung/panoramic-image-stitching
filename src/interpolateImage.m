function [ combinedImage ] = interpolateImage(combinedImage)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%Linear interpolation
newNumRows = size(combinedImage,1);
newNumCols = size(combinedImage,2);

midCols = round(newNumCols / 2);
for j = midCols : -1 : 3
    midRows = round(newNumRows / 2);
    for i = midRows:-1:3
        if (isequal(combinedImage(i,j,:),zeros(1,1,3)))
            combinedImage(i,j,:) = (double(combinedImage(i + 2,j,:)) + ...
                double(combinedImage( i - 2,j,:)) + double(combinedImage(i,j + 2,:)) + ...
                double(combinedImage(i, j - 2,:))) / 4.0;
        end
    end
    for i = midRows:newNumRows - 3
        if (isequal(combinedImage(i,j,:),zeros(1,1,3)))
            combinedImage(i,j,:) = (double(combinedImage(i + 2,j,:)) + ...
                double(combinedImage( i - 2,j,:)) + double(combinedImage(i,j + 2,:)) + ...
                double(combinedImage(i, j - 2,:))) / 4.0;
        end
    end
end

for j = midCols : newNumCols - 3
    midRows = round(newNumRows / 2);
    for i = midRows:-1:3
        if (isequal(combinedImage(i,j,:),zeros(1,1,3)))
            combinedImage(i,j,:) = (double(combinedImage(i + 2,j,:)) + ...
                double(combinedImage( i - 2,j,:)) + double(combinedImage(i,j + 2,:)) + ...
                double(combinedImage(i, j - 2,:))) / 4.0;
        end
    end
    for i = midRows:newNumRows - 3
        if (isequal(combinedImage(i,j,:),zeros(1,1,3)))
            combinedImage(i,j,:) = (double(combinedImage(i + 2,j,:)) + ...
                double(combinedImage( i - 2,j,:)) + double(combinedImage(i,j + 2,:)) + ...
                double(combinedImage(i, j - 2,:))) / 4.0;
        end
    end
end

end
