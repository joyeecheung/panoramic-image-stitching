function cropImg = cropOneImage(image)
    leftMargin = 0;
    blackCnt = size(image,1);
    while blackCnt == size(image,1)
        leftMargin = leftMargin + 1;
        blackCnt = 0;
        for j = 1 : size(image,1)
            if sum(image(j,int32(leftMargin),:) ==0) == 3
                blackCnt = blackCnt + 1;
            end
        end
    end
    rightMargin = size(image,2) + 1;
    blackCnt = size(image,1);
    while blackCnt == size(image,1)
        rightMargin = rightMargin - 1;
        blackCnt = 0;
        for j = 1 : size(image,1)
            if sum(image(j,int32(rightMargin),:) ==0) == 3
                blackCnt = blackCnt + 1;
            end
        end
    end
    
    topMargin = 1;
    while sum(image(int32(topMargin),leftMargin+1,:) == 0) == 3 || ...
        sum(image(int32(topMargin),rightMargin-1,:) == 0) == 3
        topMargin = topMargin +1;
    end
    
    bottomMargin = size(image,1);
    while sum(image(int32(topMargin),leftMargin+1,:) == 0) == 3 || ...
        sum(image(int32(topMargin),rightMargin-1,:) == 0) == 3
        bottomMargin = bottomMargin - 1;
    end
    cropImg = imcrop(image,[leftMargin topMargin rightMargin-leftMargin bottomMargin-topMargin]);
end