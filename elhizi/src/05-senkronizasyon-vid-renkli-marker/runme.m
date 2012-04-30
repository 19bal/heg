% video: baslangic ani - renkli marker
clear all;  close all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%s..%s..%slib%s', filesep,filesep,filesep,filesep); %lib path                        %
db_PATH = sprintf('..%s..%s..%s',filesep,filesep,filesep); % database path
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sc = 0.25;
T = 50;

dbg = true;

% dbnm = pathos('_db\orj\');              if ~exist(dbnm), error(sprintf('"%s" dizinini olustur ve test resimlerini bu dizine koy!', dbnm)); end
% dbnm_bw = pathos('_db\bw\');            mkdir(dbnm_bw);
% dbnm_marker = pathos('_db\marker\');    mkdir(dbnm_marker);
dbnm = strcat(db_PATH,pathos('_db/orj/'));              if ~exist(dbnm); error('Bu dizini olustur ve test resimlerini bu dizine koy!'); end
dbnm_bw = strcat(db_PATH, pathos('_db/bw/'));            mkdir(strcat(db_PATH, pathos('_db/bw/')));
dbnm_marker = strcat(db_PATH,pathos('_db/marker/'));    mkdir(strcat(db_PATH,pathos('_db/marker/')));
fnm_bkp_alpha =strcat(db_PATH, pathos('_bkp/renkli_marker_alpha.csv'));     
                                        mkdir(strcat(db_PATH, pathos('_bkp/')));

if length(dir(dbnm_bw)) == 2
    fr2bw(dbnm, dbnm_bw, sc, T, dbg);
end

if length(dir(dbnm_marker)) == 2
    bw2marker(dbnm, dbnm_bw, dbnm_marker, dbg);
end

DIR = dir(strcat(dbnm, '*.png'));
DIR_marker = dir(strcat(dbnm_marker, '*.png'));
sz  = length(DIR);

for f=1:650%sz
    if dbg,
        fprintf('%04d/%04d. frame isleniyor...\n', f,sz);
    end

    imgnm = DIR(f).name;
    fr = imadjustRGB(imread(strcat(dbnm, imgnm)));
    bw_m = imread(strcat(dbnm_marker, imgnm));

    hand = marker_assign(fr, bw_m, dbg);
    alpha(f) = compute_alpha(hand);

    if dbg
        figure(1);
        subplot(121);   imshow(fr)
        subplot(122);   imshow(1 - bw_m)
        hold on;
        plot(hand.index(1), hand.index(2), '*g')
        plot(hand.palm(1),  hand.palm(2),  '*r')
        plot(hand.thumb(1), hand.thumb(2), '*y')
        hold off;
        drawnow;
    end
end

% postprocess
% a) NaN
idx = find(isnan(alpha));
alpha(idx) = alpha(idx-1);

% b) 0
idx = find(alpha==0);
alpha(idx) = alpha(idx-1);

csvwrite(fnm_bkp_alpha, alpha);
if dbg
    figure(2)
    %plot(alpha);
    plot(alpha);    title('renkli marker - acinin degisimi');
    xlabel('zaman (ornek)');     ylabel('\alpha- aci degeri (derece)');
end
