%updated 2017-11-19
% used to compare original SDR images & HDR images from iTMO using LAB 
% instead of oringal colour space, then adjusted with alpha & ratio
%By Benny
clc;
clear;
%Akyuz gamma=1.00
for i=1:7
    ImgHDR = hdrread(strcat('AkyuzOutput100/AkyuzOutputLab100Adjusted',num2str(i),'.hdr'));
    ImgSDR = imread(strcat('TestingFrames/',num2str(i),'.png'));
    %dist(i,1)= sqrt(sum((ImgIn(:) - ImgOut(:)) .^ 2));
    dist(i,1)= deltaELab(ImgSDR,ImgHDR);
end
%Akyuz gamma=0.45
for i=1:7
    ImgHDR = hdrread(strcat('AkyuzOutput045/AkyuzOutputLab',num2str(i),'.hdr'));
    ImgSDR = imread(strcat('TestingFrames/',num2str(i),'.png'));
    %dist(i,2)= sqrt(sum((ImgIn(:) - ImgOut(:)) .^ 2));
    dist(i,2)= deltaELab(ImgSDR,ImgHDR);
end
%Akyuz gamma=2.20
for i=1:7
    ImgHDR = hdrread(strcat('AkyuzOutput220/AkyuzOutputLab',num2str(i),'.hdr'));
    ImgSDR = imread(strcat('TestingFrames/',num2str(i),'.png'));
    %dist(i,3)= sqrt(sum((ImgIn(:) - ImgOut(:)) .^ 2));
    dist(i,3)= deltaELab(ImgSDR,ImgHDR);
end
%Banterle
for i=1:7
    ImgHDR = hdrread(strcat('BanterleOutput/BanterleOutputLab',num2str(i),'.hdr'));
    ImgSDR = imread(strcat('TestingFrames/',num2str(i),'.png'));
    %dist(i,4)= sqrt(sum((ImgIn(:) - ImgOut(:)) .^ 2));
    dist(i,4)= deltaELab(ImgSDR,ImgHDR);
end
%Bist
for i=1:7
    ImgHDR = hdrread(strcat('BistOutput/BistOutputLab',num2str(i),'.hdr'));
    ImgSDR = imread(strcat('TestingFrames/',num2str(i),'.png'));
    %dist(i,5)= sqrt(sum((ImgIn(:) - ImgOut(:)) .^ 2));
    dist(i,5)= deltaELab(ImgSDR,ImgHDR);
end
%Meylan p=0.66
for i=1:7
    ImgHDR = hdrread(strcat('MeylanOutput066/MeylanOutputLab',num2str(i),'.hdr'));
    ImgSDR = imread(strcat('TestingFrames/',num2str(i),'.png'));
    %dist(i,6)= sqrt(sum((ImgIn(:) - ImgOut(:)) .^ 2));
    dist(i,6)= deltaELab(ImgSDR,ImgHDR);
end
%Meylan p=0.33
for i=1:7
    ImgHDR = hdrread(strcat('MeylanOutput033/MeylanOutputLab',num2str(i),'.hdr'));
    ImgSDR = imread(strcat('TestingFrames/',num2str(i),'.png'));
    %dist(i,7)= sqrt(sum((ImgIn(:) - ImgOut(:)) .^ 2));
    dist(i,7)= deltaELab(ImgSDR,ImgHDR);
end
