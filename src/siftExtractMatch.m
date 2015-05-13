%Extract sift features and do the matching
%Input: Ia, Ib - two images
%Output: match - p-by-5 matrix. each row is a pair math
%                [x1, y1, x2, y2, score]
function [match] = siftExtractMatch(Ia, Ib)
    Ia = single(rgb2gray(Ia));
    Ib = single(rgb2gray(Ib));
    [fa,da] = vl_sift(Ia);
    [fb,db] = vl_sift(Ib);
    
    [matchIndex, scores] = vl_ubcmatch(da, db);
    match(:,1) = fa(1,matchIndex(1,:));
    match(:,2) = fa(2,matchIndex(1,:));
    match(:,3) = fb(1,matchIndex(2,:));
    match(:,4) = fb(2,matchIndex(2,:));    
    match(:,5) = scores;
end