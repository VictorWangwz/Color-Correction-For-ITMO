%This code takes in SDR test frames and perform iTMO using LAB instead of original colour space to produce .hdr images
%By Benny
clc;
clear all;
addpath(genpath('C:\Users\I856853\Desktop\EECE541\Project\Color_Correction_iTMO'));
% === Akyuz_iTMO gamma=1.00 ===
cd AkyuzOutput100;
for i=1:7
    ImgIn = imread(strcat('TestingFrames/',num2str(i),'.png'));
    ImgOut = Akyuz_iTMO_Lab( ImgIn , 4000 , 1);
    hdrwrite(ImgOut,strcat('AkyuzOutputLab',num2str(i),'.hdr'));
end
cd ..;
fprintf('Akyuz 1.00 Completed');
% === Akyuz_iTMO gamma=0.45 ===
cd AkyuzOutput045;
for i=1:7
    ImgIn = imread(strcat('TestingFrames/',num2str(i),'.png'));
    ImgOut = Akyuz_iTMO_Lab( ImgIn , 4000 , 0.45);
    hdrwrite(ImgOut,strcat('AkyuzOutput',num2str(i),'.hdr'));
end
cd ..;
fprintf('Akyuz 0.45 Completed');
% === Akyuz_iTMO gamma=2.20 ===
cd AkyuzOutput220;
for i=1:7
    ImgIn = imread(strcat('TestingFrames/',num2str(i),'.png'));
    ImgOut = Akyuz_iTMO_Lab( ImgIn , 4000 , 2.20);
    hdrwrite(ImgOut,strcat('AkyuzOutput',num2str(i),'.hdr'));
end
cd ..;
fprintf('Akyuz 2.20 Completed');
%=== Banterle_iTMO ===
cd BanterleOutput;
for i=1:7
    ImgIn = imread(strcat('TestingFrames/',num2str(i),'.png'));
    ImgOut = Banterle_iTMO_Lab( ImgIn );
    hdrwrite(ImgOut,strcat('BanterleOutputLab',num2str(i),'.hdr'));
    end
cd ..;
fprintf('Banterle Completed');
%=== Bist_iTMO ===
cd BistOutput;
for i=1:7
    ImgIn = imread(strcat('TestingFrames/',num2str(i),'.png'));
    ImgOut = Bist_iTMO_Lab( ImgIn );
    hdrwrite(ImgOut,strcat('BistOutput',num2str(i),'.hdr'));
end
cd ..;
fprintf('Bist Completed');
%=== Meylan_iTMO p=0.66 ===
cd MeylanOutput066;
for i=1:7
    ImgIn = imread(strcat('TestingFrames/',num2str(i),'.png'));
    ImgOut = Meylan_iTMO_Lab( ImgIn, 4000, 0.66 );
    hdrwrite(ImgOut,strcat('MeylanOutput',num2str(i),'.hdr'));
end
cd ..;
fprintf('Meylan 0.66 Completed');
%=== Meylan_iTMO p=0.33 ===
cd MeylanOutput033;
for i=1:7
    ImgIn = imread(strcat('TestingFrames/',num2str(i),'.png'));
    ImgOut = Meylan_iTMO_Lab( ImgIn, 4000, 0.33 );
    hdrwrite(ImgOut,strcat('MeylanOutput',num2str(i),'.hdr'));
end
cd ..;
fprintf('Meylan 0.33 Completed');