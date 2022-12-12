%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%ASKHSH 1

clear;
close all;
clc;

Wc = 0.4*pi;
fc = Wc/(2*pi);
Fs = 100;

Wn = fc/(Fs/2);

N = 21;

rectangle_window = fir1(N-1, Wn, rectwin(N));

hamming_window = fir1(N-1, Wn, hamming(N));

[h1,w1] = freqz(rectangle_window);

[h2,w2] = freqz(hamming_window);

figure
plot(w1,abs(h1))
hold on 
plot(w2,abs(h2), "red")
title('Rectangle-Hamming')
xlabel('Frequency')
ylabel('Magnitude')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ASKHSH 2

clear;
close all;
clc;

%--------%

Wc = 0.5*pi;
Fs = 100;

fc = Wc/(2*pi);

Wn = fc/(Fs/2);

N1 = 21;
N2 = 41;

%a)
hamming_window1 = fir1(N1-1, Wn, hamming(N1));  

[h11,w11] = freqz(hamming_window1);

%b)
hamming_window2 = fir1(N2-1, Wn, hamming(N2));
[h12,w12] = freqz(hamming_window2);

%c)
hanning_window1 = fir1(N1-1, Wn, hanning(N1));
[h21,w21] = freqz(hanning_window1);

%d)
hanning_window2 = fir1(N2-1, Wn, hanning(N2));
[h22,w22] = freqz(hanning_window2);

figure
subplot(1,2,1)
plot(w11,mag2db(abs(h11)))
hold on
plot(w21,mag2db(abs(h21)),"red")
title('Hamming-Hanning, order 20')
xlabel('Frequency')
ylabel('Magnitude(dB)')
subplot(1,2,2)
plot(w12,mag2db(abs(h12)))
hold on
plot(w22,mag2db(abs(h22)),"red")
title('Hamming-Hanning, order 40')
xlabel('Frequency')
ylabel('Magnitude(dB)')


%--------%

Ts = 1/Fs;

N = 500;
n = 0:N-1;

x = sin(15*n*Ts) + 0.25*sin(200*n*Ts);      %Fmax = 200/2pi = 31.83 < Fs/2 = 50. We do not have aliasing


f = -Fs/2:Fs/N:Fs/2-Fs/N;

X = fftshift(abs(fft(x)));


%Hamming and Hanning of order 20

x_hammingO20 = filter(hamming_window1, 1, x);   %FIR filters do NOT have any poles

X_hammingO20 = fftshift(abs(fft(x_hammingO20)));

x_hanningO20 = filter(hanning_window1, 1, x);

X_hanningO20 = fftshift(abs(fft(x_hanningO20)));


%Hamming and Hanning of order 40

x_hammingO40 = filter(hamming_window2, 1, x);

X_hammingO40 = fftshift(abs(fft(x_hammingO40)));

x_hanningO40 = filter(hanning_window2, 1, x);

X_hanningO40 = fftshift(abs(fft(x_hanningO40)));


figure
stem(f,X)
hold on
stem(f,X_hammingO20,"red")
title('Order 20 Hamming on x[n]')
xlabel('Frequency (Hz)')
ylabel('Magnitude |X|')

figure
stem(f,X)
hold on
stem(f,X_hanningO20,"red")
title('Order 20 Hanning on x[n]')
xlabel('Frequency (Hz)')
ylabel('Magnitude |X|')

figure
stem(f,X)
hold on
stem(f,X_hammingO40,"red")
title('Order 40 Hamming on x[n]')
xlabel('Frequency (Hz)')
ylabel('Magnitude |X|')

figure
stem(f,X)
hold on
stem(f,X_hanningO40,"red")
title('Order 40 Hanning on x[n]')
xlabel('Frequency (Hz)')
ylabel('Magnitude |X|')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
close all;
clc;

%--------%

Wc = 0.5*pi;
Fs = 50;

fc = Wc/(2*pi);

Wn = fc/(Fs/2);

N1 = 21;
N2 = 41;

%a)
hamming_window1 = fir1(N1-1, Wn, hamming(N1));  

[h11,w11] = freqz(hamming_window1);

%b)
hamming_window2 = fir1(N2-1, Wn, hamming(N2));
[h12,w12] = freqz(hamming_window2);

%c)
hanning_window1 = fir1(N1-1, Wn, hanning(N1));
[h21,w21] = freqz(hanning_window1);

%d)
hanning_window2 = fir1(N2-1, Wn, hanning(N2));
[h22,w22] = freqz(hanning_window2);

figure
subplot(1,2,1)
plot(w11,mag2db(abs(h11)))
hold on
plot(w21,mag2db(abs(h21)),"red")
title('Hamming-Hanning, order 20')
xlabel('Frequency')
ylabel('Magnitude(dB)')
subplot(1,2,2)
plot(w12,mag2db(abs(h12)))
hold on
plot(w22,mag2db(abs(h22)),"red")
title('Hamming-Hanning, order 40')
xlabel('Frequency')
ylabel('Magnitude(dB)')


%--------%

Ts = 1/Fs;

N = 500;
n = 0:N-1;

x = sin(15*n*Ts) + 0.25*sin(200*n*Ts);      %Fmax = 200/2pi = 31.83 > Fs/2 = 25. Aliasing occurs


f = -Fs/2:Fs/N:Fs/2-Fs/N;

X = fftshift(abs(fft(x)));


%Hamming and Hanning of order 20

x_hammingO20 = filter(hamming_window1, 1, x);

X_hammingO20 = fftshift(abs(fft(x_hammingO20)));

x_hanningO20 = filter(hanning_window1, 1, x);

X_hanningO20 = fftshift(abs(fft(x_hanningO20)));


%Hamming and Hanning of order 40

x_hammingO40 = filter(hamming_window2, 1, x);

X_hammingO40 = fftshift(abs(fft(x_hammingO40)));

x_hanningO40 = filter(hanning_window2, 1, x);

X_hanningO40 = fftshift(abs(fft(x_hanningO40)));


figure
stem(f,X)
hold on
stem(f,X_hammingO20,"red")
title('Order 20 Hamming on x[n]')
xlabel('Frequency (Hz)')
ylabel('Magnitude |X|')

figure
stem(f,X)
hold on
stem(f,X_hanningO20,"red")
title('Order 20 Hanning on x[n]')
xlabel('Frequency (Hz)')
ylabel('Magnitude |X|')

figure
stem(f,X)
hold on
stem(f,X_hammingO40,"red")
title('Order 40 Hamming on x[n]')
xlabel('Frequency (Hz)')
ylabel('Magnitude |X|')

figure
stem(f,X)
hold on
stem(f,X_hanningO40,"red")
title('Order 40 Hanning on x[n]')
xlabel('Frequency (Hz)')
ylabel('Magnitude |X|')





















