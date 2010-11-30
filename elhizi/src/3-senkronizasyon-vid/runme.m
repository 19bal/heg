% video: baslangic ani
clear all;  close all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%s..%s..%slib%s', filesep,filesep,filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm = pathos('_db/orj/');          % bu dizine db resimlerini koy!
dbnm_sel = pathos('_db/sel/');      mkdir(dbnm_sel);
dbnm_bw = pathos('_db/bw/');        mkdir(dbnm_bw);

if length(dir(dbnm_sel)) == 2
    DIR = dir(strcat(dbnm, '*.png'));
    [ts, te] = extract_extreme_time(DIR, dbnm, dbg);
    sel_frame(DIR, dbnm, dbnm_sel, ts, te, dbg);
end

if length(dir(dbnm_bw)) == 2
    fr2bw(dbnm_sel, dbnm_bw, 0.25, 50, true);
end

DIR = dir(strcat(dbnm, '*.png'));
DIR_bw = dir(strcat(dbnm_bw, '*.png'));
sz  = length(DIR_bw);

for f=1:sz
    if dbg,
        fprintf('%04d/%04d. frame isleniyor...\n', f,sz);
    end
    
    imgnm = DIR_bw(f).name;    
    bw = imread(strcat(dbnm_bw, imgnm));
    fr = imread(strcat(dbnm, imgnm));

    % extract marker

    % compute alpha

    if dbg
        figure(1);  
        subplot(121);   imshow(fr)
        subplot(122);   imshow(bw)
        drawnow;
    end
end
