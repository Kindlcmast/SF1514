%Fredrik Möller, Johan Kindlundh, SF1514

format long
disp('uppgift2')

disp('a ')
disp('Hur kan du med papper, penna och en enkel miniräknare (dvs icke graf-ritande)grovlokalisera den minsta och den största positiva roten? Gör det.')
disp('se papper')

disp('b')
disp('Rita sedan funktionen f(x) i MATLAB så att man tydligt ser var alla positiva rötterna ligger Man skall kunna utläsa 1-2 siffror i samtliga rötter.')

   %den större roten
   subplot(2,2,2)
   %Subplot delar  in plot förnstreti 2 rader, 2 kolummer
   x=3.923:0.000000001:3.933; 
   %spannet och intervallet i X-led vi plottar över
   y=(x.*62)-(((x+0.04+x.^2)./((x.*2)+1)).^7)-((x.*19).*exp(-x));
   %funktionen som plottas
   plot(x,y)
   xlabel('x')
   ylabel('y')
   grid on
  
   %den mindre roten
   subplot(2,2,1)
   x=-0.00000000001:0.00000000000001:0.00000000001;
   y=(x.*62)-(((x+0.04+x.^2)./((x.*2)+1)).^7)-((x.*19).*exp(-x));
   plot(x,y)
   xlabel('x')
   ylabel('y')
   grid on

   %hela funktionen för rötter mellan 0 till 5. dvs samtliga possetiva
   %rötter. 
   subplot(2,2,3)
   x=-0.1:0.1:5;
   y=(x.*62)-(((x+0.04+x.^2)./((x.*2)+1)).^7)-((x.*19).*exp(-x));
   plot(x,y)
   xlabel('x')
   ylabel('y')
   grid on

		
	
	
disp('c')
disp('Skriv sedan till MATLAB-kod för att bestämma alla rötterna noggrannt med Newtonsmetod. Alla rötter ska ha ett RELATIVFEL mindre än 10^−8.')

a = input('initiell aproximation:'); 
% 0.1 för den mindre roten och 4 för den större roten
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
while ((abs(a-a1))/(min(abs([a,a1]))))> e 
    %så länge det relativa felet är större än e fortsätter det skapas nya aproxiimationer 
   fa=(a.*62)-(((a+0.04+a.^2)./((a.*2)+1)).^7)-((a.*19).*exp(-a));
   %funktionen y, med variabel a istället för x.
   ga=(14*((a.^2+a+(1/25)).^7)/(2*a+1).^8)-(7*(a^2+a+(1/25)).^6)/(2*a+1)^6-19*exp(-a)+19*a*exp(-a)+62;
   %ga är derivatan av fa

   if ga==0
       %undviker divition med noll, genom att bryta när ga=0
       disp('Divition med noll');
       break;
   end

   b=a-(fa/ga);
  %skapar ny aproximation enligt newtons metod
  fprintf('iteration=%d\ta=%u f(a)=%u\n',iteration,a,fa);
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
disp('Relativa felet:');
disp(((abs(a-a1))/(min(abs([a,a1])))))
disp('roten:');
disp(a);

disp('d')
disp('Hur definieras kvadratisk konvergens för en iterativ metod för ekvationslösning?')
disp('se papper')

disp('e')
disp('Bestäm konvergens-konstanten för den största roten.')
disp('konvergenskonstanten u för respektive itration:')
for i=1:length(E)-2
	% vi tar length(E)-2 för att ekvationen nedan kräver två efterföljande värden i E vektorn.
    % skulle vi ta length(E)-0 skulle konstanten bli =0
u=((abs(E(i+1)-E(length(E)))/(abs(E(i)-E(length(E))))));
fprintf('u%u %u\n',i+1,u);
end
disp('konvergensordningen p för respektive itration:')
for i=1:length(E)-3
    % vi tar length(E)-3 för att ekvationen nedan kräver två efterföljande värden i E vektorn.
    % skulle vi ta length(E)-0 skulle det inte finnas tillräckligt med
    % aproximationer att ta hänsyn till.
    n0=E(i); 
    n1=E(i+1); 
    n2=E(i+2); 
    n3=E(i+3); 
    p=(((log10(abs(n3-n2)))-(log10(abs(n2-n1))))/(log10(abs(n2-n1))-(log10(abs(n1-n0)))));
    fprintf('P%u %u\n',i+2,p);
end
disp('konvergeringskonstanten u efter 15/9 23:59')
    en=abs(E(length(E)-1)-E(length(E)-2));
    en1=abs(E(length(E))-E(length(E)-1)); 
    u=en1/(en.^p);
    disp(u);




