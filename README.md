There are two methods for finding location a cropped image in this repository. Sample images exist in the 'images' folder.

Method I  : Extracting features cropped and main image by using SIFT, then matching these features. After that, find the homography matrix between two images.
Method II : Create a mask by using cropped image, then dilate the main images with it.
