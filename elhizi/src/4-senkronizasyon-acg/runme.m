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

% analiz: PCA
X = [acg.index.X' acg.palm.X' acg.thumb.X'];
Y = [acg.index.Y' acg.palm.Y' acg.thumb.Y'];
Z = [acg.index.Z' acg.palm.Z' acg.thumb.Z'];

data = [X; Y; Z];
model = pca(data, 2);

plot3(acg.index.X', acg.index.Y',   acg.index.Z',   'r*', ...
      acg.palm.X',  acg.palm.Y',    acg.palm.Z',    'g*', ...
      acg.thumb.X', acg.thumb.Y',   acg.thumb.Z',   'b*');

  grid on;        legend('index', 'palm', 'thumb');
  xlabel('X');    ylabel('Y');    zlabel('Z');

% PCA vektorlerini ciz 
hold on
G = 100;    ofset = 100;

v = ofset + G * model.W';
v = [[ofset ofset ofset]; v(1,:); [ofset ofset ofset]; v(2,:)]

plot3(v(1:2, 1), v(1:2, 2), v(1:2, 3), 'k', v(3:4, 1), v(3:4, 2), v(3:4, 3), 'k');
hold off



