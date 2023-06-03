;

clc;
clear;
close all;

% Log-distance or Log-normal Shadowing Path Loss model
% Input
%       fc    : carrier frequency[Hz]
%       d     : between base station and mobile station[m]
%       d0    : reference distance[m]
%       n     : path loss exponent, n
%       sigma : variance[dB]
% output
%       PL    : path loss[dB]


fc = 1.5e9;
d0 = 100;
sigma = 3;
distance = [1:2:31].^2;
Gt = [1 1 0.5];
Gr = [1 0.5 0.5];
Exp = [2 3 6]; 
lamda = 299792458/fc;

PL = -20*log10(lamda/(4*pi*d0)) + 10*Exp(1)*log10(distance/d0);

fprintf('PL: %d\n', PL);


