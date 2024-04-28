%Fredrik Möller, Johan Kindlundh, SF1514

disp('uppgift1')
disp('a')
disp('Beräkna med matlab vektorn X')
A=[1 2 3 0;0 4 5 6;1 1 -1 0;1 1 1 1];
b=[7;6;5;4];
%Backslashoperatorn löser ekvationsystemet, genom att använda A matrisens invers.  
x=A\b

disp('b')
disp('Beräkna med Matlab residualvektorn')
r=b-A*x;
disp(r)

disp('c')
disp('Varför blir inte residualvektorn r exakt lika med noll?')
disp('r är måttet på felet i lösningen i kombination med den avrundning som datorn gjort. r är i storleksordning 10^-15, vilket motsvarar storleken på dem avrundning som datorn gör.')
