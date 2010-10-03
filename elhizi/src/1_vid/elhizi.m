% El Hizi Cikarimi
clear all;  close all;  clc;
dbg = true;
dbnm = dos2lin(strcat(DB_ROOT(), 'emg/hiz/db/'));
% dbnm = 'db/EMG_el_Hizi/dbAVI/';
% cdir = pwd;
% cd(dbnm);
% !ffmpeg -i test2.avi frame%d.png
% % duration?
% !ffmpeg -i test2.avi 2>&1 | grep "Duration" | cut -d ' ' -f 4 | sed s/,// > tmp.txt
% fid = fopen('tmp.txt');
% dur = textscan(fid, '%d%d%f','Delimiter', ':');
% fclose(fid);
% cd(cdir);

dip_initialise('silent');
DIR = dir([dbnm '*.png']);
sz = length(DIR);

fig1 = figure(1);
winsize = get(fig1,'Position');
winsize(1:2) = [0 0];  
set(fig1,'NextPlot','replacechildren')

for i=1:sz
    img = imread(strcat(dbnm, DIR(i).name));
    if dbg,
        subplot(221),    imagesc(img);  title('Giris');
    end
        
    [imgc, skipit] = mycrop(img);
    if skipit,  
        warning('crop edilen resim boyutu oldukca kucuk. O yuzden skip ediyorum!'); 
        continue,   
    end
    
    msk = rgb2msk(imgc);
    msk = preprocess(msk);  
        
    maske = cat(3, msk,msk,msk);
    if dbg,
        subplot(222),   imagesc(double(maske)); title('Maske');
    end
    
    maske_alti = imgc .* uint8(1-maske);
    if dbg,
        subplot(223),   imagesc(maske_alti);    title('Maske Alti');
    end
    
    if dbg, 
        subplot(224),   imagesc(imgc); title('Crop edilmis');
    end

    [referans, A,B,C, theta, aciSol, aciSag] = etiketle(msk);   
    
    if dbg,
        fprintf('Aci (deg) = %.4f, Sol ve sag aciklik (deg) = %.4f, %.4f\n', theta, aciSol, aciSag);
    end    
    
    drawnow;
    %myMOVIE(i)=getframe(fig1,winsize); 
    %pause()
end

% movie2avi(myMOVIE, strcat(dbnm, 'sonuc.avi'));

% Testing



%     a = dip_image(imgc);    
%     
%     b = medif(a,7,'elliptic');
%     b = medif(b,7,'elliptic');
%     b = medif(b,7,'elliptic');
%     
%     
%     [b,thres] = threshold(b,'fixed',70)
