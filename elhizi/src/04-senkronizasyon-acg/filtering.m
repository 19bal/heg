function y = filtering(data, WS)
flt = ones(1,WS)/WS;
y = filter(flt, 1, data);
