% acg: baslangic ani
clear all;  close all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%s..%s..%slib%s', filesep,filesep,filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm = pathos('_db/');

DIR = dir(strcat(dbnm, '*.acg'));
sz = length(DIR);

for f = 1:sz,
    fprintf('acg %04d/%04d isleniyor ...\n', f, sz);

    ffnm = strcat(dbnm, DIR(f).name);
    
    [acg] = extract_acg(ffnm, dbg);
    alpha = compute_alpha(acg);
    
    if dbg
        figure(1),   plot(acg.samples, [(acg.palm.X - 200),  (acg.palm.Y),   (acg.palm.Z + 200)]);    
                            title('palm');      legend('X','Y','Z');
        figure(2),   plot(acg.samples, [(acg.thumb.X - 200), (acg.thumb.Y), (acg.thumb.Z + 200)]);    
                            title('thumb');     legend('X','Y','Z');
        figure(3),   plot(acg.samples, [(acg.index.X - 200), (acg.index.Y), (acg.index.Z + 200)]);    
                            title('index');     legend('X','Y','Z');
        figure(4),   plot(acg.samples, alpha, 'r');  title('Alpha (degree/sample)');        
    end
end