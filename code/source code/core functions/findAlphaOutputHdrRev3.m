%function [imgOut,alphaOut]= findAlphaOutputHdr( imageSDR,imageHDR,startVal,endVal,stepVal)
function [alphaOut,deltaE_min,alpha,deltaE,imgOut] = findAlphaOutputHdr( imageSDR,imageHDR,startVal,endVal,stepVal)
%this function takes SDR images and HDR images and find 
%returns rgb values alpha values with the least deltaE value
%        By Benny, Liming and Zhen
%        Input:
%           -imageSDR: input SDR image from imread
%           -imageHDR: input HDR image from hdrread
%           -startVal: alpha value to start testing
%           -endVal: alpha value to end testing
%           -stepSize: step size of alpha value
%
%        Output:
%           -imgOut: hdr image in rgb colour space to be used with imwrite
%           or hdrwrite
%
%create test values
alpha=[startVal:stepVal:endVal];
deltaE=[];
%normalize and convert HDR image to Lab Colour space
imgHDR_double= (double(imageHDR)-0.005)./(4000-0.0005);
imgHDR_XYZ = rgb2xyz(imgHDR_double);
L_HDR_XYZ=max(max(imgHDR_XYZ(:,:,2)));
imgHDR_LAB= xyz2lab(imgHDR_XYZ);
%normalize, remove gamma, and convert SDR image to Lab Colour space
imgSDR_double= double(imageSDR)./255;
imgSDR_GammaRemoved = imgSDR_double.^2.2;
imgSDR_XYZ = rgb2xyz(imgSDR_GammaRemoved );
L_SDR_XYZ=max(max(imgSDR_XYZ(:,:,2)));
imgSDR_LAB= xyz2lab(imgSDR_XYZ);
%extract Luminance L from SDR image
L_SDR=imgSDR_LAB(:,:,1);
L_SDR_max=max(max(L_SDR));
%extract chrominance a from SDR image
A_SDR=imgSDR_LAB(:,:,2);
%extract chrominance b from SDR image
B_SDR=imgSDR_LAB(:,:,3);
%extract Luminance L from HDR image
L_HDR=imgHDR_LAB(:,:,1);
L_HDR_max=max(max(L_HDR));
%extract chrominance a from HDR image
A_HDR=imgHDR_LAB(:,:,2);
%extract chrominance b from HDR image
B_HDR=imgHDR_LAB(:,:,3);
%scale L_HDR and L_SDR into [0,1]
L_HDR_norm=L_HDR./100;
L_SDR_norm=L_SDR./100;
L_SDR_norm(find(L_SDR_norm==0))=0.001;
%calculate the ratio with luminance of HDRI and SDRI
LRatio=L_HDR_norm./L_SDR_norm;
ratio_max=max(max(LRatio));
%testing with all alpha values
for i=1:((endVal-startVal)/stepVal+1)
    imgHDR_LAB(:,:,2)= A_SDR .*LRatio*alpha(i);
    imgHDR_LAB(:,:,3)= B_SDR .*LRatio*alpha(i);
    %imgHDR_LAB(:,:,2)= A_HDR .*alpha(i);
    %imgHDR_LAB(:,:,3)= B_HDR .*alpha(i);
    deltaE(i)=sqrt(sum((imgHDR_LAB(:) - double(imgSDR_LAB(:))) .^ 2));
end
%find alpha value that results in the min deltaE value
deltaE_min=min(deltaE);
alphaOut=alpha(find(min(deltaE)==deltaE));
%scale the the a & b of SDR image with the alpha value
imgHDR_LAB(:,:,2)= A_SDR .*LRatio *alphaOut(1);
imgHDR_LAB(:,:,3)= B_SDR .*LRatio *alphaOut(1);
%convert img from Lab to RGB
imgOutNormalized=lab2rgb(imgHDR_LAB);
imgOutNormalized(imgOutNormalized<0)=0;
%scale to range 0.005 to 4000
imgOut=imgOutNormalized*(4000-0.005)+0.005;
%imgOut(:,:,1)=imageHDR(:,:,1);

end

