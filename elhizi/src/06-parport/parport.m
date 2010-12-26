% paralel port test
clear all;  close all;  clc;

% Asama 1: hw info
daqhwinfo('parallel')

% Asama 2: 
% a) port open
dio = digitalio('parallel', 'lpt1')

% b) assign direction
hline = addline(dio, 0:7, 'Out')

% Asama 3: 
for i=1:10
    putvalue(dio, 1);
    pause(1)

    putvalue(dio, 0);
    pause(1)
end