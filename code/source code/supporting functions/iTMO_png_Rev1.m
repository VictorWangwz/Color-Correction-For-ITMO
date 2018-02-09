%This code performs the 4 iTMOs on the 7 test frames.
%The output is saved as .png for display only for Sim2 HDR monitor.
%By Benny


clear all;
addpath(genpath('C:\Users\I856853\Desktop\EECE541\Project\Color_Correction_iTMO'));
% === Akyuz_iTMO ===
cd AkyuzOutput100;
for i=1:7
    ImgIn = imread(strcat('TestingFrames/',num2str(i),'.png'));
    ImgOut = Akyuz_iTMO( ImgIn , 4000 , 1);
    imwrite(ImgOut,strcat('AkyuzOutput',num2str(i),'.png'));
    %if need to save as HDR, go into Akyuz and comment out the last line
  %if save as .hdr, then use Q4 tool or picturenaut (free dl software)
end
cd ..;
%=== Banterle_iTMO ===
cd BanterleOutput;
for i=1:7
    ImgIn = imread(strcat('TestingFrames/',num2str(i),'.png'));
    ImgOut = Banterle_iTMO( ImgIn );
    imwrite(ImgOut,strcat('BanterleOutput',num2str(i),'.png'));
    
    end
cd ..;
%=== Bist_iTMO ===
cd BistOutput;
for i=1:7
    ImgIn = imread(strcat('TestingFrames/',num2str(i),'.png'));
    ImgOut = Bist_iTMO( ImgIn );
    imwrite(ImgOut,strcat('BistOutput',num2str(i),'.png'));
end
cd ..;
%=== Meylan_iTMO ===
cd MeylanOutput066;
for i=1:7
    ImgIn = imread(strcat('TestingFrames/',num2str(i),'.png'));
    ImgOut = Meylan_iTMO( ImgIn, 4000, 0.66 );
    imwrite(ImgOut,strcat('MeylanOutput',num2str(i),'.png'));
end
cd ..;
fprintf('It is Done');
