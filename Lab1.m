%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Askisi 1

%A

clear;
close all;
clear all;
clc;


nx = [-10:10];

x = sinc((pi/6)*nx);

figure
stem(nx,x)
title("First signal of our choice")
xlabel('n')
ylabel('x[n]')

nh = [-10:10];

h = (nh>=-8)-(nh>=8);

figure
stem(nh,h)
title("Second signal of our choice")
xlabel('n')
ylabel('h[n]')

Lx = length(x);
Lh = length(h);
nconv = Lx + Lh -1

Lconv = nx(1)+nh(1):nx(end)+nh(end)

z = zeros(1,nconv);

for i = 0:nconv
  for j = 0:nconv
    
    if((i-j+1)>0 && (i-j+1)<=Lh && (j+1)<=Lx)
      z(i+1) = z(i+1) + x(j+1).*h(i-j+1);
    end 
  end
end

figure
stem(Lconv,z)
title("Convolution without using conv function")
xlabel('n')
ylabel('z[n]')

z1 = conv(x,h);

figure
stem(Lconv,z1)
axis([-20 20])
title("Convolution using conv function")
xlabel('n')
ylabel('z[n]')


%B

clear;
close all;
clear all;
clc;

n = [-10:10];

x=n.*(n>=0);
h=exp(3.*n);

z = conv(x,h);

nconv = 2*n(1):2*n(end);

figure
stem(nconv,z)
title("Convolution of x[n] & h[n]")
xlabel('n')
ylabel('z[n]')


%Finding Fourier Transformaion
X = fft(x,length(nconv));
H = fft(h,length(nconv));

Z = X.*H;

z_test = ifft(Z);

figure
stem(nconv,z_test);
title("Convolution of x[n] & h[n] using multiplication of their FT ")
xlabel('n')
ylabel('z[n]')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%Askisi 2

clear;
close all;
clear all;
clc;


DT = 0.0001;
t = 0:DT:0.5;

x = 5*cos(24*pi*t) - 2*sin(1.5*pi*t); %% f1max = 12 Hz

%a)
 
Ts1 = 1/48; 
t1 = 0:Ts1:0.5;

x1 = 5*cos(24*pi*t1) - 2*sin(1.5*pi*t1);

figure
plot(t,x)
hold on
stem(t1,x1)
title("Sampling at 48 Hz")  %% fs > 2*12 Hz -- Success
xlabel('n')
ylabel('x[n]')

%b)

Ts2 = 1/24; 
t2 = 0:Ts2:0.5;

x2 = 5*cos(24*pi*t2) - 2*sin(1.5*pi*t2);

figure
plot(t,x)
hold on
stem(t2,x2)
title("Sampling at 24 Hz")  %% fs = 2*12 Hz -- Success, Nyquist frequency
xlabel('n')
ylabel('x[n]')

%c)

Ts3 = 1/12; 
t3 = 0:Ts3:0.5;

x3 = 5*cos(24*pi*t3) - 2*sin(1.5*pi*t3);

figure
plot(t,x)
hold on
stem(t3,x3)
title("Sampling at 12 Hz")  %%fs < 2*12 -- Fail. Aliasing
xlabel('n')
ylabel('x[n]')

%The sampled signal is completely different from the one we need to get.%

%Now we will set our own sampling frequency

Ts4 = 1/192; 
t4 = 0:Ts4:0.5;

x4 = 5*cos(24*pi*t4) - 2*sin(1.5*pi*t4);

figure
plot(t,x)
hold on
stem(t4,x4)
title("Sampling at 192 Hz")
xlabel('n')
ylabel('x[n]')

%As we sample in bigger frequencies the DT signal we get approaches the signal we sample from.

Ts5 = 1/52;       %Team 52
t5 = 0:Ts5:0.5;

x5 = 5*cos(24*pi*t5) - 2*sin(1.5*pi*t5);

figure
plot(t,x)
hold on
stem(t5,x5)
title("Sampling at 52 Hz")
xlabel('n')
ylabel('x[n]')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%Askisi 3

%a)

clear;
clear all;
close all;
clc;


N = 128;

DT = 0.0001;
t = 0:DT:1;

xc = 10*cos(40*pi*t) - 4*sin(80*pi*t + 5);

Fs = 128;
Ts = 1/Fs;  %128 > 2*fmax = 2*40 Hz 

n = 0:N-1;

x = 10*cos(40*pi*n*Ts) - 4*sin(80*pi*n*Ts + 5);

figure
subplot(2,1,1)
plot(t,xc)
title("Continuous signal")
xlabel('t')
ylabel('x(t)')
subplot(2,1,2)
stem(n,x)
axis([0 130])
title("Sampling of our signal")
xlabel('n')
ylabel('x[n]')

F = (-Fs/2):(Fs/N):((Fs/2)-(Fs/N));

X = fftshift(abs(fft(x)));

figure
stem(F,X)
axis([-70 70])
xlabel('F')
ylabel('|X|')


%b)

clear;
clear all;
close all;
clc;

for f0 = 100:125:475
  Fs = 8000;
  Ts = 1/Fs;
  N = 128;
  n = 0:N-1;
  x = sin(2*pi*f0*n*Ts + 52);   %Team 52
  
  figure
  stem(n,x)
  
  F = (-Fs/2):(Fs/N):((Fs/2)-(Fs/N));

  X = fftshift(abs(fft(x)));

  figure
  stem(F,X)
  axis([-70 70])
  xlabel('F') 
  ylabel('|X|') 
end  



clear;
clear all;
close all;
clc;

for f0 = 7525:125:7900
  Fs = 8000;
  Ts = 1/Fs;
  N = 128;
  n = 0:N-1;
  x = sin(2*pi*f0*n*Ts + 52);   %Team 52
  
  figure
  stem(n,x)
  
  F = (-Fs/2):(Fs/N):((Fs/2)-(Fs/N));

  X = fftshift(abs(fft(x)));

  figure
  stem(F,X)
  axis([-70 70])
  xlabel('F') 
  ylabel('|X|') 
end  