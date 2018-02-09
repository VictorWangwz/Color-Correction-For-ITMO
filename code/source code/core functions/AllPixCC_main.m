%main function for local alpha method
%By Zhen Wang. 
clc;
clear all;
tic;
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
%alphaMap(alphaMap==10)=1;
deltaE=zeros(2,7);%two rows represent deltaE of original HDR and color corrected HDR respectively

for i=1:7
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
%output after color correction
 imgOut= findsdrpixelsnew(imageSDR,imageHDR,alphaMap);
 %hdrwrite(imgOut,strcat('AllPixCCForiTMO',num2str(iTMONum),'Pic',num2str(i),'Step5.hdr'));
 %ImgHDR_Sim2 = Sim2ShaderTechnicolor(imgOut(:,:,1),imgOut(:,:,2),imgOut(:,:,3));
% imwrite(ImgHDR_Sim2,strcat('AllPixCCForiTMO',num2str(iTMONum),'Pic',num2str(i),'Step5.png'));

%calculate deltaE for original HDR and color corrected HDR
%1. transform rgb to lab for sdr, orig hdr and cc hdr
imgSDR_double= double(imageSDR)./255;
imgSDR_GammaRemoved = imgSDR_double.^2.2;
imgSDR_XYZ = rgb2xyz(imgSDR_GammaRemoved );
imgSDR_LAB= xyz2lab(imgSDR_XYZ);

imgHDR_double= (double(imageHDR)-0.005)./(4000-0.0005);
imgHDR_XYZ = rgb2xyz(imgHDR_double);
oriHDR_LAB= xyz2lab(imgHDR_XYZ);

imgHDR_double= (double(imgOut)-0.005)./(4000-0.0005);
imgHDR_XYZ = rgb2xyz(imgHDR_double);
ccHDR_LAB= xyz2lab(imgHDR_XYZ);
%2. calculate deltaE
deltaE(1,i)=calculateDeltaE(imgSDR_LAB,oriHDR_LAB);
deltaE(2,i)=calculateDeltaE(imgSDR_LAB,ccHDR_LAB);
end
xlswrite('deltaE1.xlsx', deltaE, 'Sheet1', 'A11:G12');
toc;