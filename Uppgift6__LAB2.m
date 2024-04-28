%Fredrik möller och Johan Kindlundh
clc
clear all
disp('uppgift 6')
disp('a, Plotta integranden')
x=(10^(-8)):(10^(-6)):(10^(-4));
%plottar ej från x=0 då funktionen inte är definerad där, tar istället
%värde nära noll. 
y=(1-(exp(-((x./5).^3))))./(3*x.^3);
plot(x,y)
disp('täljaren rör sig mot noll snabbare än vad nämnaren gör, vid små värden ger detta effekten av att funktionsvärdet blir lika med noll')
disp('funktionsvärdet borde vara skillt från noll, fram till dess att x=0 där funktionen inte är definerad')


%----------------------------------------------------------------------------------


disp('b, Gör sedan “svanskapning”')
disp('vi söker den avkapning B som bidrar till en tredjedel av det totala felet för att sedan låte trunkeringsfelet utgöra den andra hälften')
%aproximerar integralen som 1/6*x^2
Ekap=(10^(-9))/3
% då det totala felet tillåtet i uppgiften är 10^-9 och då det sker två
% integralräkningar(från 0 till 10^-4 och från 10^-4 till B) krävs det
% alltså att summan av trunkeringsfelet från dessa två integraler samt kapningsfelet
% inte överskrider 10^-9.fördelnignen mellan dessa fel är lika, 1/3 vadera.
B=(abs((-1)/(6*Ekap))).^(1/2)


%----------------------------------------------------------------------------------


disp('c, Föreslå ett sätt att i din numeriska beräkning integralens värde eliminera effekten av “darrandet”')
disp('från 0 till 10^-4 används Taylorutvecklingen av funktionen, grad tolv ')
y1=(1/375)-((x.^3)./93750)+((x.^6)./35156250)-((x.^9)./17578125000)+((x.^12)/10986328125000);


%----------------------------------------------------------------------------------


disp('d, Behövs ytterligare förbe-handling för att beräkna integralen med trapetsregeln?')
disp('nej för Etrunk konvergerar som önskat')
a=30; b=B ; n=1000;
t=0;
for i=1:6
    h=(b-a)/n;
    x=a:h:b;
    y=(1-(exp(-((x./5).^3))))./(3*x.^3);
    t(i)=h*(sum(y)-(y(1)+y(n+1))/2);
    n=2*n;
end

a=(10^(-3)); b=30 ; n=100000;
t2=0
for i=1:6
    h=(b-a)/n;
    x=a:h:b;
    y=(1-(exp(-((x./5).^3))))./(3*x.^3);
    t2(i)=h*(sum(y)-(y(1)+y(n+1))/2);
    n=2*n;
end
%kontrolerar integralen
for i=1:4
    b4=t(i);
    b2=t(i+1);
    b1=t(i+2);
    Ep=(b4-b2)/(b2-b1);
    %är en funktion av 2 - alltså är integralen säker
    Etrunk=abs(b1-b2);
    %skillnaden mellan integraler med olika steglängder. där den ena är
    %dubbelt så stor som den andra. 
end

%Richardson-extrapolation
for i=1:3
    b2=t(i);
    b1=t(i+1);
    R(i)=b1+((b1-b2));
end
%Richardson-extrapolation nr2
for i=1:2
    b2=R(i);
    b1=R(i+1);
    RR(i)=b1+((b1-b2)/15);
end
Etrunkr=abs(R(3)-R(2));
Etrunkrr=abs(RR(2)-RR(1)); %ska utgöra <(10^-9)/3


%----------------------------------------------------------------------------------


disp('e, Beräkna nu värdet av integralen med trapetsregel')
a=0; b=(10^(-4)); n=100;
t1=0;
for i=1:6
    h=(b-a)/n;
    x=a:h:b;
    y1=(1/375)-((x.^3)./93750)+((x.^6)./35156250)-((x.^9)./17578125000)+((x.^12)/10986328125000);
    t1(i)=((h*(sum(y1)-(y1(1)+y1(n+1))))/2);
    n=2*n;
end
for i=1:4
    b4=t1(i);
    b2=t1(i+1);
    b1=t1(i+2);
    Ep1=(b4-b2)/(b2-b1);
    Etrunk1=abs(b1-b2);
end

%Richardson-extrapolation
for i=1:3
    b2=t1(i);
    b1=t1(i+1);
    R1(i)=b1+((b1-b2)./3);
end
%Richardson-extrapolation nr2
for i=1:2
    b2=R1(i);
    b1=R1(i+1);
    RR1(i)=b1+((b1-b2)./15);
end
Totalintegral=RR(2)+RR1(2)
Etrunkr1=abs(R(3)-R(2));
Etrunkrr1=abs(RR1(2)-RR1(1));

disp('Beräkna nu värdet av integralen med trapetsregel')
%----------------------------------------------------------------------------------
disp('e, Skatta felgränsen för ditt svar med din metod')
Totalfel=Ekap+Etrunkrr1+Etrunkrr


