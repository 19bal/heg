function sel_frame(DIR, dbnm, dbnm_sel, ts, te, dbg)
% function sel_frame(DIR, dbnm, dbnm_sel, ts, te, dbg)
% 
% sellected frame: kamera onune perde konuldugu ve cekildigi
% zaman araligina ait kareler secilir.
%
% IN: _db/orj/ klasoru altindaki karelerden ts-te araligini
% OUT: _db/sel/ klasoruna kopyala

for f=ts:te
    imgnm = DIR(f).name;    
    fr = imread(strcat(dbnm, imgnm));
    
    imwrite(fr, strcat(dbnm_sel, imgnm));
    if dbg
        figure(1);  imshow(fr)
        drawnow;
    end
end
