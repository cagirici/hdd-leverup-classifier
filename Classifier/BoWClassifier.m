rootFolder = fullfile('dataset', '');
testrootFolder = fullfile('6028', '');
categories = {'pos', 'neg'};
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
imdstest = imageDatastore(fullfile(testrootFolder, categories), 'LabelSource', 'foldernames');
tbl = countEachLabel(imds);

minSetCount = min(tbl{:,2}); % determine the smallest amount of images in a category

% Use splitEachLabel method to trim the set.
imds = splitEachLabel(imds, minSetCount, 'randomize');

% Notice that each set now has exactly the same number of images.
countEachLabel(imds)
[trainingSet, validationSet] = splitEachLabel(imds, 0.5, 'randomize');

% Find the first instance of an image for each category
pos= find(trainingSet.Labels == 'pos', 1);
neg = find(trainingSet.Labels == 'neg', 1);

% figure

subplot(1,2,1);
imshow(readimage(trainingSet,pos))
subplot(1,2,2);
imshow(readimage(trainingSet,neg))

bag = bagOfFeatures(trainingSet,'VocabularySize',1000);
img = readimage(imds, 1);
% Plot the histogram of visual word occurrences
figure
title('Visual word occurrences')
xlabel('Visual word index')
ylabel('Frequency of occurrence')

categoryClassifier = trainImageCategoryClassifier(trainingSet, bag);
confMatrix = evaluate(categoryClassifier, trainingSet);
confMatrix = evaluate(categoryClassifier, validationSet);

