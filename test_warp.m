close all;

image = zeros([240, 240], 'double');

image(:) = 0.5;

box = [60, 60, 120, 120];

image = rectangle(image, box, 0.7);

dx = -59;
dy = -59;

u = zeros([240, 240]);
u(:) = -dx;

v = zeros([240, 240]);
v(:) = -dy;

image2 = warp(image, u, v);

[x, y] = meshgrid(1:size(image,2), 1:size(image, 1));
image3 = interp2(image, x + u, y + v);

figure;
imshow(image);

figure;
imshow(image2);

figure;
imshow(image3);


function res = rectangle(src, box, value)
    res = src;
    res(box(1):box(1) + box(3), box(2):box(2) + box(4)) = value;
end
