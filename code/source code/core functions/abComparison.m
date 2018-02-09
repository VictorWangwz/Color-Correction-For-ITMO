%comparison of the bound of A and B
%By Zhen Wang
clc;
clear all;
iTMONum=1;
switch iTMONum
    case 1
       load alphaMap_AkyuzStep5.mat;
    case 2
        load alphaMap_Banterle.mat;
    case 3
        load alphaMap_Bist.mat;
    case 4
       load alphaMap_Akyuz.mat;
end
for i=1:1
    %original SDR image
imageSDR=imread(strcat('C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\image\',num2str(i),'.png'));
%HDR image after iTMO
switch iTMONum
    case 1
        imageHDR=Akyuz_iTMO( imageSDR , 4000 , 1 );%hdrread(strcat('C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes\Akyuz\AkyuzOutput100\AkyuzOutput',num2str(i),'.hdr'));
    case 2
        imageHDR=Banterle_iTMO( imageSDR );%hdrread(strcat('C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes\Akyuz\AkyuzOutput100\BanterleOutput',num2str(i),'.hdr'));
    case 3
        imageHDR=Bist_iTMO( imageSDR );%hdrread(strcat('C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes\Akyuz\AkyuzOutput100\BistOutput',num2str(i),'.hdr'));
    case 4
        imageHDR=Meylan_iTMO( imageSDR );%hdrread(strcat('C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes\Akyuz\AkyuzOutput100\BistOutput',num2str(i),'.hdr'));
end

imgOut= findsdrpixelsnew(imageSDR,imageHDR,alphaMap);

imgSDR_double= double(imageSDR)./255;
imgSDR_GammaRemoved = imgSDR_double.^2.2;
imgSDR_XYZ = rgb2xyz(imgSDR_GammaRemoved );
imgSDR_LAB= xyz2lab(imgSDR_XYZ);
a_SDR=imgSDR_LAB(:,:,2);
b_SDR=imgSDR_LAB(:,:,3);
[asdr_max,asdr_min]=findMaxMin(a_SDR);
[bsdr_max,bsdr_min]=findMaxMin(b_SDR);
pos=[asdr_max,asdr_min,asdr_min,asdr_max,asdr_max;bsdr_max,bsdr_max,bsdr_min,bsdr_min,bsdr_max];
%subplot(3,3,i);
figure(i)

plot(pos(1,:),pos(2,:));
text(-100,bsdr_max,num2str(bsdr_max));
text(-100,bsdr_min,num2str(bsdr_min));
text(asdr_max,-100,num2str(asdr_max));
text(asdr_min,-100,num2str(asdr_min));
axis([-100 100 -100 100])
hold on

imgHDR_double= (double(imageHDR)-0.005)./(4000-0.0005);
imgHDR_XYZ = rgb2xyz(imgHDR_double);
oriHDR_LAB= xyz2lab(imgHDR_XYZ);
a_oriHDR=oriHDR_LAB(:,:,2);
b_oriHDR=oriHDR_LAB(:,:,3);
[aohdr_max,aohdr_min]=findMaxMin(a_oriHDR);
[bohdr_max,bohdr_min]=findMaxMin(b_oriHDR);
pos1=[aohdr_max,aohdr_min,aohdr_min,aohdr_max,aohdr_max;bohdr_max,bohdr_max,bohdr_min,bohdr_min,bohdr_max];
plot(pos1(1,:),pos1(2,:),'r');
text(-100,bohdr_max,num2str(bohdr_max));
text(-100,bohdr_min,num2str(bohdr_min));
text(aohdr_max,-100,num2str(aohdr_max));
text(aohdr_min,-100,num2str(aohdr_min));
hold on

imgHDR_double= (double(imgOut)-0.005)./(4000-0.0005);
imgHDR_XYZ = rgb2xyz(imgHDR_double);
ccHDR_LAB= xyz2lab(imgHDR_XYZ);
a_ccHDR=ccHDR_LAB(:,:,2);
b_ccHDR=ccHDR_LAB(:,:,3);
[achdr_max,achdr_min]=findMaxMin(a_ccHDR);
[bchdr_max,bchdr_min]=findMaxMin(b_ccHDR);
pos2=[achdr_max,achdr_min,achdr_min,achdr_max,achdr_max;bchdr_max,bchdr_max,bchdr_min,bchdr_min,bchdr_max];
plot(pos2(1,:),pos2(2,:),'g');
text(100,bchdr_max,num2str(bchdr_max));
text(100,bchdr_min,num2str(bchdr_min));
text(achdr_max,100,num2str(achdr_max));
text(achdr_min,100,num2str(achdr_min));
legend('SDR','Original HDR','Color Corrected HDR');
title(strcat('Comparison of A & B for the image ',num2str(i),'.png'));

end