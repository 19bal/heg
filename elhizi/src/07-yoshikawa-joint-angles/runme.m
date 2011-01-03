% yoshikawa06 nin gerceklemesi buraya

% yontem: `help tsmovavg`
% CC: `help cceps`

clear all;  close all;  clc;

dbg = true;

% 0-
Sr = 1000;              % Hz: FIXME: orjinal *.acg dosyasindan okunacak
K =  1e-3;              % mV: FIXME: dikey eksen carpani, *.acg den okunacak

% 1-
dbnm = 'emg.data';
load(dbnm);             % "emg" degiskeni olarak yukler

Ns = size(emg, 1);
t = (1:Ns) / Sr;

% 2- yoshikawa06
y = emg(:, 1)';          % ilk kanali (acma kanali) signali

FS = 0.5 * 64e-3 * Sr;        % yoshikawa06: 64ms secmisti fakat Sr=2000Hz
FL = 0.5 * 16e-3 * Sr;        

v = tsmovavg2(y, FS, FL, dbg);

if dbg
    figure(1),
    subplot(311),   plot(t, K * emg(:,1));     
                        title('kanal 1: acma');     
                        xlabel('t (sn)');   ylabel('A (mV)');
                        xlim([min(t) max(t)]);
    subplot(312),   plot(t, K * emg(:,2));     
                        title('kanal 2: kapama');   
                        xlabel('t (sn)');   ylabel('A (mV)');
                        xlim([min(t) max(t)]);
    subplot(313),   plot(v);
                        title('IEMG');   
                        xlabel('t (sn)');   ylabel('A (mV)');
                        xlim([min(t) max(t)]);    
end
