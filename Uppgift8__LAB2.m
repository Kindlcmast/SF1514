%Fredrik möller och Johan Kindlundh
clc
clear all
disp('uppgift 8 a, Beräkna värdet av y(4)')
xstart=0; xslut=4; ystart=2.5; n=8;
h=(xslut-xstart)/n; x=xstart; y=ystart; xx=xstart; yy=ystart;
for i=1:n
    yprim= -((1/6)+((pi*sin(pi*x))./(1.5-(cos(pi*x))))).*y;
    y=y+h*yprim;
    x=x+h;
    xx=[xx;x]; yy=[yy;y];
end
yslut=y
plot(xx,yy);
hold on
%----------------------------------------------------------------------------------
disp('b, med 1 säker decimal')
n=8;
for j=1:10
xstart=0; xslut=4; ystart=2.5;
h=(xslut-xstart)/n; x=xstart; y=ystart; xx=xstart; yy=ystart;
for i=1:n
    yprim=-((1/6)+((pi*sin(pi*x))./(1.5-(cos(pi*x))))).*y;
    y=y+h*yprim;
    x=x+h;
    xx=[xx;x]; yy=[yy;y];
end
n=n*2;
yslut(j)=y;
plot(xx,yy);
end

b1=yslut(length(yslut)-2);
b2=yslut(length(yslut)-1);
b3=yslut(length(yslut));
ska_vara2=((b1-b2)/(b2-b3));
Etrunk=abs(b3-b2)

disp('svar: 9gånger')
