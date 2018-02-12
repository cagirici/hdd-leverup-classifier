load bag;
load lines;
load categoryClassifier;
for i=1:10
    img = imread(strcat(num2str(i),'.JPG')); 
    figure;
    imshow(img);
    RGB=img;
    %% pos dataset
    for j=1:size(lines(i).pos.x1,1)
        xdiff= abs(lines(i).pos.x1(j) - lines(i).pos.x2(j))/100;
        ydiff= abs(lines(i).pos.y1(j) - lines(i).pos.y2(j))/100;
        numofPoints= ceil(max(xdiff,ydiff)); 
        distToMoveX = (lines(i).pos.x1(j) - lines(i).pos.x2(j))/numofPoints;
        distToMoveY = (lines(i).pos.y1(j) - lines(i).pos.y2(j))/numofPoints;
        for k=1:numofPoints-1
            imCropped = imcrop(img,[lines(i).pos.x1(j)-k*distToMoveX-100, lines(i).pos.y1(j)-k*distToMoveY-100, 200 , 200]);
            category=predict(categoryClassifier{i},imCropped);
            colorOfRect = 'yellow';
            if category ==2
                colorOfRect='green';
            end
            RGB = insertShape(RGB,'rectangle', ...
            [lines(i).pos.x1(j)-k*distToMoveX-100 lines(i).pos.y1(j)-k*distToMoveY-100 200  200],'Color',colorOfRect,'LineWidth',30);
        end
    end
    %% neg dataset
    for j=1:size(lines(i).neg.x1,1)
        xdiff= abs(lines(i).neg.x1(j) - lines(i).neg.x2(j))/100;
        ydiff= abs(lines(i).neg.y1(j) - lines(i).neg.y2(j))/100;
        numofPoints= ceil(max(xdiff,ydiff)); 
        distToMoveX = (lines(i).neg.x1(j) - lines(i).neg.x2(j))/numofPoints;
        distToMoveY = (lines(i).neg.y1(j) - lines(i).neg.y2(j))/numofPoints;
        for k=1:numofPoints-1
            imCropped = imcrop(img,[lines(i).neg.x1(j)-k*distToMoveX-100, lines(i).neg.y1(j)-k*distToMoveY-100, 200 , 200]);
            category=predict(categoryClassifier{i},imCropped);
            colorOfRect = 'red';
            if category ==2
                colorOfRect='blue';
            end
            RGB = insertShape(RGB,'rectangle', ...
            [lines(i).neg.x1(j)-k*distToMoveX-100 lines(i).neg.y1(j)-k*distToMoveY-100 200  200],'Color',colorOfRect,'LineWidth',30);
        end
    end
    imshow(RGB);
end
