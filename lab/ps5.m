close all;
clear all;

addpath('..\src');

seq = read('DataSeq2');
img0 = squeeze(seq(1,:,:));
img1 = squeeze(seq(2,:,:));


[u, v, idx] = hlk(img0, img1, 5);

display_flow_mag(u, v, idx);
display_flow_angle(u, v, idx);
display_flow_angle_legend(60, 60);
display_flow_arrows(img1, u, v, idx);