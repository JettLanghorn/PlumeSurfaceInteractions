clear all;clc;close all;

timeconst = 0.2;    %Time constant for the PCB Transducer in s
conv = 4.957;       %Conversion Factor in V/Psi
Pamb = 14.7;        %Ambient Pressure for the Test
LBand = 50;       %Lower frequency limit
HBand = 120;       %Upper frequency limit

Data = readmatrix('CorruptedSine.csv');
Data = Data(12:length(Data), :);

Data(:, 2) = Data(:, 2)/conv;

figure('Name','Pressure change over time (s)');
plot(Data(:,1), Data(:,2));
title('Pressure change over time (s)');
xlabel('Time (s)');
ylabel('Pressure change (psi)');

X = transpose(Data(:,2));
Y = fft(X);
L = length(Data);
Fs = L/(Data(length(Data),1)-Data(1,1));

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;

figure('Name','SSPowerSpectrum');
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")

%Remove afterwards
LBand = round(LBand*L/Fs)+1;
HBand = round(HBand*L/Fs)+1;
Neg = Y;
Neg(1,HBand) = complex(0,0);
Neg(1,LBand) = complex(0,0);
Neg(1,HBand+round(L/2)) = complex(0,0);
Neg(1,L-LBand) = complex(0,0);

%LBand = ceil(LBand*L/Fs)+1;
%HBand = floor(HBand*L/Fs)+1;
%Neg = complex(zeros(1,length(Y)),zeros(1,length(Y)));
%Neg(1,1:LBand) = Y(1,1:LBand);
%Neg(1,L-LBand:L) = Y(1,L-LBand:L);
%Neg(1,HBand:(L/2)+1) = Y(1,HBand:(L/2)+1);
%Neg(1,(L/2)+1:HBand) = Y(1,(L/2)+1:HBand);

N = ifft(Neg);
figure('Name','Reconstructed Negative Signal');
plot(Data(:,1), N) 
title('Reconstructed Negative Signal')
xlabel('Time (s)')
ylabel('Pressure change (psi)')

Fin = Data(:,2)-transpose(Neg);
figure('Name','Processed Signal');
plot(Data(:,1), Fin);
title('Processed Signal')
xlabel('Time (s)')
ylabel('Pressure change (psi)')