function sel_frame(DIR, dbnm, dbnm_sel, ts, te, dbg)
% function sel_frame(DIR, dbnm, dbnm_sel, ts, te, dbg)

for f=ts:te
    imgnm = DIR(f).name;    
    fr = imread(strcat(dbnm, imgnm));
    
    imwrite(fr, strcat(dbnm_sel, imgnm));
    if dbg
        figure(1);  imshow(fr)
        drawnow;
    end
end