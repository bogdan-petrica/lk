close all;
clear all;

opt = double(imread('output/optDataSeq2/ps5_4c_3_warped.png'))/255.;
nopt = double(imread('output/fixDataSeq2/ps5_4c_3_warped.png'))/255.;

diff = opt - nopt;

l = min(min(diff));
h = max(max(diff));
edges = linspace(l, h, 10);

figure;
histogram(diff, edges);
ax = gca;
ax.YScale = 'log';

figure;
imshow(diff, []);