function fr2bw(dbnm_sel, dbnm_bw, sc, T, dbg);
% function fr2bw(dbnm_sel, dbnm_bw, sc, T, dbg)
%   sc: yuzde olarak
%   T: deger olarak

dip_initialise('silent');

DIR = dir(strcat(dbnm_sel, '*.png'));
sz  = length(DIR);

for f=1:sz
    if dbg,
        fprintf('%04d/%04d. frame isleniyor...\n', f,sz);
    end
    
    imgnm = DIR(f).name;    
    fr = imread(strcat(dbnm_sel, imgnm));
    
    % preprocess    
    fr = preprocess(fr, sc);
    
    % maske
    bw = (rgb2gray(fr) < T);
    a = dip_image(bw);
    a = bopening(a,5,-1,0);    
    maske = boolean(a);

    maske = imresize(maske, 1/sc);
    fr    = imresize(fr, 1/sc);

        
    if dbg
        figure(1);  
        subplot(121);   imshow(fr)
        subplot(122);   imshow(maske)
        drawnow;
    end

    imwrite(maske, strcat(dbnm_bw, imgnm));    
end