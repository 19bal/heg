function [ts, te] = extract_extreme_time(DIR, dbnm, dbg)
% function [ts, te] = extract_extreme_time(DIR, dbnm, dbg)

ts = helper(DIR, dbnm, 210:270, dbg);
te = helper(DIR, dbnm, 670:700, dbg);

% % helper
function ext_time = helper(DIR, dbnm, fi, dbg)
sz = length(DIR);
fr_p = -1;             % previous frame
for f = fi,
    fprintf('kare %04d/%04d isleniyor ...\n', f, sz);

    imgnm = DIR(f).name;    
    fr = imread(strcat(dbnm, imgnm));

    fr = rgb2gray(fr);
    fr = imresize(fr, [128 NaN]);
    fr = medfilt2(fr, [3 3]);
%     fr = imadjust(fr);
    %fr = edge(fr, 'canny', [], 4);

    if fr_p == -1
        fr_p = fr;
        continue;
    end
    
    fark = uint8(abs(double(fr) - double(fr_p)));  
    
    mse_f(f) = mean(fark(:).^2);
    
    if dbg
        figure(11);            
            subplot(221),   imshow(fr_p),       title('onceki');
            subplot(222),   imshow(fr),         title('simdiki');
            subplot(223),   imshow(fark),       title('fark');
        drawnow;
    end    
    fr_p = fr;
end

if dbg
    figure(12),  
    plot(fi, mse_f(fi)),        grid on;
    xlabel('Frame indisi'),     ylabel('J-Amac islevi');
    title('Baslangic aninin bulunmasi');
end

% 
[mx,ind] = max(mse_f);
x=(ind-5):(ind+5); y = mse_f(x);
p = polyfit(x,y, 2);

xx = min(x):0.01:max(x);
yy = polyval(p, xx);
plot(xx,yy);
[mx,ind]=max(yy);
ext_time = round(xx(ind));