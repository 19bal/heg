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
        figure(1),   plot(acg.samples, acg.palm.X, 'r', ...
                          acg.samples, acg.palm.Y, 'g', ...
                          acg.samples, acg.palm.Z, 'b');
                            title('palm');      legend('X','Y','Z');
        figure(2),   plot(acg.samples, acg.thumb.X, 'r', ...
                          acg.samples, acg.thumb.Y, 'g', ...
                          acg.samples, acg.thumb.Z, 'b');                            
                            title('thumb');     legend('X','Y','Z');
        figure(3),   plot(acg.samples, acg.index.X, 'r', ...
                          acg.samples, acg.index.Y, 'g', ...
                          acg.samples, acg.index.Z, 'b');                            
                            title('index');     legend('X','Y','Z');
                            
        figure(4),   plot(acg.samples, alpha, 'r');  title('Alpha (degree/sample)');        
    end
end