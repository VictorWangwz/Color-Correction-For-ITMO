%Calculate deltaE of 2 imgs in LAB
%By Zhen
function deltaE=calculateDeltaE(img1,img2)
%img1, img2 are in LAB color space
deltaE=sqrt(sum((img1(:) - double(img2(:))) .^ 2));
end