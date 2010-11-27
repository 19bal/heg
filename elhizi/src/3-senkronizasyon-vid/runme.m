% video: baslangic ani
clear all;  close all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%s..%s..%slib%s', filesep,filesep,filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dbg = true;

dbnm = pathos('_db/orj/');

DIR = dir(strcat(dbnm, '*.png'));
sz = length(DIR);

fr_p = -1;             % previous frame
fi = 210:270;
for f = fi,
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f).name;    
    fr = imread(strcat(dbnm, imgnm));

    fr = rgb2gray(fr);
    fr = imresize(fr, [128 NaN]);
    fr = medfilt2(fr, [3 3]);
%     fr = imadjust(fr);
    %fr = edge(fr, 'canny', [], 4);

    if fr_p == -1
        fr_p = fr;
        continue;
    end
    
    fark = uint8(abs(double(fr) - double(fr_p)));  
    
    mse_f(f) = mean(fark(:).^2);
    
    if dbg
        figure(1);            
            subplot(221),   imshow(fr_p),       title('onceki');
            subplot(222),   imshow(fr),         title('simdiki');
            subplot(223),   imshow(fark),       title('fark');
        drawnow;
    end    
    fr_p = fr;
end

figure(2),  
plot(fi, mse_f(fi)),        grid on;
xlabel('Frame indisi'),     ylabel('J-Amac islevi');
title('Baslangic aninin bulunmasi');
