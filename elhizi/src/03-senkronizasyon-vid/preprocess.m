function J = preprocess(fr, sc)
% function J = preprocess(fr, sc)
% preprocess

fr = imresize(fr, sc);

for i=1:3
    X = fr(:,:,i);
    X = imadjust(X);
    
    X = ordfilt2(X, 1, true(3)); % min(3)
    X = ordfilt2(X, 1, true(5)); % min(5)
    
    J(:,:,i) = X;
end
