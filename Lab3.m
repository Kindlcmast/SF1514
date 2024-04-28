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
    if i==1;giss=[1,5];
    else giss=[81.9,81.93];end
    B(i)=sekantalph(giss,m,V0,kx,ky,g,xbull,x0,y0,ybull);
    end
else; B=nan; end
end 

function C=UppgiftC(c,m,alpha,kx,ky,g,xbull,x0,y0,ybull)
%Ger hastigheten V0 för att nå Ybull
if c==1
    giss=[15,20];
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
    A=[ones(H,1),m',(m.^2)'];
    C=A\D';
    x=(linspace(18,30,20))*10^(-3);
    y=C(1)+(C(2)*x)+(C(3)*x.^2);
    plot(x,y)
    xlabel('massa [Kg]'); ylabel('hastighet [m/s]'); title('Uppgift D');hold on 
else; D=nan; end
end

%____________Diffekvation___________________________
function Eut=Euler(alpha,m,V0,kx,ky,g,xbull,x0,y0)
% Denna funktion tar in begynnelsevillkor och konstanter som parameterar 
% använder Eulers metod för att lösa diffekvation
% ger ett värde för Y vid Xbull. 

j=1; n=300000;
%____Begynelsevillkor____
vx0=V0*cosd(alpha); vy0=V0*sind(alpha);

%____Funktioner____
ay=@(vx,vy) ((-m*g)-(ky*vy*(sqrt((vx^2)+(vy^2)))))/m;
ax=@(vx,vy) ((-kx)*vx*(sqrt((vx^2)+(vy^2))))/m;
fun=@(vx,vy)[vx;vy;ax(vx,vy);ay(vx,vy)];      

fel=1;
while fel>(10^(-5))%_Trunkeringsfelet_av_Y(2)_
    %___Begynelsevillkor___
    u0=[x0;y0;vx0;vy0];
   
    i=1;  h=2/n; %_Steglängd_
    for ii=0:h:2 %_från_tiden_0_till_tiden_2_
            hF=h*fun(u0(3,end),u0(4,end));
            u0(:,i+1)=u0(:,i)+hF; %Eulers metod
            i=i+1;
    end
    y(:,j)=u0(:,end);
    if j>1
        fel=norm(y(:,j-1)-y(:,j),'inf'); %Felskattning av metod
    end
    j=j+1; n=n*2; 
end
%nogranhetsordning
%j=j-1;
%(norm(y(:,j-2)-y(:,j-1),'inf')/norm(y(:,j-1)-y(:,j),'inf'))

% P motsvarar platsen i listan där vi finner värden kring Xbull
p=1;
while u0(1,p)<xbull    
    p=p+1;
end

% %_Plottar_kastbanan_fram_till_P_
plot(u0(1,1:p),u0(2,1:p)); grid on; hold on
xlabel('Längd [m]'); ylabel('Höjd [m]');
yticks(1.5:0.01:2); xticks(0:0.1:2.5); 
%interpolarar_över_de_punkterna_närmst_Xbull_
vec=u0(1:2,p-2:p); %två st innan bull, en efter 
int=interpolation(vec, xbull);
Eut=int(1);

%___Felanalys__
%disp('Trunkeringsfel')
%disp(fel+int(2))

end
%____________Interpolation__________________________
function int=interpolation(vec, xbull)
%___Linjär_interpolation_andra_graden___

% y=c1 (ones) +c2*x +c3*x^2 
A=[ones(3,1),vec(1,:)',vec(1,:)'.^2];
b=[vec(2,:)]'; C=A\b;
y2=C(1)+(C(2)*xbull)+(C(3)*xbull^2);

