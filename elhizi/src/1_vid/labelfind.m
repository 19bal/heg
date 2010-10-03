function [res, F] = labelfind(etiket, ind)
warning off all;
etiket = uint8(etiket);

[r,c,v] = find(etiket == ind );
[m, n]  = size(etiket);
S = sparse(r,c,v, m,n);
F = uint8(full(S));
res = logical(etiket .* F);