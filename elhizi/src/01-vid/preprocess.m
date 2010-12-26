function res = preprocess(img)
dip_initialise('silent');

a = dip_image(img);
b = berosion(a,1,-1,1);
% b = berosion(b,1,-1,1);

c = bdilation(b,1,-1,0);
c = bdilation(c,1,-1,0);

d = fillholes(c);

res = uint8(c);