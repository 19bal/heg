function msk = rgb2msk(img)
EPSILON = 15;

msk = uint8(zeros(size(img)));

msk((abs(img(:,:,1) - img(:,:,2))<EPSILON) & ...
    (abs(img(:,:,1) - img(:,:,3))<EPSILON) & ...
    (img(:,:,1) < 70))= 255;

msk = boolean(msk(:,:,1));