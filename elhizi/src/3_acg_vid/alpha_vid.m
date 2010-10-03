% VID - Alpha Hesaplama
clear all;  close all;  clc;
dbg = true;

dbnm = dos2lin(strcat(DB_ROOT(), 'emg/6_acg_vid_renkli_marker/png/'));

dip_initialise('silent');
DIR = dir([dbnm '*.png']);
sz = length(DIR);

for i=1:sz
    img = imread(strcat(dbnm, DIR(i).name));      
    
    markers = extract_marker(img, dbg);
    alpha = compute_alpha(markers);
    fprintf('Alpha = %.4f\n', alpha);
end

