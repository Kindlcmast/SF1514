%Fredrik möller och Johan Kindlundh
clc
clear all
format long
disp('uppgidt 5 a och b') 
C=[0.969,1,1.031];
startvarden=[0.1,5];
for j=1:2
for i=1:length(C)
    k=C(i);
    a=startvarden(j); 
    % 0.1 för den mindre roten och 5 för den större roten
    a1=a+10;
    % detta är bara ett värde för att kunna använda i whilesatsens krav, dvs vi skapar en till aproximation.
    e = 10^(-8);
    % e motsvarar det maximala tillåtna relativfelet
    n = 200;
    % n motsvarar antal iterationer som maximalt ska genomföras.
    iteration = 1;
    %itration ökar med +1 för varje loop/itration när itration=n (200) bryts loopen.
    E=[a];
    %i matris E sparas samtliga aproximationer. 
    %newtons metod
        while ((abs(a-a1))/(min(abs([a,a1]))))>e 
            %så länge det relativa felet är större än e fortsätter det skapas nya aproxiimationer 
           fa=(a.*62)-(((a+0.04+a.^2)./((a.*2)+1)).^7)-((a.*19.*k).*exp(-a));
           %funktionen y, med variabel a istället för x.
           ga=(14*((a.^2+a+(1/25)).^7)/(2*a+1).^8)-(7*(a^2+a+(1/25)).^6)/(2*a+1)^6-19*k*exp(-a)+19*k*a*exp(-a)+62;
           %ga är derivatan av fa
        
           if ga==0
               %undviker divition med noll, genom att bryta när ga=0
               disp('Divition med noll');
               break;
           end
            b=a-(fa/ga);
          %skapar ny aproximation enligt newtons metod
          %fprintf('iteration=%d\ta=%u f(a)=%u\n',iteration,a,fa);
          % skriver ut vilken itration som korresponderar till vilken aproximation
          % och erhållt funktionsvärde
           a1=a;
           a=b;
           %nästa aproximation tilldelas ett värde och föregående tilldelas till a1.
           E=[E,a];
           %uppdaterar matris E med ett till värde på a
           if iteration==n
               %bryter vid 200ande iterationen
              disp(' 200 itrationer genomförda, konvergerar ej med detta startvärde till kravsatt relativfel');
              break;
           end
   iteration = iteration + 1;
   %antal utförda itrationer
        end
A(i,j)=[a];
%sparar samtliga rötter, för respektive K värde.
%första kollumen, mista roten, andra kollumen, största roten(J), 
end
end
disp('större roten, ökad konstant')
disp(A(3,2)/A(2,2))
disp('mindre roten, ökad konstant')
disp(A(3,1)/A(2,1))
disp('större roten, minskad konstant')
disp(A(1,2)/A(2,2))
disp('mindre roten, miskad konstant')
disp(A(1,1)/A(2,1))

disp('När konstanten ökar påverkas  inte roten procentuellt åt samma håll eller i samma grad')
disp('När konstanten minskar påverkas  inte roten procentuellt åt samma håll eller i samma grad')
disp('anledningen till att de blir på detta vis är för att i newtonaproximationen blir förändringen b=a-1/k^2 vilket ger en förändring på rötterna som motsvaras av (a - 1/k^2)/(a - 1) ')
disp('vilket  för k<1 och a<1 ger en förändringsfaktor <1 och så vidare')

