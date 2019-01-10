function [ freqs,amps ] = fft_amps( dt, signal)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Fs=1/dt;
Y=fft(signal);
P2=abs(Y/length(signal));
P1=P2(1:length(signal)/2+1);
P1(2:end-1)=2*P1(2:end-1);
freqs=Fs*(0:(length(signal)/2))/length(signal);
amps=P1;
freqs=freqs';
end

