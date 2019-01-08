function [ f ] = polyharmonic( freqs, t, Tend )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
f=0;
for i=1:1:length(freqs)
    f=f+sqrt(0.05*(normpdf(log10(freqs(i)),0,0.4)))*sin(2*pi*freqs(i)*t);
end
f=f.*heaviside(Tend-t);
end

