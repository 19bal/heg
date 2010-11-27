% ACG - Alpha Hesaplama
clear all;  close all;  clc;
dbg = true;

fnm = dos2lin(strcat(DB_ROOT(), 'emg/6_acg_vid_renkli_marker/o_ns01.acg'));

acg = extract_acg(fnm, dbg);

alpha = compute_alpha(acg);

if dbg,
    subplot(411),   plot(acg.samples, [(acg.palm.X - 200),  (acg.palm.Y),   (acg.palm.Z + 200)]);    
                        title(strcat('palm::', hash_code()));      legend('X','Y','Z');
    subplot(412),   plot(acg.samples, [(acg.thumb.X - 200), (acg.thumb.Y), (acg.thumb.Z + 200)]);    
                        title('thumb');     legend('X','Y','Z');
    subplot(413),   plot(acg.samples, [(acg.index.X - 200), (acg.index.Y), (acg.index.Z + 200)]);    
                        title('index');     legend('X','Y','Z');
    subplot(414),   plot(acg.samples, alpha, 'r');  title('Alpha (degree/sample)');
    
    [pathstr, name, ext, versn] = fileparts(fnm);
    saveas_with_hashcode(gcf, name);
end
