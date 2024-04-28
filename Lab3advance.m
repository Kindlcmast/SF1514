%Lab 3 johan Kindlundh och Fredrik möller

clc;clear;clf;format long;

main()

%____Uppgifter______
function A=UppgiftA(a,alpha,m,V0,kx,ky,g,xbull,x0,y0)
%Bestämmer Y vid Xbull
if a==1
    A=Euler(alpha,m,V0,kx,ky,g,xbull,x0,y0);
else; A=nan; end
end

function B=UppgiftB(b,m,V0,kx,ky,g,xbull,x0,y0,ybull)
%Bestämmer vinkeln Alpha för att nå Ybull
if b==1
    for i=1:2
    if i==1;giss=5;
    else giss=81.9;end
    B(i)=sekantalph(giss,m,V0,kx,ky,g,xbull,x0,y0,ybull);
    end
else; B=nan; end
end 

function C=UppgiftC(c,m,alpha,kx,ky,g,xbull,x0,y0,ybull)
%Ger hastigheten V0 för att nå Ybull
if c==1
    giss=15;
    C=SekantV(giss,m,alpha,kx,ky,g,xbull,x0,y0,ybull);
else; C=nan; end
end

function D=UppgiftD(d,alpha,kx,ky,g,xbull,x0,y0,ybull)
%Ger en graf över utgångshastighet [V0] för respektve vikt [m]
if d==1
    H=3; %finner hastigheten för tre massor
    m=linspace(18*10^-3,30*10^-3,H);  
    giss=[15,18];
    for i=1:H
        D(i)=SekantV(giss,m(i),alpha,kx,ky,g,xbull,x0,y0,ybull);
        if D==0;
            disp('nofunc')
            break;
        end
        i=i+1;
    end
    p=polyfit(m, D, 2);
    x=(linspace(18,30,20))*10^(-3);
    y=polyval(p,x);
    figure(1)
    plot(x,y)
    xlabel('massa [Kg]'); ylabel('hastighet [m/s]');hold on 
else; D=nan; end
end

%____________Diffekvation___________________________
function Eut=Euler(alpha,m,V0,kx,ky,g,xbull,x0,y0)
% Denna funktion tar in begynnelsevillkor och konstanter som parameterar 
% använder Eulers metod för att lösa diffekvation
% ger ett värde för Y vid Xbull. 

 n=300000;
%____Begynelsevillkor____
vx0=V0*cosd(alpha); vy0=V0*sind(alpha);

%____Funktioner____
ay=@(vx,vy) ((-m.*g)-(ky.*vy.*(sqrt((vx.^2)+(vy.^2)))))./m;
ax=@(vx,vy) ((-kx).*vx.*(sqrt((vx.^2)+(vy.^2))))./m;
fun=@(vx,vy)[vx;vy;ax(vx,vy);ay(vx,vy)];
u0=[x0;y0;vx0;vy0];
tidpunkter=linspace(0,2,n);
u0=ode45(fun,tidpunkter,u0);
% P motsvarar platsen i listan där vi finner värden kring Xbull
p=1;
while u0(1,p)<xbull    
    p=p+1;
end

%_Plottar_kastbanan_fram_till_P_
%plot(u0(1,1:p),u0(2,1:p)); grid on; hold on
%xlabel('Längd [m]'); ylabel('Höjd [m]');
%yticks(1.5:0.01:2); xticks(0:0.1:2.5); 
%interpolarar_över_de_punkterna_närmst_Xbull_
Eut=spline(u0(1,:),u0(2,:), xbull);


%___Felanalys__
disp('Trunkeringsfel')
disp(fel+int(2))

end
%____________Inskjutsmetoden________________________
function fel=inskjut(alpha,m,V0,kx,ky,g,xbull,x0,y0,ybull)
    %Denna funktion ger differensen mellan ybull och Y vid Xbull
    eut=Euler(alpha,m,V0,kx,ky,g,xbull,x0,y0);
    fel=eut-ybull;
end
%____________Sekantmetoden__________________________
function alphaut=sekantalph(giss,m,V0,kx,ky,g,xbull,x0,y0,ybull)
    %Denna funktion tar in begynnelsevillkor och startvärden
    %Ger vinkel för Ybull
    giss0=giss(1);
    fel0=@(giss0)inskjut(giss0,m,V0,kx,ky,g,xbull,x0,y0,ybull);
    alphaut=fzero(fel0,giss0);
end

function Vut=SekantV(giss,m,alpha,kx,ky,g,xbull,x0,y0,ybull)
    %Denna funktion tar in begynnelsevillkor och startvärden
    giss0=giss(1);
    fel0=@(giss0)inskjut(alpha,m,giss0,kx,ky,g,xbull,x0,y0,ybull);
    giss1=fzero(fel0,giss0);
    Vut=giss1;
end

function storningsanalys(n,A,B,C)

if n==1
%För utskrift 
formatSpec = '%-10s %-17s %-12s %-20s \n';
formatSpec1 = '%-10s %-17f %-12f %-20f \n';

fprintf(formatSpec,'uppgift', 'nominellt värde', 'störning', 'felskattning metod')

%Sörningsanalys enligt |Vmin-Vmax|/2
%Uppgift a
FelA=abs(A(1,1)-A(1,3))/2;
fprintf(formatSpec1,'a',A(1,2),FelA,7e-06)
%Uppgift b första vinkel
FelB1=abs(B(1,1)-B(1,3))/2;
B(1,2)
fprintf(formatSpec1,'b',B(1,2),FelB1,7e-06)
%Uppgift b andra vinkel
FelB2=abs(B(2,1)-B(2,3))/2;
B(2,2)
fprintf(formatSpec1,'b',B(2,2),FelB2,8e-06)
%Uppgift c
FelC=abs(C(1,1)-C(1,3))/2;
fprintf(formatSpec1,'c',C(1,2),FelC,8e-06)

end
end

function main()
%Faktorer och termer för störningsanalys, max min.
termerna=[(-0.5);0;0.5];  %för de konstanter som ska påverkas +-0.5 
faktorerna=[0.99;1;1.01]; %för de konstanter som ska påverkas 1% då dessa konstanter påverkas mer än 1% med +-0.5 
for i=1:3
%uppgiftsgemensama konstanter
faktor=faktorerna(i); term=(termerna(i));
kx=0.001*faktor; ky=0.01*faktor;  g=9.82*faktor;  xbull=(237+term)*10^-2; 
x0=0; y0=(185+term)*10^-2; ybull=(183+term)*10^-2; m=(26*faktor)*10^-3;
%För uppgift a
V0a=13*faktor;
alphaa=5*faktor;
%För uppgift b
V0b=13*faktor;
%För uppgift c
alphac=2*faktor;
%För uppgift d
alphad=2*faktor;

%Kör smaltilga uppgifter, med  respektive konstant
%Lägger svaret för respektive uppgift i vektor.  
A(i)=UppgiftA(1,alphaa,m,V0a,kx,ky,g,xbull,x0,y0);
B(1:2,i)=UppgiftB(0,m,V0b,kx,ky,g,xbull,x0,y0,ybull);
C(i)=UppgiftC(0,m,alphac,kx,ky,g,xbull,x0,y0,ybull);
D=UppgiftD(0,alphad,kx,ky,g,xbull,x0,y0,ybull);
end
%plot(2.37,1.83,'*')
%legend('min','nominell','max', 'bull')
%Skickar svaren för störningsanalys
storningsanalys(1,A,B,C)
end
