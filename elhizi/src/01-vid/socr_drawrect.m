function socr_drawrect(Cx, Cy, theta, l1, l2, c, isfill)
% function socr_drawrect(cx, cy, theta, l1, l2, c, isfill)
% theta: radian

if nargin < 1, %% test mode
    clc;
    %figure(1), clf;
    oimg = imread('E:\yayin_calismasi\yayin\socr\yazi\resim\yapay_ctx30.bmp');
    imagesc(oimg); axis image; hold on;

    %% Unit tests
    parametre = [200 200 deg2rad(40) 60 100];
    % K = [150 150; 250 150; 250 250; 150 250];
    
    % utn = 2;
    % UNIT_TEST(utn).parametre = parametre;
    % UNIT_TEST(utn).K = K;    
    
    Cx = parametre(1);
    Cy = parametre(2);
    theta = parametre(3);
    l1 = parametre(4);
    l2 = parametre(5);
    c = 'r';
    isfill = true;
end

% <---- l1 --->
%       y
%       ^
% K1 ---A---- K2    ^
% |     |    |      |
% |     |    |      |
%<-----------B-> x  l2
% |     |    |      |
% |     |    |      |
% K3 ---|---- K4    v

% intermediate values
l12 = l1/2;
l22 = l2/2;

A.x = l22 * sin(theta);
A.y = l22 * cos(theta);

% edge koordinates
K1.x = A.x - l12 * cos(theta);
K1.y = A.y + l12 * sin(theta);

K2.x = A.x + l12 * cos(theta);
K2.y = A.y - l12 * sin(theta);

K3.x = K2.x - l2 * cos(pi/2 - theta);
K3.y = K2.y - l2 * sin(pi/2 - theta);

K4.x = K1.x - l2 * cos(pi/2 - theta);
K4.y = K1.y - l2 * sin(pi/2 - theta);

K1.x = Cx + K1.x;   K1.y = Cy - K1.y;
K2.x = Cx + K2.x;   K2.y = Cy - K2.y;
K3.x = Cx + K3.x;   K3.y = Cy - K3.y;
K4.x = Cx + K4.x;   K4.y = Cy - K4.y;

x = [K1.x K2.x K3.x K4.x K1.x];
y = [K1.y K2.y K3.y K4.y K1.y];

if isfill
    fill(x,y, c);
else    
    plot(x, y, c);
end

%% Unit test
% K = [K1.x K1.y; ...
%      K2.x K2.y; ...
%      K3.x K3.y; ...
%      K4.x K4.y];
%  
% unit_test(UNIT_TEST(utn).K, K)
% 
% function bool = unit_test(Kg, Kh)
% fark = abs(Kg - Kh);
% 
% if mean(fark) ~= 0
%     fprintf('Unit test: failed\n');
%     fprintf('Koordinat degerleri: {Beklenen, Hesaplanan}\n');
%     for i = 1:length(Kg)
%         fprintf('i = %d\t([%.1f %.1f], [%.1f %.1f])\n', i, Kg(i, 1), Kh(i, 1), Kg(i, 2), Kh(i, 2));
%     end
% else
%     fprintf('Unit test: success\n');
% end
