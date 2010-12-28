% yoshikawa06 nin gerceklemesi buraya

% yontem: `help tsmovavg`
% CC: `help cceps`

clear all;  close all;  clc;

dbg = true;

Sr = 1000;              % Hz: FIXME: orjinal *.acg dosyasindan okunacak
K =  1e-3;              % mV: FIXME: dikey eksen carpani, *.acg den okunacak

dbnm = 'emg.data';
load(dbnm);             % "emg" degiskeni olarak yukler

Ns = size(emg, 1);
t = (1:Ns) / Sr;

if dbg
    figure(1),
    subplot(211),   plot(t, K * emg(:,1));     
                        title('kanal 1: acma');     
                        xlabel('t (sn)');   ylabel('A (mV)');
                        xlim([min(t) max(t)]);
    subplot(212),   plot(t, K * emg(:,2));     
                        title('kanal 2: kapama');   
                        xlabel('t (sn)');   ylabel('A (mV)');
                        xlim([min(t) max(t)]);
end
