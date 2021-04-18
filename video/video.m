clear all;
close all;

addpath('..\lab');
addpath('..\src');

reader = VideoReader('CarSeq/video.mp4');

display_flow_angle_legend(60, 60);

h = 360;
w = 640;
sz = [h, w];

f = figure;
a = axes;

prev = nextFrame(reader, sz);
while hasFrame(reader)
    frame = nextFrame(reader, sz);
    
    [u, v, idx] = hlk(prev, frame, 5, 7, 0.002);
    frame_angle = flow_angle(u, v, idx);
        
    frame_visu = [gray2rgb(frame); frame_angle];
    image(a, frame_visu);
    a.DataAspectRatio = [ 2 * h, w, 1 ];
    drawnow;
    
    prev = frame;
end

function frame = nextFrame(reader, sz)
    frame_rgb = readFrame(reader);
    frame = double(rgb2gray(frame_rgb)) / 255.;
    frame = imresize(frame, sz);
end

function image = gray2rgb(rgb)
    image = ind2rgb(uint8(rgb * size(gray, 1)), gray);
end