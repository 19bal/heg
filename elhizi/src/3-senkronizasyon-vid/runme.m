% video: baslangic ani
clear all;  close all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%s..%s..%slib%s', filesep,filesep,filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = false;

dbnm = pathos('_db/orj/');
dbnm_sel = pathos('_db/sel/');

DIR = dir(strcat(dbnm, '*.png'));

[ts, te] = extract_extreme_time(DIR, dbnm, dbg);

if length(dir(dbnm_sel)) == 2
    sel_frame(DIR, dbnm, dbnm_sel, ts, te, dbg);
end

