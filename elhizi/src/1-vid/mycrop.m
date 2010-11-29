function [imgc, skipit] = mycrop(img)
dip_initialise('silent');
skipit = false;

msk = zeros(size(img));
hsv = rgb2hsv(img);
S = hsv(:,:,2);
msk(S > 0.4*max(S(:))) = 1;

a = dip_image(boolean(msk(:,:,1)));

b = berosion(a,4,-1,1);
c = bdilation(b,5,-1,0);

msk = boolean(c);

L = bwlabel(msk);
tmp = regionprops(L, {'area', 'boundingbox'});
areas = cat(1, tmp.Area);
bbox  = cat(1, tmp.BoundingBox);

[mx, ind] = max(areas);
if mx < 1000,   % alani asiri kucuk bir sorun var!
    skipit = true;
    imgc = img;
    return;
end

bbox = bbox(ind, :);

bbox(1:2) = bbox(1:2) * .2;
bbox(3:4) = bbox(3:4) * 5;
bbox(3) = min(bbox(3), size(img, 2));
bbox(4) = min(bbox(4), size(img, 1));

imgc = imcrop(img, bbox);
imshow(imgc);