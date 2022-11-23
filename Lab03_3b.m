%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ASKHSH 3

%b

clear;
close all;
clc;

N2 = 16;

wc = 2;
Ts = 0.2;
fs = 1/Ts;
delta_p = 3;

fc = wc/(2*pi);     %rad/s -> Hz

fk = fc/(fs/2);     %analog -> digital

w = 0:1/256:1-1/256;

[b2,a2] = cheby1(N2,delta_p,fk,'high');

H_discrete1 = freqz(b2,a2,256);


N = 500;

n = 0:N-1;

x2 = 1 + cos(1.5*n*Ts) + cos(5*n*Ts);

f = -fs/2:fs/N:fs/2-fs/N;

X2 = fftshift(abs(fft(x2)));

x2_chebyshev = filter(b2,a2,x2);

X2_chebyshev = fftshift(abs(fft(x2_chebyshev)));


figure
stem(f,X2)
hold on
stem(f,X2_chebyshev,"red")
title('Fourier transform of x & x_f')
xlabel('Frequancy (Hz)')
ylabel('Magnitude |X|')