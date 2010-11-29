function [theta, xc, yc, l1, l2] = socr_equivalent_rectangle(img, ...
            debug_on) 
% function [theta, xc, yc, l1, l2] = socr_equivalent_rectangle(img, ...
%             debug_on) 

% compute image moment
mm = immoment(img);

% position or center
xc = mm(2, 1) / mm(1, 1);
yc = mm(1, 2) / mm(1, 1);

% intermediate value
a = mm(3, 1) / mm(1, 1) - xc^2;
b = 2 * (mm(2, 2) / mm(1, 1) - xc * yc);
c = mm(1, 3) / mm(1, 1) - yc^2;

% orientation angle
theta = atan2(b, (a - c)) / 2;

% dimensions
ac = (a + c);
d = sqrt(b^2 + (a - c)^2);

l1 = sqrt((ac + d) / 2);
l2 = sqrt((ac - d) / 2);

% % % ADT antibiyotik etiketlemeye ozgu kisitlama
% % % KISIT: dikey boyut, yatay olanindan daha buyuk olmali
% % % Buna gore aciyi ve uzunluklari guncelle.
% % if l1 > l2
% %     theta = theta - deg2rad(90);
% %     tmp = l2;
% %     l2 = l1;
% %     l1 = tmp;
% % end

% theta = socr_angle_postcorrection(img, theta, debug_on, ...
%         'EqRect');
