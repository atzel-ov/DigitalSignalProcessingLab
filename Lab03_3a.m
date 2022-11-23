%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ASKHSH 3

%a


clear;
close all;
clc;


fs = 10000;
f_pass = 3000;
f_stop = 5000;
wp = 2*pi*f_pass;
ws = 2*pi*f_stop;
delta_p = 3;
delta_s = 30;           %Here we change attenuation between 30db and 50 db 

[N,wc] = buttord(wp,ws,delta_p,delta_s,'s');

[z,p,k] = buttap(N);

[num, den] = zp2tf(z,p,k);

[num1,den1] = lp2lp(num,den,wc);

f = linspace(0,fs/2,2048);


H_analog = freqs(num1,den1,2*pi*f);

[num2,den2] = bilinear(num1,den1,fs);

H_discrete = freqz(num2,den2,f,fs);



%xc1 = 1 + cos(1000*t) + cos(16000*t) + cos(30000*t);    %fmax = 4775 Hz

N = 500;

n = 0:N-1;

fs = 10000;     % > 2fmax = 9550
Ts = 1/fs;

x1 = 1 + cos(1000*n*Ts) + cos(16000*n*Ts) + cos(30000*n*Ts);

f = -fs/2:fs/N:fs/2-fs/N;

X1 = fftshift(abs(fft(x1)));

x1_butterworth = filter(num2,den2,x1);

X1_butterworth = fftshift(abs(fft(x1_butterworth)));

figure
stem(f,X1)
hold on 
stem(f,X1_butterworth,"red")
title('Fourier transform of x & x_f')
xlabel('Frequency (Hz)')
ylabel('Magnitude |X|')
