%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%ASKHSH 1

clear;
close all;
clc;

%b
num = [0 0.2 0];
den = [1 -0.7 -0.18];

zeros = roots(num);
poles = roots(den);

figure
zplane(zeros,poles)

%d
xd = -pi:pi/128:pi;

figure
freqz(num,den,xd);

figure
freqz(num,den);

%e
clear;
close all;
clc;

num = [0 0 0.2 0];
den = [1 -1.7 0.52 0.18];

zeros = roots(num);
poles = roots(den);

figure
zplane(zeros,poles)

xe = -pi:pi/128:pi;

figure
freqz(num,den,xe);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%ASKHSH 2

clear;
close all;
clc;

%a
syms z;

num = [4 -3.5 0];
den = [1 -2.5 1];

zeros = roots(num);
poles = roots(den);

A = residuez(num,den);

h = A(1)/(1-2*z^(-1)) + A(2)/(1-0.5*z^(-1));

pretty(h)

%b
iztrans(h)