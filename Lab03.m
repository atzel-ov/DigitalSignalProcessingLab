%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ASKHSH 1

clear;
close all;
clc;


fs = 10000;
f_pass = 3000;
f_stop = 5000;
wp = 2*pi*f_pass;
ws = 2*pi*f_stop;
delta_p = 3;
delta_s = 50;           %Here we change attenuation between 30db and 50 db 

[N,wc] = buttord(wp,ws,delta_p,delta_s,'s');

[z,p,k] = buttap(N);

[num, den] = zp2tf(z,p,k);

[num1,den1] = lp2lp(num,den,wc);

f = linspace(0,fs/2,2048);


H_analog = freqs(num1,den1,2*pi*f);

[num2,den2] = bilinear(num1,den1,fs);

H_discrete = freqz(num2,den2,f,fs);



figure
plot(f, mag2db(abs(H_analog)))
hold on
plot(f,mag2db(abs(H_discrete)),"red")
axis([0 5000 -300 10])
title('Butterworth lowpass filter')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
grid on



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ASKHSH 2

clear; 
close all;
clc;


N1 = 2;
N2 = 16;

wc = 2;
Ts = 0.2;
fs = 1/Ts;
delta_p = 3;

fc = wc/(2*pi);     %rad/s -> Hz

fk = fc/(fs/2);     %analog -> digital

w = 0:1/256:1-1/256;

[b1,a1] = cheby1(N1,delta_p,fk,'high');

H_discrete1 = freqz(b1,a1,256);

[b2,a2] = cheby1(N2,delta_p,fk,'high');

H_discrete2 = freqz(b2,a2,256);

figure
plot(w,mag2db(abs(H_discrete1)))
hold on
plot(w,mag2db(abs(H_discrete2)),"red")
axis([0 1 -210 10])
title('Chebyshev Higpass filter, N1-blue, N2-red')
xlabel('Normalized frequency (rad/sample)')
ylabel('Magnitude (dB)')
grid on