load lines
for i=1:10
    img = imread(strcat(num2str(i),'.JPG'));
    figure;
    imshow(img);
    %% input
    x=zeros(size(lines(i).pos.x1,1)*2,1);
    y=zeros(size(lines(i).pos.x1,1)*2,1);
    x(1:2:end) = lines(i).pos.x1;
    x(2:2:end) = lines(i).pos.x2;
    y(1:2:end) = lines(i).pos.y1;
    y(2:2:end) = lines(i).pos.y2;

    %% Line Draw
    RGB = insertShape(img,'Line',[x(1:2:end) y(1:2:end) x(2:2:end) y(2:2:end) ],'LineWidth',30,'color','green');
    RGB = insertShape(RGB,'Line', ...
        [(x(1:2:end)+x(2:2:end))/2 (y(1:2:end)+y(2:2:end))/2 ...
         (x(1:2:end)+x(2:2:end))/2-lines(i).pos.anglesx*100  ...
         (y(1:2:end)+y(2:2:end))/2-lines(i).pos.anglesy*100 ], ...
         'LineWidth',20,'color','green');
    imshow(RGB)
    %% Create Struct
    x=zeros(size(lines(i).neg.x1,1)*2,1);
    y=zeros(size(lines(i).neg.x1,1)*2,1);
    x(1:2:end) = lines(i).neg.x1;
    x(2:2:end) = lines(i).neg.x2;
    y(1:2:end) = lines(i).neg.y1;
    y(2:2:end) = lines(i).neg.y2;
    RGB = insertShape(RGB,'Line',[x(1:2:end) y(1:2:end) x(2:2:end) y(2:2:end) ],'LineWidth',30,'color','red');
    imshow(RGB)
end