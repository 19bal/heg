function [alpha] = compute_alpha(hand)
%function [alpha] = compute_alpha(hand)
%   "hand" uzerindeki uc noktadan alpha yi hesapla
% 
% Yontem:
%   Palm, Thumbe ve Index kullanilarak 3B duzlemde acisal 
%   degisim hesaplanir.
% 
% Referans:
% 
% 1. http://en.wikipedia.org/wiki/Law_of_cosines
% 
% 2. AcceleGlove FAQ
%    Q: What is the sampling rate of the AcceleGlove?
%    A: The maximum sampling rate is 35Hz (630 axes per second).

a = euclid_distance(hand.thumb, hand.index);
b = euclid_distance(hand.thumb, hand.palm);
c = euclid_distance(hand.palm , hand.index);

alpha = rad2deg(acos( (b.^2 + c.^2 - a.^2) ./ (2 * b .* c)));

% alpha = filtering(alpha, 20);

% SAMPLE_RATE = 35;
% deltaT = 1 / SAMPLE_RATE;
% acisal_hiz = gradient(alpha) / deltaT;
