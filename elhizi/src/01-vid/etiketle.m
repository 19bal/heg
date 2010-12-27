function [referans, A,B,C, theta, aciSol, aciSag] = etiketle(msk)

% istenmeyen (?:kucuk ebatlilar) ogeleri ele
se = strel('disk',3);
msk = imdilate(msk, se);
se = strel('disk',3);
msk = imerode(msk, se);
% % figure(2), imagesc(msk)

L = bwlabel(msk);

RGB = label2rgb(L);   

s  = regionprops(L, {'centroid', 'area', 'eccentricity'});
centroids     = cat(1, s.Centroid);
areas         = cat(1, s.Area);
eccentiricity = cat(1, s.Eccentricity);

% % alani kucuk olanlari ele
% ind = find(areas > 100);
% centroids     = centroids(ind, :);
% areas         = areas(ind);
% eccentiricity = eccentiricity(ind);

% cembersel olmayanlari ele
ind = find(eccentiricity < 0.9);
centroids = centroids(ind, :);
areas     = areas(ind);

ind = find(centroids(:,1) < 150);
if length(ind) > 3, disp('fazla referans nokta bulundu');   end

referans = centroids(ind,:);

ind = find(centroids(:,1) > 150);
if length(ind) > 3, 
    %disp('Fazla kose nokta bulundu');   
    alan = areas(ind);
    
    [y, ii] = sort(alan, 'descend');
    ii = ii(1:3);
    ind = ind(ii);
end

kosenokta = centroids(ind,:);

% % Bilek yukarida
%          A (theta)
%          ^
%         / \
% (alfa) /   \
%     B <-----> C (beta)

% % Bilek sagda
% 
%    B (alfa)
%    ^
%    | \ 
%    |  > A (theta)
%    v / 
%    C (beta)

[mn, indA] = max(kosenokta(:,1));
A = kosenokta(indA, :);

[mn, indB] = max(kosenokta(:,2));
B = kosenokta(indB, :);

ind = 1:3;
indC = ind(ind ~= indA & ind ~= indB);
C = kosenokta(indC, :);

hold on
% plot(referans(:,1), referans(:,2),  'b*')
plot(kosenokta(:,1),kosenokta(:,2), 'r*')

[theta, aciSol, aciSag] = hizcikart(A, B, C);


plot(A(:,1),A(:,2), 'r*');  text(A(:,1)+10, A(:,2)  , 'A');
plot(B(:,1),B(:,2), 'r+');  text(B(:,1)   , B(:,2)+10, 'B');
plot(C(:,1),C(:,2), 'rd');  text(C(:,1)   , C(:,2)-10, 'C');

plot_arrow(A(1), A(2), B(1), B(2), 'linewidth', 5, 'headwidth', .1, 'headheight', .1,'color', [1 0 0], 'facecolor', [1 0 0]);
plot_arrow(A(1), A(2), C(1), C(2), 'linewidth', 5, 'headwidth', .1, 'headheight', .1,'color', [1 0 0], 'facecolor', [1 0 0]);

text(A(:,1), A(:,2)-60, sprintf('Theta = %.2f', theta))
hold off
