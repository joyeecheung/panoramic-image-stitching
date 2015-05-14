%% Use RANSAC to get the best homograph translation
%  input:   Ia, Ib   - Two m * n * 3 array of the data in images
%  output:  [xshift_best, yshift_best]
function [xshift_best, yshift_best] = voteForShift(Ia, Ib)
    % Get matched SIFT
    matched = matchBySift(Ia, Ib);
    len = size(matched, 1);
    ITER_MAX = size(matched, 1);

    xshift_best = 0;
    yshift_best = 0;
    count_best = 0;
    eps = 1;

    idx = randperm(len, ITER_MAX);

    for k = 1 : length(idx)
        sample = idx(k);    
        dx = matched(sample, 3) - matched(sample, 1);
        dy = matched(sample, 4) - matched(sample, 2);
        count_cur = 0;

        for i = 1:size(matched, 1)
            xi = matched(i, 1) + dx;
            yi = matched(i, 2) + dy;

            ssd = sqrt((matched(i, 3) - xi)^2 + (matched(i, 4) - yi)^2);
            if ssd < eps
                count_cur = count_cur + 1;
            end
        end

        % update
        if count_cur > count_best
            xshift_best = -dx;
            yshift_best = -dy;
            count_best = count_cur;
        end
    end

    xshift_best = ceil(xshift_best);
    yshift_best = ceil(yshift_best);
end