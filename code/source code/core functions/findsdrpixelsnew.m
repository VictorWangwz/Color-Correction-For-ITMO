%Search alpha in the alphamap for the image
%By Siqi An and Zhen Wang. 
function imgOut= findsdrpixelsnew(imageSDR,imageHDR,alphaMap)
%normalize, remove gamma, and convert SDR image to Lab Colour space
imgSDR_double= double(imageSDR)./255;
imgSDR_GammaRemoved = imgSDR_double.^2.2;
imgSDR_XYZ = rgb2xyz(imgSDR_GammaRemoved );
imgSDR_LAB= xyz2lab(imgSDR_XYZ);
%normalize HDR image and change it to lab
imgHDR_double= (double(imageHDR)-0.005)./(4000-0.0005);
imgHDR_XYZ = rgb2xyz(imgHDR_double);
%L_HDR_XYZ=max(max(imgHDR_XYZ(:,:,2)));
imgHDR_LAB= xyz2lab(imgHDR_XYZ);
bound=min(min(min(imgHDR_LAB)));

%get LAB value of SDRimage
     L=imgSDR_LAB(:,:,1);
     A=imgSDR_LAB(:,:,2);
     B=imgSDR_LAB(:,:,3);
     L_min=min(L(:));
     A_min=min(A(:));
     B_min=min(B(:));
     
for i = 1:1080
    for j = 1:1920
        %set l,a,b as the index of alphaMap to find alpha for l,a,b (when alpha==0, choose the alpha of the closest point)
    l=round(double(L(i,j))/5)*5+1;
    a=round(double(A(i,j))/5)*5+101;
    b=round(double(B(i,j))/5)*5+101;
    if(l<=0)
        l=1;
    end
    if(a<=0)
        a=1;
    end
    if(b<=0)
        b=1;
    end
    
    alpha=alphaMap(l,a,b);
   imgHDR_LAB(i,j,2)=alpha*imgHDR_LAB(i,j,2);
   imgHDR_LAB(i,j,3)=alpha*imgHDR_LAB(i,j,3);
    end
end
%convert img from Lab to RGB
imgOutNormalized=lab2rgb(imgHDR_LAB);
imgOutNormalized(imgOutNormalized<0)=0;
%scale to range 0.005 to 4000
imgOut=imgOutNormalized*(4000-0.005)+0.005;

%newalpha= newalpha(:,:,:);
%dlmwrite('D:\541\Color_Correction_iTMO\MATLAB Codes\Needed Functions\data.txt',newalpha);
end