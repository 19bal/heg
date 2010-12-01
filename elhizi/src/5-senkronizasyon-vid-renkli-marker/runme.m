% video: baslangic ani - renkli marker
clear all;  close all;  clc;

%%%%%%%%%%%%%%%% D O   N O T   E D I T   M E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LIB_PATH = sprintf('..%s..%s..%slib%s', filesep,filesep,filesep,filesep);                         %
addpath(LIB_PATH,'-end');                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sc = 0.25;
T = 50;

minDist = 30;
maxDist = 325;

dbg = true;

dbnm = pathos('_db/orj/');              % bu dizine db resimlerini koy!
dbnm_bw = pathos('_db/bw/');            mkdir(dbnm_bw);
dbnm_marker = pathos('_db/marker/');    mkdir(dbnm_marker);

if length(dir(dbnm_bw)) == 2
    fr2bw(dbnm, dbnm_bw, sc, T, dbg);
end

DIR = dir(strcat(dbnm, '*.png'));
DIR_bw = dir(strcat(dbnm_bw, '*.png'));
sz  = length(DIR_bw);

fi = 1:sz;
for f=fi
    if dbg,
        fprintf('%04d/%04d. frame isleniyor...\n', f,sz);
    end
    
    imgnm = DIR_bw(f).name;    
    bw = imread(strcat(dbnm_bw, imgnm));
    fr = imread(strcat(dbnm, imgnm));

    % extract marker
    bw2 = imerode(bw, strel('disk',20));
    bw3 = cat(3, bw2,bw2,bw2);
    fr_m = fr .* uint8(bw3);

    % % fr_m->bw
    b = (fr_m > 100);
    bb = max(max(b(:,:,1), b(:,:,2)), b(:,:,3));
    
    % % temizlik
    te = imerode(bb, strel('square', 8));
    td = imdilate(te, strel('square', 8));
    
    % % markerlari sec
    L = bwlabel(td);
    s = regionprops(L, {'centroid', 'eccentricity', 'area'});

    % % % ilk
    centroid = cat(1, s.Centroid);
    eccentricity = cat(1, s.Eccentricity);
    area = cat(1, s.Area);
    
    % % % centroid: birbirinden cok uzak olmasin
    resim_merkezi = size(td)/2;
    ed = euclid_distance(centroid, resim_merkezi)';
    idx = find((ed > minDist) & (ed < maxDist));
    
    % % % eccentricity: 0 a yakin olanlar
    ii = find((eccentricity(idx) < 0.70) & ...
               (area(idx) > 350) & (area(idx) < 650) );
    tmp_ecc = eccentricity(ii);
    [t, iii] = sort(tmp_ecc);
    idx = idx(ii(iii));
           
    % % % area: benzer alanlilar
    if length(idx) > 3        
        tmp_area = area(idx);
        [sa, ids] = sort(tmp_area);
        fark = diff(sa);
        [t, ida] = sort(fark);
        ida = ida + 1;

        ii = unique([ida(1) ida(1)-1 ida(2) ida(2)-1]);
        idx = idx(ids(ii));
    end
    
    if length(idx) < 3
        error('3 den az marker bulundu.');
    else
        idx = idx(1:3);
    end
    
    bw_m = ismember(L, idx);
    imwrite(bw_m, strcat(dbnm_marker, imgnm));
    
    % compute alpha

    if dbg
        figure(1);  
        subplot(121);   imshow(td)
        subplot(122);   imshow(bw_m)
        drawnow;
    end
end
