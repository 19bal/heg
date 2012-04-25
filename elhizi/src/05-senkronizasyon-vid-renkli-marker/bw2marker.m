function bw2marker(dbnm, dbnm_bw, dbnm_marker, dbg)
% function bw2marker(dbnm, dbnm_bw, dbnm_marker, dbg)
% uc adet marker iceren bw resmi elde eder, db (dbnm_marker) ye koyar

minDist = 10;
maxDist = 325;

DIR = dir(strcat(dbnm, '*.png'));
DIR_bw = dir(strcat(dbnm_bw, '*.png'));
sz  = length(DIR_bw);

fi = 1:sz;
for f=650%fi
    if dbg,
        fprintf('%04d/%04d. frame isleniyor...\n', f,sz);
    end
    
    imgnm = DIR_bw(f).name;    
    bw = imread(strcat(dbnm_bw, imgnm));
    fr = imread(strcat(dbnm, imgnm));
   
    % extract marker
    bw2 = imerode(bw, strel('disk',20)); %IM2 = imerode(IM,SE) erodes the grayscale, binary, or packed binary image IM, returning the eroded image IM2
    bw3 = cat(3, bw2,bw2,bw2);
    fr_m = fr .* uint8(bw3);

    % % fr_m->bw
    b = (fr_m > 100);
    bb = max(max(b(:,:,1), b(:,:,2)), b(:,:,3));
    
    % % temizlik
    te = imerode(bb, strel('square', 8));
    td = imdilate(te, strel('square', 8));
    
    % % markerlari sec
    L = bwlabel(td);	%td komþuluðuna göre etiketleme yapar
    s = regionprops(L, {'centroid', 'eccentricity', 'area'});%etiketlenen L matrisinin merkez, alan, eccentricity 'ini hesaplar

    % % % ilk
    centroid = cat(1, s.Centroid);
    eccentricity = cat(1, s.Eccentricity);
    area = cat(1, s.Area);
    
    % % % centroid: birbirinden cok uzak olmasin
    resim_merkezi = size(td)/2;
    ed = euclid_distance(centroid, resim_merkezi)';
    idx = find((ed > minDist) & (ed < maxDist)); %bu þartlarý saðlayan elemanýn matris numarasýný verir
    
    % % % eccentricity: 0 a yakin olanlar
    ii = find((eccentricity(idx) < 0.70) & ...
               (area(idx) > 350) & (area(idx) < 650) );
    tmp_ecc = eccentricity(ii);
    [t, iii] = sort(tmp_ecc);
    idx = idx(ii(iii));
           
    % % % area: benzer alanlilar
    if length(idx) > 3        
        tmp_area = area(idx); % alanlarý çizer    
        [sa, ids] = sort(tmp_area); %küçükten büyüðe sýralar
        fark = diff(sa);% sa dizisindeki komþu elemanlarýn arasýndaki farklarý hesaplar
        [t, ida] = sort(fark);
        ida = ida + 1;

        ii = unique([ida(1) ida(1)-1 ida(2) ida(2)-1]); % dizi içerisineki benzer elemanlarý bir defa döndürür tekrarlananlarý döndürmez
        idx = idx(ids(ii));
    end
    
    if length(idx) < 3
        error('3 den az marker bulundu.');
    else
        idx = idx(1:3);
    end
    
    bw_m = ismember(L, idx);%idx içerisinde  L matrisinin elemanlarý varsa o elemanlarýn yerine logic 1 döndürür yoksa logic 0 döndürür
    imwrite(bw_m, strcat(dbnm_marker, imgnm));
    
    % compute alpha

    if dbg
        figure(1);  
        subplot(121);   imshow(td)
        subplot(122);   imshow(bw_m)
        drawnow;
    end
end
