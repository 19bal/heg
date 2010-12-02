function markers = marker_assign(fr, bw_m, dbg);
% function markers = marker_assign(fr, bw_m, dbg);

pat_index = [0 1 0];
pat_thumb = [1 1 0];
pat_palm  = [1 0 0];

bw_m3 = cat(3, bw_m,bw_m,bw_m);
fr_m = fr .* uint8(bw_m3);

L = bwlabel(bw_m);

% marker assign name
for m=1:3
    t = ismember(L, m);
    tmp = fr .* uint8(cat(3, t,t,t));

    % % maske alti ortalama
    for c=1:3
        x = tmp(:,:,c);
        xv = x(:);
        ind = find(xv);
        ort(m, c) = mean(xv(ind));
    end
end        

s = regionprops(L, 'centroid');
centroid = cat(1, s.Centroid);

mn = mean(ort,2);    
ort_bw = (ort > repmat(mn, [1 3]));

[t, mi] = max(sum( (ort_bw == repmat(pat_index, [size(ort_bw, 1) 1]))' ));
markers.index = centroid(mi, :);

[t, mi] = max(sum( (ort_bw == repmat(pat_palm, [size(ort_bw, 1) 1]))' ));
markers.palm = centroid(mi, :);

[t, mi] = max(sum( (ort_bw == repmat(pat_thumb, [size(ort_bw, 1) 1]))' ));
markers.thumb = centroid(mi, :); 