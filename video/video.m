clear all;
close all;

addpath('..\lab');
addpath('..\src');

reader = VideoReader('CarSeq/video.mp4');
have_prev = 0;

display_flow_angle_legend(60, 60);

f = figure;

h = 360;
w = 640;

while hasFrame(reader)
    frame_rgb = readFrame(reader);
    frame = double(rgb2gray(frame_rgb)) / 255.;
    frame = imresize(frame, [h, w]);
    
    if have_prev
        [u, v, idx] = hlk(prev, frame, 5, 7, 0.002);
        frame_angle = flow_angle(u, v, idx);
        
        frame_visu = [ind2rgb(uint8(frame * size(gray, 1)), gray); frame_angle];
        
        set(0, 'CurrentFigure', f);
        imshow(frame_visu);
    end
    
    prev = frame;
    have_prev = 1;
end