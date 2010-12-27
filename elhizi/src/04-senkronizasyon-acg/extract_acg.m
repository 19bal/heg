function [acg] = extract_acg(fnm, dbg)
%function [acg] = extract_acg(fnm, dbg)
% AcceleGlove dosyasindaki verileri extract eder

% birinci satir haricindekileri al
data = csvread(fnm, 1, 0);

% data = data(1,:);

% "Sample No" sutununa ayri muamelede bulun
acg.samples  = data(:, 1);

data = data(:, 2:size(data, 2));

data = filtering(data, 25);

acg.thumb.X  = data(:, 1);
acg.thumb.Y  = data(:, 2);
acg.thumb.Z  = data(:, 3);

acg.index.X  = data(:, 4);
acg.index.Y  = data(:, 5);
acg.index.Z  = data(:, 6);

acg.middle.X = data(:, 7);
acg.middle.Y = data(:, 8);
acg.middle.Z = data(:, 9);

acg.ring.X   = data(:, 10);
acg.ring.Y   = data(:, 11);
acg.ring.Z   = data(:, 12);

acg.pinky.X  = data(:, 13);
acg.pinky.Y  = data(:, 14);
acg.pinky.Z  = data(:, 15);

acg.palm.X   = data(:, 16);
acg.palm.Y   = data(:, 17);
acg.palm.Z   = data(:, 18);


