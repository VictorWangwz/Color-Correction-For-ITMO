%Find the correspond color region of each pixel in YCbCr color space 
%By Zhen Wang
function [regionYcbcr]=determineRegion(l,a,b)
lab(1,1,1)=l;
lab(1,1,2)=a;
lab(1,1,3)=b;
rgb=lab2rgb(lab,'OutputType','uint8');
ycbcr=rgb2ycbcr(rgb);
cb=double(ycbcr(1,1,2));
cr=double(ycbcr(1,1,3));
theta=atand(cr/cb);
if(theta<0)
    theta=360+theta;
end
if(theta>22&&theta<=80)
    regionYcbcr=1;%magenta
elseif(theta>80&&theta<=138)
     regionYcbcr=2;%red
    elseif(theta>138&&theta<=202)
     regionYcbcr=3;%yellow
    elseif(theta>202&&theta<=259)
     regionYcbcr=4;%green
elseif(theta>259&&theta<=319)
      regionYcbcr=5;%cyan
else 
      regionYcbcr=6;%blue
   end
end