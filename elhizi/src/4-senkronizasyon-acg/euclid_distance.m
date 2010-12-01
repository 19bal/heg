function h = euclid_distance(A, B)
%function h = euclid_distance(A, B)
%   A ve B noktalarinin euclid mesafesi
% 
% Input:
%   A, B: structure turunde, elemanlari (X,Y,Z)
% Output:
%   h: hesaplanan hipotenus degeri
% 
% Example:
%   A.X = 0; A.Y = 0;   A.Z = 0
%   B.X = 5; B.Y = 0;   B.Z = 0;
%   hipotenus(A, B)

deltaX = abs(A.X - B.X);
deltaY = abs(A.Y - B.Y);

% if isfield(A, 'Z')
%     deltaZ = abs(A.Z - B.Z);
%     h = sqrt(deltaX.^2 + deltaY.^2 + deltaZ.^2);
% else
    h = sqrt(deltaX.^2 + deltaY.^2);
% end
