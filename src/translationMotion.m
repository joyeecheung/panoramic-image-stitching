% Get the translation motion
% Input: image1, image2 - two images
% Output: Use RANSAC algorithm to get the best homograph translation
function [best_xshift, best_yshift]=translationMotion(image1, image2)

%Get matched sift pairs 
match = siftExtractMatch(image1, image2);
%Calculate max iterations
MAX_ITERATION = size(match,1);

epsilon = 1;
best_count = 0;
best_xshift = 0;
best_yshift = 0;

sampleIndex = randperm(size(match,1),MAX_ITERATION);

for k=1:length(sampleIndex)
    sample = sampleIndex(k);    
    deltaX = match(sample, 3) - match(sample, 1);
    deltaY = match(sample, 4) - match(sample, 2);
    currentCount = 0;
    %calculate ssd
    for i = 1:size(match, 1)
        xnew = match(i,1)+deltaX;
        ynew = match(i,2)+deltaY;
        
        ssd = sqrt((match(i, 3) - xnew)^2 + (match(i, 4) - ynew)^2);
        if ssd < epsilon
            currentCount = currentCount + 1;
        end
    end
    %update best result
    if currentCount > best_count
        best_count = currentCount;
        best_xshift = -deltaX;
        best_yshift = -deltaY;
    end
end
best_xshift = ceil(best_xshift);
best_yshift = ceil(best_yshift);
end