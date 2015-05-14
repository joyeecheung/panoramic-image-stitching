%% Blend two images together
%  input:   Ia - A m * n * 3 array
%           Ib - A m * n * 3 array
%           xshift - shift of x coordinate
%           yshift - shift of y coordinate
%  output:  result - The blended image
function result = blendTwo(Ia, Ib, xshift, yshift)
    % make sure Ia and Ib are good when xshift > 0
    if xshift < 0
        xshift = -xshift;
        yshift = -yshift;

        % swap
        temp = Ib;
        Ib = Ia;
        Ia = temp;
    end

    [h1, w1, dummy] = size(Ia);
    [h2, w2, dummy] = size(Ib);

    rxdim = max(w1, xshift + w2);
    rydim = max(h2, h1) + 2 * abs(yshift);
    ybase = int32(abs(ceil(yshift)));
    xbase = 0;

    result = double(zeros(ybase+int32(rydim), xbase+int32(rxdim), 3));

    % copy the first image over
    result(1+ybase:h1+ybase, 1+xbase:w1+xbase, :) = double(Ia(1:h1, 1:w1, :));

    xboundary = xbase + w1;
    w = 0.5;

    % blend in the second image
    overlapWidth = xboundary - xshift;

    for y = 1 : h2
        for x = 1 : w2
            i = int32(x + xshift + xbase);
            j = int32(y + yshift + ybase);
            % check whether it's overlapped
            if i < xboundary
                w = 1 - double(i - xshift) / double(overlapWidth);
                result(j, i, :) = w * result(j, i, :)...
                    + (1 - w) * double(Ib(y, x, :));
            else
                result(j, i, :) = double(Ib(y, x, :));
            end
        end
    end

    result = uint8(result);
end
