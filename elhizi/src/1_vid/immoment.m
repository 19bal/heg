function [mm] = immoment(img, method)
% function [mm] = socr_image_moment(img, method)

if nargin < 2
    method = 'my';
end

%% 
[sa, su] = size(img);
[xx, yy] = meshgrid(1:su, 1:sa);

%% Babu's method
if strcmp(method, 'babu')
    xx = xx - mean(xx(:));
    yy = -(yy - mean(yy(:)));
end

%% Compute image moments
tmp = img;
mm(1, 1) = sum(tmp(:));

tmp = xx .* img;
mm(2, 1) = sum(tmp(:));

tmp = yy .* img;
mm(1, 2) = sum(tmp(:));

tmp = xx .* yy .* img;
mm(2, 2) = sum(tmp(:)); % mu_xy

tmp = xx.^2 .* img;
mm(3, 1) = sum(tmp(:)); % mu_xx

tmp = yy.^2 .* img;
mm(1, 3) = sum(tmp(:)); % mu_yy


%% TODO
% Freeman98 makalesinde: "Computer Vision for Interactive Computer
% Graphics". sayfa 43'deki Horn yöntemiyle momentlerin daha hýzlý
% hesaplanmasý söz konusu.
% Bunun icin Vertical-Horizontal-Diagonal momentler hesaplaniyor.



