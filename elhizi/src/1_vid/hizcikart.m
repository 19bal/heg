function [theta, aciSol, aciSag] = hizcikart(A, B, C);

aa = sqrt(sum( (C - B).^2) );
bb = sqrt(sum( (C - A).^2) );
cc = sqrt(sum( (A - B).^2) );

theta = acos( (bb^2 + cc^2 - aa^2) / (2*bb*cc) );
alfa  = acos( (aa^2 + cc^2 - bb^2) / (2*aa*cc) );
beta  = acos( (aa^2 + bb^2 - cc^2) / (2*aa*bb) );

aciSol = (pi/2) - alfa;
aciSag = (pi/2) - beta;

theta  = rad2deg(theta);
aciSol = rad2deg(aciSol);
aciSag = rad2deg(aciSag);