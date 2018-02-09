%Draw the histogram based on the alpha Map
%By Zhen Wang. 
clc;
clear all;
iTMONum=1;
switch iTMONum
    case 1
       load alphaMap_AkyuzStep5.mat;
    case 2
        load alphaMap_Banterle.mat;
    case 3
        load alphaMap_Bist20.mat;
    case 4
       load alphaMap_Akyuz.mat;
end
count=1;
for l=1:5:100
for a=1:5:200
for b=1:5:200
alphaCollection(count)=alphaMap(l,a,b);
count=count+1;
end
end
end
alphaCollection=sort(alphaCollection);
alphafreq=hist(alphaCollection,100);
hist(alphaCollection,100);
%axis([0 10 0 35000]);
xlabel('alpha') % x-axis label
ylabel('frequency')
