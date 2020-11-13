function [ ~ ] = findWithSIFT( mainImageStr, croppedImageStr)
num = 15;       % Number of matches to be found

mainImage = imread(mainImageStr);
croppedImage = imread(croppedImageStr);

[s_width,s_height,~] = size(croppedImage);

% Perfrom SIFT
[dstImg0, descpt0, locs0] = sift(mainImage, num);
[dstImg1, descpt1, locs1] = sift(croppedImage); %same in for loop

% Display the features
showkeys(dstImg0, locs0);
showkeys(dstImg1, locs1);

% Match the SIFT descriptor accross two images
[isMatched, index1, index2] = SIFTmatch(descpt0, descpt1, num);

% Draw the matched features
figure;
showMatchedFeatures(dstImg0, dstImg1, ...
    locs0(index1, [2 1]), locs1(index2, [2 1]), 'montage');
	        
end