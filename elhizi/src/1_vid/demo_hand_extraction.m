% Demo Hand Extraction
% close all;  clear all;  clc;

shwHSV = true;
shwBW  = false;
shwBW2 = false;
shwRect = false;
shwHnd = true;
shwHndHSV = false;

% dbnm = strcat(DB_ROOT(), 'emg/1hand_extraction/')
dbnm = '../../../../db/';
DIR = dir(strcat(dbnm, '*.png'));
sz =length(DIR);
nm = ['H', 'S', 'V'];

while(1)
for i=1:sz,
    imgnm = DIR(i).name;
    img = imread(strcat(dbnm, imgnm));
    
    hsv = rgb2hsv(img);
    %% <-- Test
    H = hsv(:,:,1); V = hsv(:,:,2); S = hsv(:,:,3);
    mnH = 0.9265;   mnV = 0.7184;   mnS = 0.5380;
    ESIK = 0.4;
    [r,c,v] = find( abs(H - mnH) < ESIK & abs(S - mnS) < ESIK & abs(V - mnV) < ESIK );
    [m, n]  = size(H);
    Sp = sparse(r,c,v, m,n);
    F = (uint8(full(Sp)));
    tmp = img .* cat(3, F, F, F);
    figure(99); subplot(121),imshow(img); subplot(122),imagesc(tmp);axis image;
    continue
    %% -->
    if shwHSV
        figure(1);  subplot(221);   imshow(img);    colorbar;   title(imgnm);

        for j=1:3
            subplot(2,2,j+1);   imagesc(hsv(:,:,j));  axis image;  colorbar;    title(nm(j));
        end
    end
    
    % Img --> Hand extract
    bw = img2hand(hsv);

    if shwBW
        figure(2);  %subplot(221);   imshow(img); title(imgnm);

        for j=1:3
            subplot(2,2,j);   imshow(bw(:,:,j));   title(nm(j));
        end    

        subplot(2,2,4); imshow(and( bw(:,:,1), bw(:,:,2)));  title('AND(H, S)');
    end
        
    % Isle
    bw = img2hand(hsv, true);
    maske = and( bw(:,:,1), bw(:,:,2));
    
    if shwBW2
        figure(3);  %subplot(221);   imshow(img); title(imgnm);

        for j=1:3
            subplot(2,2,j);   imagesc(bw(:,:,j));   title(nm(j));
        end            
        subplot(2,2,4); imshow(maske);  title('AND(H, S)');
    end
    
    lbl = bwlabel( maske );
    % compute parameters
    s = regionprops(lbl, {'majoraxislength', 'minoraxislength'});
    [majAL, ind] = sort(cat(1, s.MajorAxisLength),'descend');
    minAL = sort(cat(1, s.MinorAxisLength),'descend');
    
    oran = majAL(1) / minAL(1);
    ESIK = 2.0;
    
    % draw rect
    if shwRect
        res = labelfind(lbl, ind(1)); 
        [theta, xc, yc, l1, l2] = socr_equivalent_rectangle(res);
        figure(4);    imshow(res); %axis image;
        hold on;
           socr_drawrect(xc,yc,theta,l1,l2,'r', false);
        hold off;
    end
    
    maske = uint8(maske);
    hand = img .* cat(3, maske, maske, maske);
    
    if shwHnd
        figure(5);
        subplot(121),   imshow(img);
        subplot(122),   imshow(hand);
        
        if oran < ESIK, title(['KAPALI. (Oran' num2str(oran) ')']);
        else,           title(['ACIK.   (Oran' num2str(oran) ')']);
        end
    end
    
    hand_hsv = rgb2hsv(hand);
    if shwHndHSV
        figure(6);  subplot(221);   imshow(hand);    colorbar;   title(imgnm);

        for j=1:3
            subplot(2,2,j+1);   imagesc(hand_hsv(:,:,j));  axis image;  colorbar;    title(nm(j));
        end
    end
    
    pause(.5);
end
end