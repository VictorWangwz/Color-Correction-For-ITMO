%alphaMapRev4.m
%By Benny
%this code test combinations of LAB values to find their corresponding
%alpha value that can result in the lowest deltaE
clc;
clear all;
tic;
%select iTMO
iTMO=3; %1: Akyuz; 2: Banterle; 3:Bist; 4:Meylan
%define LAB values test ranges
switch(iTMO)
    case 1 %Akyuz
        LStart=0; LStep=20; LEnd=100;
        AStart=-100; AStep=20; AEnd=100;
        BStart=-100; BStep=20; BEnd=100;
        alphaTestRange=10;
    case 2 %Banterle
        LStart=0; LStep=20; LEnd=100;
        AStart=-100; AStep=19; AEnd=90;
        BStart=-100; BStep=20; BEnd=100;
        alphaTestRange=100;
    case 3 %Bist
        LStart=0; LStep=5; LEnd=100;
        AStart=-100; AStep=5; AEnd=100;
        BStart=-100; BStep=5; BEnd=100;
        alphaTestRange=10;
    case 4 %Meylan
        LStart=0; LStep=20; LEnd=100;
        AStart=-100; AStep=19; AEnd=90;
        BStart=-100; BStep=20; BEnd=100;
        alphaTestRange=100;
end
alphaMap=zeros([100 200 200]);
%try 5*10*10 = 500 LAB values
for L=LStart:LStep:LEnd %set steps to 20 to reduce steps when debugging
    for A=AStart:AStep:AEnd
        for B=BStart:BStep:BEnd
            %create image
            for i=1:10
                for j=1:10
                    img(i,j,1)=L;
                    img(i,j,2)=A;
                    img(i,j,3)=B;
                end
            end
%             img(1,1,1)=L;
%             img(1,1,2)=A;
%             img(1,1,3)=B;
            %convert img from Lab to RGB
            imgNormalized=lab2rgb(img);
            imgNormalized(imgNormalized<0)=0;
            % add gamma
            imgNormalizedGamma=imgNormalized.^(1/2.2);
            %scale to range 0 to 255
            imgSDR=imgNormalizedGamma*255;
            %perform iTMO
            switch(iTMO)
                case 1 %Akyuz
                    imgHDR  = Akyuz_iTMO_hdr( imgSDR , 4000 , 1);
                case 2 %Banterle
                    imgHDR = Banterle_iTMO_hdr(imgSDR);
                case 3 %Bist
                    imgHDR  = Bist_iTMO( imgSDR);
                case 4 %Meylan
                    imgHDR = Meylan_iTMO_hdr( imgSDR, 4000, 0.66 );
            end
            %find alpha with the lowest deltaE value
            [alphaOut,deltaE_min,alpha,deltaE] =findAlpha(imgSDR,imgHDR,0,alphaTestRange,0.1);
            % store value in 3D matrix
            L_=L+1;
            A_=A+101;
            B_=B+101;
            alphaMap(L_,A_,B_)=alphaOut;
            if (iTMO==1 && L==0 && A==0 && B==0)
                alphaMap(L_,A_,B_)=1;
            end
            %debug code
            if (alphaOut==0)
                disp(alphaOut);
            end
            txt=['L: ',num2str(L),'; A: ',num2str(A),'; B: ',num2str(B),'; alphaOut: ',num2str(alphaOut)];
            disp(txt);
        end 
    end
end
toc%output time elapsed
txt=['Max alpha: ',num2str(max(max(max(alphaMap))))];