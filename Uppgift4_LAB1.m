clc

%Fredrik Möller, Johan Kindlundh, SF1514

format long
disp('uppgift 4');
datum=[1,32,60,91,121,152,182,213,244,274,305,335,365];
%enligt den gregorianska kalendern
%Datum motsvarar vilken dag i ordningen på året, detta kommer motsvara
%våran X-variabel
timmar=[6,8,10,13,15,18,18,16,14,11,8,6,6];
%Timmarna angivan i tabellen
minuter=[15,06,32,15,55,04,25,38,04,24,46,36,14];
%minutrarna angivan i tabellen
tid=(timmar*60)+minuter;
%Totala tiden i minuter, detta kommer motsvara våran Y-variabel
a=1:365;
% a kommer att motsvara samtliga 365 dagar på året, till plottning

disp('A')
disp('Ett interpolationspolynom som går genom samtliga punkter.')
Pa=polyfit(datum,tid,12)
%Bestämmer konstanterna till polynomet, i detta fall en 12gradare då det
%finns 13 mätpunkter att ta hänsyn till, 13 konstanter
yA=polyval(Pa,a);
%Bestämmer antal soltimmar för respektive dag utifrån den 12tegradare som
%skapats ovan i polyfit. 
subplot(3,3,1)
plot(datum,tid,'*');
title('A')
hold on
plot(a,yA);
hold off
%plottar mätdata och funktionskurva

disp('B');
disp('Styckvis linjär interpolation genom samtliga punkter.')
subplot(3,3,2);
plot(datum,tid,'*');
%plottar mätdata
title('B')
hold on
for i=1:length(datum)-1
    % till length(datum)-1 då det inte går att dra en linnje från den sista punkten
    B=datum(i):datum(i+1);
    yB=(tid(i)+(((tid(i+1)-tid(i))/(datum(i+1)-datum(i))*(B-datum(i)))));
    %Linjär interpolation mellan två mätdata efter varandra
    plot(B,yB);
    %plottar varje linje
end
hold off
%totalt 2*12 konstanter, 24 konstanter


disp('C');
disp('Splines-approximation genom samtliga punkter.')
subplot(3,3,3);
yC=spline(datum,tid,a);
%kubisa splines-aproximation, varje  linje mellan två mätdata är en
%tredjegradare och kräver därför 4 konstanter, det är 12 linjer och därmed
%48 konstanter.
plot(datum,tid,'*',a,yC);
title('C')

disp('D');
disp('Ett andragradspolynom som bara använder data från 1 juni till 1 augusti för att bestämma koefficienterna.')
subplot(3,3,4);
PD=polyfit(datum(6:8),tid(6:8),2)
%bestämmer 3 konstanter utifrån mätdata
yD=polyval(PD,a);
%Bestämmer antal soltimmar för respektive dag utifrån den andragradare som
%skapats ovan i polyfit.
plot(datum,tid,'*');
title('D')
hold on
plot(a,yD);
hold off


disp('E');
disp('Ett minstakvadratanpassat andragradspolynom som bara använder data from 1 apriltom 1 september för att bestämma koefficienterna.')
subplot(3,3,5);
PE=polyfit(datum(4:9),tid(4:9),2)
%bestämmer 3 konstanter utifrån mätdata
yE=polyval(PE,a);
%Bestämmer antal soltimmar för respektive dag utifrån den andragradare som
%skapats ovan i polyfit.
plot(datum,tid,'*');
title('E')
hold on
plot(a,yE);
hold off

disp('F');
disp('Ett minstakvadratanpassat andragradspolynom som använder samtliga data from 1januari tom 31 december')
subplot(3,3,6);
PF=polyfit(datum,tid,2)
%bestämmer 3 konstanter utifrån mätdata
yF=polyval(PF,a);
%Bestämmer antal soltimmar för respektive dag utifrån den andragradare som
%skapats ovan i polyfit.
plot(datum,tid,'*');
title('F')
hold on
plot(a,yF);
hold off

disp('G')
disp('Funktionen y = c1 +c2 cos (w ∗ x)+c3 sin (w ∗ x) minstakvadratanpassd till samtliga data från 1 januari till 31 december där w = 2π/365 (dvs periodtiden 1 år)')
subplot(3,3,7);
datumt=datum';
tidt=tid';
w=(2*pi)/365;
A=[datumt.^0, cos(w.*datumt), sin(w.*datumt)];
%A*CG=tidt
CG=A\tidt
%bestämmer minstakvadratanpassningen till mätdata, tre konstanter
yG=CG(1)+CG(2).*cos(w.*a)+CG(3).*(sin(w*a));
plot(datum,tid,'*')
hold on
plot(a,yG);
hold off
title('G')

disp('a')
disp('vilken ansats behövdes flest koefficienter beräknas (totalt över hela intervallet)? Hur många koefficienter är det?')
disp('splinesaproximationen, 48 konstanter')

disp('b')
disp('Fyra av ansatserna behövde bara beräkna 3 koefficienter totalt, vilka?')
disp('D, E, F, G')

disp('c')
disp('Vilken metod är bäst för att beräkna årets längsta dag? Varför? Vad blir soltiden?')
disp('graf D-G residualvektor: ')
rD=[tid(6:8)-polyval(PD,datum(6:8))]'
rE=[tid(4:9)-polyval(PE,datum(4:9))]'
rF=[tid-polyval(PF,datum)]'
rG=tidt-A*CG
disp('årets längsta dag')
disp('då det mätdata som funktionen är anpassad till ligger nära och på varsin sida om punkten för flest soltimmar samt att residualvektorn är liten och varierande i tecken används funktion D')
%A-C är inte lämpliga aproximationer då de går igenom samtliga punkter och
%kan därför anses som "för bra" då mätdatat naturligtvis innehåller mätfel. 
disp(max(yD))
% med max Ser vilket a som korresponderar med det högsta yD värdet

disp('d')
disp('Vilken metod är bäst för att beräkna värdet på julafton? Varför? Vad blir soltiden?')
disp('vi använder G funktionen då den har en teckenvarierande och relativt liten residualvektor för hela spannet av mätdata. ')
disp(yG(358))

disp('e')
disp('Vilken metod tycker du var bäst? Varför?')
disp('G då residualen varierar i tecken och är liten över hela spannet av mätdata')

disp('f')
disp('Vad i ditt program behöver ändras om du i stället för soltid hade fått en tabell över solens upp- och nedgång, dvs två klockslag per rad?')
disp('det enda som skulle behöva ändras är hur tid-vektorn framställs, nedgång-uppgång')
