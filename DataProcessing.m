clear all;clc;close all;

timeconst = 0.2;    %Time constant for the PCB Transducer in seconds
conv = 4.957;       %Conversion Factor in V/Psi
Pamb = 14.7;        %Ambient Pressure for the Test
LBand = 50;       %Lower frequency limit, currently the desired frequency
HBand = 120;       %Upper frequency limit, currently the desired frequency

%Importing csv data, using the conversion factor, and plotting the signal
Data = readmatrix('TEK00008.CSV');
Data = Data(12:length(Data), :);
Data(:, 2) = Data(:, 2)/conv;
figure('Name','Pressure change over time (s)');
plot(Data(:,1), Data(:,2));
title('Pressure change over time (s)');
xlabel('Time (s)');
ylabel('Pressure change (psi)');

%Manipulating the voltage data, decomposing the signal, and constructing
%single-sided and double sided power spectrums
X = transpose(Data(:,2));
decomposedSignal = fft(X);
signalLength = length(Data);
samplingFreq = signalLength/(Data(length(Data),1)-Data(1,1));
powerSpectrum2 = abs(decomposedSignal/signalLength);
powerSpectrum1 = powerSpectrum2(1:signalLength/2+1);
powerSpectrum1(2:end-1) = 2*powerSpectrum1(2:end-1);
frequencySpectrum = samplingFreq*(0:(signalLength/2))/signalLength;

%Plotting the single-sided power spectrum
figure('Name','SSPowerSpectrum');
plot(frequencySpectrum,powerSpectrum1) 
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")

%Isolating the desired frequencies
LBand = round(LBand*signalLength/samplingFreq)+1;
HBand = round(HBand*signalLength/samplingFreq)+1;
Pos = complex(zeros(1,1501),0);
Pos(1,HBand) = decomposedSignal(1,HBand);
Pos(1,LBand) = decomposedSignal(1,LBand);
Pos(1,signalLength-HBand) = decomposedSignal(1,HBand);
Pos(1,signalLength-LBand) = decomposedSignal(1,LBand);

%Used for salvaging bands of signals.  Inapplicable for the example.
%LBand = ceil(LBand*L/Fs)+1;
%HBand = floor(HBand*L/Fs)+1;
%Neg = complex(zeros(1,length(Y)),zeros(1,length(Y)));
%Neg(1,1:LBand) = Y(1,1:LBand);
%Neg(1,L-LBand:L) = Y(1,L-LBand:L);
%Neg(1,HBand:(L/2)+1) = Y(1,HBand:(L/2)+1);
%Neg(1,(L/2)+1:HBand) = Y(1,(L/2)+1:HBand);

%Reconstructing the positive signal and plot it
reconstructedSignal = ifft(Pos);
figure('Name','Reconstructed Positive Signal');
plot(Data(:,1), reconstructedSignal) 
title('Reconstructed Positive Signal')
xlabel('Time (s)')
ylabel('Pressure change (psi)')

%Performing a spectral analysis of the reconstructed signal
decomposedSignal = fft(reconstructedSignal);
signalLength = length(Data);
samplingFreq = signalLength/(Data(length(Data),1)-Data(1,1));
powerSpectrum2 = abs(decomposedSignal/signalLength);
powerSpectrum1 = powerSpectrum2(1:signalLength/2+1);
powerSpectrum1(2:end-1) = 2*powerSpectrum1(2:end-1);
frequencySpectrum = samplingFreq*(0:(signalLength/2))/signalLength;
figure('Name','SSReconstuctedPowerSpectrum');
plot(frequencySpectrum,powerSpectrum1) 
title("Reconstructed Signal Single-Sided Amplitude Spectrum")
xlabel("f (Hz)")
ylabel("|P1(f)|")
