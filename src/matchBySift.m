%% Extract features using SIFT and match
%  input:   Ia, Ib   - Two m * n * 3 array of the data in images
%  output:  matched  - [x1, y1, x2, y2, score]
function [matched] = matchBySift(Ia, Ib)
    Ia = single(rgb2gray(Ia));
    Ib = single(rgb2gray(Ib));
    [fa, da] = vl_sift(Ia);
    [fb, db] = vl_sift(Ib);
    
    [idx, score] = vl_ubcmatch(da, db);
    matched(:, 1) = fa(1, idx(1,:));
    matched(:, 2) = fa(2, idx(1,:));
    matched(:, 3) = fb(1, idx(2,:));
    matched(:, 4) = fb(2, idx(2,:));    
    matched(:, 5) = score;
end