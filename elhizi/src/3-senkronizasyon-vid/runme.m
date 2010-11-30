% video: baslangic ani
clear all;  close all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%s..%s..%slib%s', filesep,filesep,filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = false;

dbnm = pathos('_db/orj/');          % bu dizine db resimlerini koy!
dbnm_sel = pathos('_db/sel/');      mkdir(dbnm_sel);

DIR = dir(strcat(dbnm, '*.png'));

[ts, te] = extract_extreme_time(DIR, dbnm, dbg);

if length(dir(dbnm_sel)) == 2
    sel_frame(DIR, dbnm, dbnm_sel, ts, te, dbg);
end

DIR = dir(strcat(dbnm_sel, '*.png'));
sz  = length(DIR);
for f=1:sz
    imgnm = DIR(f).name;    
    fr = imread(strcat(dbnm_sel, imgnm));
    
    % extract marker
    % compute alpha
    
    if dbg
        figure(1);  imshow(fr)
        drawnow;
    end
end
