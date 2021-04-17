clear all;
close all;

addpath('..\lab');
addpath('..\src');

reader = VideoReader('CarSeq/video.mp4');
have_prev = 0;

display_flow_angle_legend(60, 60);

figure_angle = figure;
figure_arrows = figure;

h = 360;
w = 640;

while hasFrame(reader)
    frame_rgb = readFrame(reader);
    frame = double(rgb2gray(frame_rgb)) / 255.;
    frame = imresize(frame, [h, w]);
    
    if have_prev
        [u, v, idx] = hlk(prev, frame, 5, 5, 0.002);
        display_flow_angle(u, v, idx, figure_angle);
        display_flow_uv(u, v, jet, [-20, 20], figure_arrows);
    end
    
    prev = frame;
    have_prev = 1;
end