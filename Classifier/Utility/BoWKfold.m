categories = {'pos', 'neg'};
confMatrix{10}=0;
confMatrix2{10}=0;
confMatrix3{10}=0;
categoryClassifier{10}=0;
bag{10}=0;
for i=1:10
    foldernames{18}='';
    counter=1;
    for j=1:10
        if i~=j
            foldername1=strcat('hdds\',num2str(j),'\pos');
            foldername2=strcat('hdds\',num2str(j),'\neg');
            foldernames{2*(counter-1)+1}=foldername1;
            foldernames{2*(counter-1)+2}=foldername2;
            counter=counter+1;
        end
    end
    imds = imageDatastore(foldernames, 'LabelSource', 'foldernames');
    testrootFolder = fullfile('hdds', num2str(i));
    imdstest = imageDatastore(fullfile(testrootFolder, categories), 'LabelSource', 'foldernames');
    
    tbl = countEachLabel(imds);

    minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category

    % Use splitEachLabel method to trim the set.
    imds = splitEachLabel(imds, minSetCount, 'randomize');

    % Notice that each set now has exactly the same number of images.
    countEachLabel(imds)
    [trainingSet, validationSet] = splitEachLabel(imds, 0.7, 'randomize');

    % Find the first instance of an image for each category
    pos= find(trainingSet.Labels == 'pos', 1);
    neg = find(trainingSet.Labels == 'neg', 1);


    bag{i} = bagOfFeatures(trainingSet,'VocabularySize',500);
    % Plot the histogram of visual word occurrences

    categoryClassifier{i} = trainImageCategoryClassifier(trainingSet, bag{i});
    confMatrix{i} = evaluate(categoryClassifier{i}, trainingSet);
    confMatrix2{i} = evaluate(categoryClassifier{i}, validationSet);
    confMatrix3{i} = evaluate(categoryClassifier{i}, imdstest);
end

save bag;
save confMatrix;
save confMatrix2;
save confMatrix3;
save categoryClassifier;