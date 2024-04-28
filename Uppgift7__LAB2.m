%Fredrik möller och Johan Kindlundh
clc
clear all
disp('uppgift7')
y=@(x) 149*(exp(-((((11*x)-pi)/(0.003)).^2)));
A=0;
B=6;
TOL=10^(-10);
QUAD=quad(y,A,B,TOL)
INTEGRAL=integral(y,A,B,'AbsTol',TOL)

disp('efter uppstyckning:')
A=0;
B=0.28;
QUAD1=quad(y,A,B,TOL);
INTEGRAL1=integral(y,A,B,'AbsTol',TOL);
A=0.28;
B=0.29;
QUAD2=quad(y,A,B,TOL);
INTEGRAL2=integral(y,A,B,'AbsTol',TOL);
A=0.29;
B=6;
QUAD3=quad(y,A,B,TOL);
INTEGRAL3=integral(y,A,B,'AbsTol',TOL);

QUAD=QUAD3+QUAD1+QUAD2
INTEGRAL=INTEGRAL3+INTEGRAL1+INTEGRAL2
%----------------------------------------------------------------------------------
disp('b')
disp('integrering kring punkten pi/11 ger tillräcklig noggrannhet')
A=0.28;
B=0.29;
QUAD2=quad(y,A,B,TOL)
INTEGRAL2=integral(y,A,B,'AbsTol',TOL)
