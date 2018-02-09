%alpha_deltaE_adjustment.m
%By Benny and Zhen
%This code pick an iTMO and test alpha values that would result in the
%lowest deltaE value. The results are use to create the hdr image in both
%.png & .hdr formats.
clc;
clear all;
addpath(genpath('C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes'));
%choose the iTMO - 1=Akyuz100; 2=Banterle; 3=Bist; 4=Meylan066
iTMONum=3; 
dir='C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes';
switch iTMONum
    case 1 
        iTMOName='Akyuz100';
        dirName='C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes\Akyuz';
        fileName='AkyuzOutput100Adjusted';
    case 2 
        iTMOName='Banterle';
        dirName='C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes\Banterle';
        fileName='BanterleOutputAdjusted';
    case 3 
        iTMOName='Bist';
        dirName='C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes';
        fileName='BistOutputAdjusted';
    case 4 
        iTMOName='Meylan066';
        dirName='C:\Users\I856853\Desktop\EECE541\Project\Color_Correction_iTMO\MeylanOutput066';
        fileName='MeylanOutput066Adjusted';
end
deltaE=zeros(1,7);
for i=3:3
     %load SDR image
    ImgSDR = imread(strcat('C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes\Akyuz\',num2str(i),'.png'));
    %loading HDR image
    switch iTMONum
    case 1
        ImgHDR=Akyuz_iTMO( ImgSDR , 4000 , 1 );%hdrread(strcat('C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes\Akyuz\AkyuzOutput100\AkyuzOutput',num2str(i),'.hdr'));
    case 2
        imgHDR=Banterle_iTMO( imageSDR );%hdrread(strcat('C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes\Akyuz\AkyuzOutput100\BanterleOutput',num2str(i),'.hdr'));
    case 3
        ImgHDR=Bist_iTMO( ImgSDR );%hdrread(strcat('C:\Users\wangzhen\Desktop\eece541\Color_Correction_iTMO\MATLAB Codes\Akyuz\AkyuzOutput100\BistOutput',num2str(i),'.hdr'));
    case 4
        imgHDR=Meylan_iTMO( imageSDR );
    end
   
    %create hdr img with alpha value that has the lowest deltaE
    [alphaOut,deltaE_min,alpha,deltaE,ImgHDR_adjusted]= findAlphaOutputHdrRev3(ImgSDR,ImgHDR,0,10,0.1);
    %create .hdr & .png files
    cd(dir);
    %hdrwrite(ImgHDR_adjusted,strcat(fileName,'Global',num2str(i),'.hdr'));
   % ImgHDR_Sim2 = Sim2ShaderTechnicolor(ImgHDR_adjusted(:,:,1),ImgHDR_adjusted(:,:,2),ImgHDR_adjusted(:,:,3));
    %imwrite(ImgHDR_Sim2,strcat(fileName,'Global',num2str(i),'.png'));
    cd ..;
imgSDR_double= double(ImgSDR)./255;
imgSDR_GammaRemoved = imgSDR_double.^2.2;
imgSDR_XYZ = rgb2xyz(imgSDR_GammaRemoved );
imgSDR_LAB= xyz2lab(imgSDR_XYZ);

imgHDR_double= (double(ImgHDR_adjusted)-0.005)./(4000-0.0005);
imgHDR_XYZ = rgb2xyz(imgHDR_double);
imgHDR_LAB= xyz2lab(imgHDR_XYZ);
%2. calculate deltaE
deltaE(1,i)=calculateDeltaE(imgSDR_LAB,imgHDR_LAB);
deltaE(1,i)=deltaE_min;
end



%xlswrite('deltaE1.xlsx', deltaE, 'Sheet2', 'A1:G2');

