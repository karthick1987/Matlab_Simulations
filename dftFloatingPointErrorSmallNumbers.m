A=0.5;%Amplitude
fc=10;%frequency of the cosine wave
phase=30; %desired phase shift of the cosine in degrees
fs=32*fc;%sampling frequency with oversampling factor 32
t=0:1/fs:2-1/fs;%2 seconds duration
 
phi = phase*pi/180; %convert phase shift in degrees in radians
x=A*cos(2*pi*fc*t+phi);%time domain signal with phase shift

N=256; %FFT size
X = 1/N*fftshift(fft(x,N));%N-point complex DFT

f = t(1:N);
subplot(2,1,1)
plot(f,real(X(1:N))); %plot the signal

subplot(2,1,2)
plot(f,abs(imag(X(1:N)))); %plot the signal

X2=X;%store the FFT results in another array
%detect noise (very small numbers (eps)) and ignore them
threshold = max(abs(X))/10000; %tolerance threshold
X2(abs(X)<threshold) = 0; %maskout values that are below the threshold
phase=atan2(imag(X2),real(X2))*180/pi; %phase information
plot(f,phase); %phase vs frequencies