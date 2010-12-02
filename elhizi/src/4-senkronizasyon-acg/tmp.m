close all

X = [acg.index.X' acg.palm.X' acg.thumb.X'];
Y = [acg.index.Y' acg.palm.Y' acg.thumb.Y'];
Z = [acg.index.Z' acg.palm.Z' acg.thumb.Z'];

sz = length(acg.index.X);

data.X = [X; Y; Z];
data.y = [1*ones([1 sz]) 2*ones([1 sz]) 3*ones([1 sz])];

model = fldqp(data);

plot3(acg.index.X', acg.index.Y',   acg.index.Z',   'r*', ...
      acg.palm.X',  acg.palm.Y',    acg.palm.Z',    'g*', ...
      acg.thumb.X', acg.thumb.Y',   acg.thumb.Z',   'b*');
grid on
legend('index', 'palm', 'thumb');
xlabel('X');    ylabel('Y');    zlabel('Z');

hold on
G = 10000;
ofset = 100;

v = ofset + G * model.W';
v = [[ofset ofset ofset]; v(1,:)];%; [ofset ofset ofset]; v(2,:)]

plot3(v(1:2, 1), v(1:2, 2), v(1:2, 3), 'k');%, v(3:4, 1), v(3:4, 2), v(3:4, 3), 'k');

hold off

% %
w = model.W;
x = data.X(:,1:sz)


% PCA.model.W
% 
%    -0.9254   -0.2662
%     0.0684   -0.8174
%    -0.3728    0.5108
   
return
trn = load('riply_trn'); % load training data

modelFLD = fldqp(trn); % compute FLD

X = trn.X;
modelPCA = pca(X,1); % train PCA

Z = linproj(X,modelPCA); % lower dim. proj.
XR = pcarec(X,modelPCA); % reconstr. data

figure;
subplot(121)
ppatterns(trn); pline(modelFLD); % plot data and solution
tst = load('riply_tst'); % load testing data
ypred = linclass(tst.X,modelFLD); % classify testing data

cerror(ypred,tst.y) % compute testing error

ax = axis;

subplot(122)
hold on;
h1 = ppatterns(X,'kx');
h2 = ppatterns(XR,'bo');
[dummy,mn] = min(Z);
[dummy,mx] = max(Z);
h3 = plot([XR(1,mn) XR(1,mx)],[XR(2,mn) XR(2,mx)],'r');
legend([h1 h2 h3], ...
 'Input vectors','Reconstructed', 'PCA subspace');
axis(ax)