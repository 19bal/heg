function gif_create(dbnm)
% function gif_create(dbnm)
warning off all

DIR = dir(strcat(dbnm, '*.png'));
sz = length(DIR);

figure(1)
for f=1: min(135,sz)
    imgnm = DIR(f).name;    
    fr = imread(strcat(dbnm, imgnm));
    
    if isrgb(fr)
        fr = rgb2gray(fr);
    end
    
    fr  = imresize(fr, [64 NaN]);
    
    imshow(fr);
    drawnow;
    ffrm = getframe();
    [X, map] = rgb2ind(frame2im(ffrm), 256);
    gifIMG(:,:,1,f) = X;
end

imwrite(gifIMG, map, strcat(dbnm,'anim.gif'), 'DelayTime',0,'LoopCount',inf);