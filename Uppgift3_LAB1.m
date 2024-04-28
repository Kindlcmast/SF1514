clc
%Fredrik Möller, Johan Kindlundh, SF1514

format long
disp('Uppgift3')

disp('a')
disp('kriv ett Matlab-program som bestämmer rötterna till ekvationen i föregående upp-gift med sekantmetoden och samma noggrannhet.')
b=input('övre aproximation: ');
a=input('undre aproximation: ');
%i sekantmetoden krävs två initiella aproximationer, a och b
fa=(a.*62)-(((a+0.04+a.^2)./((a.*2)+1)).^7)-((a.*19).*exp(-a));
fb=(b.*62)-(((b+0.04+b.^2)./((b.*2)+1)).^7)-((b.*19).*exp(-b));
%fa och fb är funktionen med repsektive variabel 
iteration=1;
%itration ökar med +1 för varje loop/itration när itration=n (200) bryts loopen.
n=200;
%n motsvarar antal iterationer som maximalt ska genomföras.
e=10^-8;
%e motsvarar det maximala tillåtna relativfelet
E=[b];
%i matris E sparas samtliga aproximationer. 

%Sekantmetoden0
while ((abs(b-a))/(min(abs([a,b]))))>e
    %så länge det relativa felet är större än e fortsätter det skapas nya aproximationer
    fa=(a.*62)-(((a+0.04+a.^2)./((a.*2)+1)).^7)-((a.*19).*exp(-a));
    fb=(b.*62)-(((b+0.04+b.^2)./((b.*2)+1)).^7)-((b.*19).*exp(-b));
    if fb-fa==0
         %undviker divition med noll, genom att bryta när när nämnaren fb-fa=0
        disp('Divition med noll');
        break;
    end
    c=(b-(((b-a)*fb)/(fb-fa)));
    %aproximerar ny rot (c)
    iteration=iteration+1;
    %antal utförda itrationer
    fprintf('a=%u b=%u fb=%u f(a)=%u\n',a,b,fb,fa);
    a=b;
    b=c;
    %nästa aproximation tilldelas ett värde och föregående tilldelas till a
    E=[E,b];
    %uppdaterar matris E med ett till värde på b
    if iteration==n
      %bryter vid 200ande iterationen
      disp(' 200 itrationer genomförda, konvergerar ej med detta startvärde till kravsatt relativfel');
      break;
    end
end 
disp('Relativa felet:');
disp(((abs(b-a))/(min(abs([a,b])))))
disp('roten:');
disp(b);

disp('b');
disp('ad blev rötterna? Blir det samma värden?')
disp('se papper')   

disp('c')
disp('Hurdan konvergens har sekantmetoden enligt teorin?')
disp('se papper')

disp('d')
disp('Visa att ditt program har sådan konvergens. Vad blir konvergens-konstanten?')

disp('Konvergenskonstanten u för respektive itration:');
for i=1:length(E)-2
	% vi tar length(E)-2 för att ekvationen nedan kräver två efterföljande värden i E vektorn.
    % skulle vi ta length(E)-0 skulle konstanten bli =0
    
u=((abs(E(i+1)-E(length(E)))/(abs(E(i)-E(length(E))))));
fprintf('u%u %u\n',i+1,u);
end
disp('konvergensordning p för respektive itration: ')
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
disp('konvergeringskonstanten u efter 15/9 23.59')
    en=abs(E(length(E)-1)-E(length(E)-2));
    en1=abs(E(length(E))-E(length(E)-1)); 
    u=en1/(en.^p);
    disp(u);
   