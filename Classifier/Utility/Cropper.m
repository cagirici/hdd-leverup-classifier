load lines
counter=1;
figure
for i=1:10
    img = imread(strcat(num2str(i),'.JPG')); 
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
            for l=1:4
                imwrite(imCropped ,strcat('hdds\',num2str(i),'\pos\',num2str(counter),'.jpg'));
                counter=counter+1;
                imCropped=imrotate(imCropped,90);
            end
            RGB = insertShape(RGB,'rectangle', ...
            [lines(i).pos.x1(j)-k*distToMoveX-100 lines(i).pos.y1(j)-k*distToMoveY-100 200  200],'Color','green','LineWidth',20);
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
            for l=1:4
                imwrite(imCropped ,strcat('hdds\',num2str(i),'\neg\',num2str(counter),'.jpg'));
                counter=counter+1;
                imCropped=imrotate(imCropped,90);
            end
            RGB = insertShape(RGB,'rectangle', ...
            [lines(i).neg.x1(j)-k*distToMoveX-100 lines(i).neg.y1(j)-k*distToMoveY-100 200  200],'Color','red','LineWidth',20);
        end
    end
    imshow(RGB);
end
