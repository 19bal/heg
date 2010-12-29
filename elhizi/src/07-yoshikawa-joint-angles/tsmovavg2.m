function y = tsmovavg2(x, FS, FL, dbg);
% function y = tsmovavg2(x, FS, FL, dbg);

% get indices of each sliding window
idx = bsxfun(@plus, (1:FS)', 0:FL:length(x)-FS);

% hamming penceresinden gecir
H = hamming(FS);
xw = x(idx) .* repmat(H, 1, size(idx, 2));

y = mean(xw, 1);




% 
% 
% 
% t = (0:.001:1)';                                %#'
% vector = sin(2*pi*t) + 0.2*randn(size(t));      %# time series
% 
% wndw = FS;                                      %# sliding window size
% 
% %# get indices of each sliding window
% idx = bsxfun(@plus, (1:wndw)', 0:FL:length(vector)-wndw);
% %'# compute average of each
% output3 = mean(vector(idx),1);
% 
% subplot(121),   plot(vector)
% subplot(122),   plot(output3)