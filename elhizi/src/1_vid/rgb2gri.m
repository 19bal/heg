function gri = rgb2gri(img)
EPSILON = 20;

gri = uint8(zeros(size(img)));

gri((abs(img(:,:,1) - img(:,:,2))<EPSILON) & (abs(img(:,:,1) - img(:,:,3))<EPSILON) & (img(:,:,1) < 100))= 255;

gri = boolean(gri(:,:,1));