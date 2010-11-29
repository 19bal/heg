function hand = img2hand(img, isfill)
if nargin < 2,  isfill   = false;   end

for i=1:3
    lvl = graythresh(img(:,:,i));
    bw = im2bw(img, lvl);
    
    if isfill,      bw = imfill(bw, 'holes');       end
    % bw = ordfilt2(bw, 70, true(5));
    dip_initialise('silent');
    bw = uint8(dilation(bw,7,'elliptic'));
    bw = uint8(erosion(bw,7,'elliptic'));   bw = uint8(erosion(bw,7,'elliptic'));
    bw = uint8(dilation(bw,7,'elliptic'));  bw = uint8(dilation(bw,7,'elliptic'));  bw = uint8(dilation(bw,7,'elliptic'));
    hand(:,:,i) = bw;
end