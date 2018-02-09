% find max min lum for akyuz
%By Benny
tic
Lum=zeros([100 200 200]);
for L=10:15:100 %set steps to 15 to reduce steps when debugging
    for A=-100:20:100
        for B=-100:20:100
            img(1,1,1)=L;
            img(1,1,2)=A;
            img(1,1,3)=B;
            %convert img from Lab to RGB
            imgNormalized=lab2rgb(img);
            imgNormalized(imgNormalized<0)=0;
            %debug code
            A_=A+101;
            B_=B+101;
            Lum(L,A_,B_) = RGB2Lum( imgNormalized );
            %disp(Lum(L,A_,B_));
        end
    end
end
toc
txt=['max lum: ',num2str(max(max(max(Lum)))),'; min lum: ',num2str(min(min(min(Lum))))];
disp(txt);