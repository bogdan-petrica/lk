close all;

addpath('..\src');

seq = read('TestSeq');

if (~isdir('Output/TestSeq'))
    mkdir('Output/TestSeq');
end

%% flow between Shift0 & ShiftR2

img0 = smooth(squeeze(seq(1,:,:)), 5, 1);
img1 = smooth(squeeze(seq(3,:,:)), 5, 1);

[u, v, idx] = lk(img0, img1, 'box', 7, 0.002);

f = display_flow_uv(u, v, jet);
save_figure(f, 'Output/TestSeq/ps5_1a_1.png');

f = display_flow_arrows(img1, u, v, idx);
save_figure(f, 'Output/TestSeq/ps5_1a_1_arrow.png');

%% flow between Shift0 & ShiftR5U5

img0 = smooth(squeeze(seq(1,:,:)), 5, 1);
img1 = smooth(squeeze(seq(6,:,:)), 5, 1);

[u, v, idx] = lk(img0, img1, 'box', 10, 0.02);

f = display_flow_uv(u, v, jet);
save_figure(f, 'Output/TestSeq/ps5_1a_2.png');

f = display_flow_arrows(img1, u, v, idx);
save_figure(f, 'Output/TestSeq/ps5_1a_2_arrow.png');

[u, v, idx] = lk(img0, img1, 'gaussian', 10, 0.002);
f = display_flow_uv(u, v, jet);
f = display_flow_arrows(img1, u, v, idx);

%% smoothing helps up to a point, in general more
%% smoothing generates better flow images up to a size of 11x11 with
%% sigma 1
%%
%% for the large displacement image smoothing doesn't solve the problem
%% as the aperture is kept small, increasing the aperture generates
%% better flow image for large displacement but also reduces the precision
%% around edges, gaussian weights in minimization were used and they
%% provide better edge flow


%{

function res = flow_image(image, lower, upper, colors, horiz)
    colorsize = size(colors, 1);
    res = ind2rgb( int32(colorsize*(image - lower)/(upper - lower)), colors);
    
    colorbar = horizontal_colorbar([8, 128], colors);
    
    if ~horiz
        colorbar = permute(colorbar, [2, 1, 3]);
    end
    
    res = overlay(res, colorbar, [20, 20]);
end

function res = horizontal_colorbar(sz, colors)
    temp = zeros(sz);
    idx = 1:sz(2);
    value = int32(size(colors, 1) * (idx - 1)/(sz(2) - 1));
    temp(1:end,:) = repmat(value, sz(1), 1);
    res = ind2rgb(temp, colors);
end

function res = overlay(image, src, point)
    rows = size(src, 1);
    cols = size(src, 2);
    
    ridx = 1:rows;
    cidx = 1:cols;
    
    res = image;
    res(ridx + point(1), cidx + point(2),:) = src(ridx, cidx,:);
end
%}