%___Linjär_interpolation___
%y=c1 +c2*x
A=[ones(2,1),vec(1,2:3)'];
b=[vec(2,2:3)]'; C=A\b;
y1=C(1)+(C(2)*xbull);

%_______Felanalys________
fel=abs(y1-y2);
int=[y2,fel];
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
    TOL=10^-10; %Trunkeringsfelet för sekantmetoden
    giss0=giss(1);
    giss1=giss(2);
    fel=1; fel0=inskjut(giss0,m,V0,kx,ky,g,xbull,x0,y0,ybull);
    i=1;
    while abs(fel)>TOL
        fel1=inskjut(giss1,m,V0,kx,ky,g,xbull,x0,y0,ybull);
        %___Felhantering___
        if fel0==fel1; disp('divition med noll');break;end
        %___Sekantmetoden___
        fel=((giss1-giss0)/(fel1-fel0))*fel1;
        fel0=fel1;
        giss0=giss1;
        giss1=giss1-fel;
        en(i)=abs(giss1-giss0);
        i=i+1;
    end
    konvergensordnign=(log10(en(end))-log10(en(end-1)))/(log10(en(end-1))-log10(en(end-2)));
    alphaut=giss1;
end

function Vut=SekantV(giss,m,alpha,kx,ky,g,xbull,x0,y0,ybull)
    %Denna funktion tar in begynnelsevillkor och startvärden
    %Ger vinkel för Ybull
    TOL=10^-10; %Trunkeringsfelet för sekantmetoden
    giss0=giss(1);
    giss1=giss(2);
    fel=1; fel0=inskjut(alpha,m,giss0,kx,ky,g,xbull,x0,y0,ybull);
    i=1;
    while abs(fel)>TOL
        fel1=inskjut(alpha,m,giss1,kx,ky,g,xbull,x0,y0,ybull);
        %___Felhantering___
        if fel0==fel1; disp('divition med noll');break;end
        %___Sekantmetoden___
        fel=((giss1-giss0)/(fel1-fel0))*fel1;
        fel0=fel1;
        giss0=giss1;
        giss1=giss1-fel; 
        en(i)=abs(giss1-giss0);
        i=i+1;
    end
    konvergensordnign=(log10(en(end))-log10(en(end-1)))/(log10(en(end-1))-log10(en(end-2)));
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
metodfela=7e-06;
if isnan(A(1,2))
metodfela=nan;
else
fprintf(formatSpec1,'a',A(1,2),FelA,metodfela)
end
%Uppgift b första vinkel
FelB1=abs(B(1,1)-B(1,3))/2;
metodfelb=7e-06;
if isnan(B(1,2))
metodfelb=nan;
else
fprintf(formatSpec1,'b',B(1,2),FelB1,metodfelb)
end
%Uppgift b andra vinkel
FelB2=abs(B(2,1)-B(2,3))/2;
metodfelb2=8e-06;
if isnan(B(2,2))
metodfelb2=nan;
else
fprintf(formatSpec1,'b',B(2,2),FelB2,metodfelb2)
end
%Uppgift c
FelC=abs(C(1,1)-C(1,3))/2; 
metodfelc=8e-06;
if isnan(C(1,2))
metodfelc=nan;
else 
fprintf(formatSpec1,'c',C(1,2),FelC,metodfelc)
end
end
end

function main()

disp('Vilken Uppgift ska köras?, fler uppgifter kan väljas')
disp('1=>Körs')
a=input('uppgift a: ');
b=input('uppgift b: ');
c=input('uppgift c: ');
d=input('uppgift d: ');
storning=input('ska störningsräkning köras?: ');
disp('kör valda uppgifter ...')
tid=tic;

%Faktorer och termer för störningsanalys, max min.
termerna=[(-0.5);0;0.5];  %för de konstanter som ska påverkas +-0.5 
faktorerna=[0.99;1;1.01]; %för de konstanter som ska påverkas 1% då dessa konstanter påverkas mer än 1% med +-0.5 

%hantering av störningsanalys
if storning==1; start=1; slut=3;
else; start=2; slut=2;end

for i=start:slut
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
A(i)=UppgiftA(a,alphaa,m,V0a,kx,ky,g,xbull,x0,y0);
B(1:2,i)=UppgiftB(b,m,V0b,kx,ky,g,xbull,x0,y0,ybull);
C(i)=UppgiftC(c,m,alphac,kx,ky,g,xbull,x0,y0,ybull);
D=UppgiftD(d,alphad,kx,ky,g,xbull,x0,y0,ybull);
end
if storning==1
if d==1; legend('min','nominell','max', 'bull');end
end
% för plottarna till rapporten
% plot(2.37,1.83,'*')
% legend('min','nominell','max', 'bull')
% y0=185*10^-2;
% xbull=(237)*10^-2;
% ybull=(183)*10^-2;
% text(0,y0,'\bullet \leftarrow Nominell');
% text(0,y0+0.005,'\bullet \leftarrow Max');
% text(0,y0-0.005,'\bullet \leftarrow Min');
% plot(xbull,ybull,'*');


clc
if storning==1
    %Skickar svaren för störningsanalys
    storningsanalys(1,A,B,C)
else
    formatSpec = '%-10s %-17s %-20s \n';
    formatSpec1 = '%-10s %-17f %-20f \n';
    fprintf(formatSpec,'uppgift', 'nominellt värde', 'felskattning metod')
    if a==1;fprintf(formatSpec1,'a',A(1,2),7e-06); end
    if b==1;fprintf(formatSpec1,'b',B(1,2),7e-06);fprintf(formatSpec1,'b',B(2,2),8e-06); end
    if c==1;fprintf(formatSpec1,'c',C(1,2),8e-06);end
end
disp('Beräkningstid [sekunder]:')
format short
disp(round(toc(tid),3))
end


