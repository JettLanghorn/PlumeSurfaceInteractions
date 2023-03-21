clear all;clc;close all;

timeconst = 0.2;    %Time constant for the PCB Transducer in seconds
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
Pos = complex(zeros(1,1501),0);
Pos(1,HBand) = Y(1,HBand);
Pos(1,LBand) = Y(1,LBand);
Pos(1,L-HBand) = Y(1,HBand);
Pos(1,L-LBand) = Y(1,LBand);

%LBand = ceil(LBand*L/Fs)+1;
%HBand = floor(HBand*L/Fs)+1;
%Neg = complex(zeros(1,length(Y)),zeros(1,length(Y)));
%Neg(1,1:LBand) = Y(1,1:LBand);
%Neg(1,L-LBand:L) = Y(1,L-LBand:L);
%Neg(1,HBand:(L/2)+1) = Y(1,HBand:(L/2)+1);
%Neg(1,(L/2)+1:HBand) = Y(1,(L/2)+1:HBand);

N = ifft(Pos);
figure('Name','Reconstructed Positive Signal');
plot(Data(:,1), N) 
title('Reconstructed Negative Signal')
xlabel('Time (s)')
ylabel('Pressure change (psi)')

Y = fft(N);
L = length(Data);
Fs = L/(Data(length(Data),1)-Data(1,1));

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;

figure('Name','SSPosPowerSpectrum');
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of PosX(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")