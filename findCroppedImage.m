function [ rect ] = findCroppedImage( mainImage, croppedImage, isRotated)
% TODO : Reduce false alarm using adaptive thresholdValue and also look for
% neighhbour pixel of center one. Then reduce false alarm scenes.

% rect = [xmin ymin width height]
% mainImage = The filename of The Star Map
% croppedImage = The filename of cropped image from the star map
img = imread(mainImage);
small_img = imread(croppedImage);

if isRotated == true
    thresholdValue1 = 0.1;
    thresholdValue2 = 0.31;
else
    thresholdValue1 = 0.1;
    thresholdValue2 = 0.1;
end

offsetX = 2;
offsetY = 2;

[s_width,s_height,~] = size(small_img);

img_gray = rgb2gray(img);
small_img_gray = rgb2gray(small_img);
small_img_gray_corrected = small_img_gray(1+offsetY:s_height-offsetY,1+offsetX:s_width-offsetX);
img_bw = im2bw(img_gray, thresholdValue1);
small_img_bw = im2bw(small_img_gray_corrected, thresholdValue2);


for i=360:-1:1
    small_rotated_img_bw = imrotate(small_img_bw, i);
   
    erodedImg=imerode(img_bw,small_rotated_img_bw);
    [row,col] = find(erodedImg==1);
    if ~isempty(row)    
        rect = [col(1)+1 - s_height/2, row(1)+1 - s_width/2, s_width-1, s_height-1];
        crop_img = imcrop(img_gray, rect);
        %crop_rotate_img2 = imrotate(crop_img2, -31);
        matching_ratio = sum(sum(small_img_gray & crop_img)) / (s_width * s_height) * 100;
        display(['Theta is : ', num2str(i)])
        display(['Matching ratio is : ', num2str(matching_ratio)])
        imshow(crop_img)
        break;
    end 
end

end

