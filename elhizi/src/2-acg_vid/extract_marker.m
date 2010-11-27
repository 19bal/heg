function markers = extract_marker(rgb, dbg)
% function markers = extract_marker(rgb, dbg)

renk = [0.98, 0.686, 0.902];
markers.palm = extract_renk(rgb, renk);

renk = [0.42, 0.694, 0.569];
markers.index = extract_renk(rgb, renk);

renk = [0.14, 0.57, 0.961];
markers.thumb = extract_renk(rgb, renk);

renk = [0.59, 0.0824, 0.949];
markers.mihenk = extract_renk(rgb, renk, true);

if dbg,
    figure(99), imshow(rgb)
    hold on;
    plot(markers.palm.X,     markers.palm.Y,  'y*')
    plot(markers.thumb.X,    markers.thumb.Y, 'r*')
    plot(markers.index.X,    markers.index.Y, 'k*')
    plot(markers.mihenk.X,   markers.mihenk.Y,'k*')
    hold off;
end

function coord = extract_renk(rgb, renk, isMihenk)
% "rgb" goruntusunden "renk" rengine sahip marker "coord" ini
% dondurur.
if nargin < 3,
    isMihenk = false;
end
dbg = false;

hsv = rgb2hsv(rgb);

 H = hsv(:,:,1);     S = hsv(:,:,2);     V = hsv(:,:,3);
cH = renk(1);       cS = renk(2);       cV = renk(3);

% maskeyi bul
EPS = 0.1;

[r, c, v] = find( abs(H - cH) < EPS & ...
                  abs(S - cS) < EPS & ...
                  abs(V - cV) < EPS );
[m, n] = size(H);
Sp = sparse(r,c,v,m,n);
F = boolean(full(Sp));

bw1 = dilation(F,  17, 'elliptic');
bw2 = erosion(bw1, 17, 'elliptic');

bw = boolean(bw2);
L = bwlabel(bw);

s = regionprops(L,  {'eccentricity', 'centroid', 'area'});
eccentricities = cat(1, s.Eccentricity);
centroids = cat(1, s.Centroid);
areas = cat(1, s.Area);

% cember olmayanlari ele
ind = find(eccentricities < 0.8);
eccentricities = eccentricities(ind);
centroids = centroids(ind, :);
areas = areas(ind);

% alani cok kucuk olanlari da ele
ind = find(areas > 10);
eccentricities = eccentricities(ind);
centroids = centroids(ind, :);
areas = areas(ind);

% alana gore sirala
[t, ind] = sort(areas, 'descend');
eccentricities = eccentricities(ind);
centroids = centroids(ind, :);
areas = areas(ind);

if isMihenk,
    coord.X = centroids(:,1);
    coord.Y = centroids(:,2);
else
    coord.X = centroids(1,1);
    coord.Y = centroids(1,2);
end
