%% Stitch images together
%  input:   images       - A m * n * 3 * x array containing x images
%  output:  panorama     - The stitched panorama
%           yshift_total - total shift of y direction
function [panorama, yshift_total] = stitch(images)
    yshift_cur = 0;
    yshift_all = 0;
    len = size(images, 4);

    for i = 1 : len - 1
        fprintf('stitching image %d and %d\n', i, i + 1);

        Ia = images(:, :, :, i);
        Ib = images(:, :, :, i + 1);

        [xshift, yshift] = voteForShift(Ia, Ib);

        yshift_all = yshift_all + yshift;
        xshift_cur = xshift;
        yshift_cur = -yshift_cur + yshift;

        if i == 1
            blended = blendTwo(Ia, Ib, xshift_cur, yshift_cur);
        else
            blended = blendTwo(blended, Ib, xshift_cur, yshift_cur);
        end

        imwrite(blended, sprintf('../result/blended_%d.jpg', i));
    end

    panorama = blended;
    yshift_total = yshift_all;
end
