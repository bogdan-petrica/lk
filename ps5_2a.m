close all;

if (~isdir('Output/DataSeq1'))
    mkdir('Output/DataSeq1');
end

seq = read('DataSeq1');
img = squeeze(seq(1, :,:));

%% Display the four pyramid images

img0 = down(img);
img1 = down(img0);
img2 = down(img1);

img00 = up(img0);
img00 = img00(1:size(img,1), 1:size(img, 2));

img10 = up(up(img1));
img10 = img10(1:size(img,1), 1:size(img, 2));

img20 = up(up(up(img2)));
img20 = img20(1:size(img,1), 1:size(img, 2));

f = figure;
subplot(2, 2, 1);
imshow(img);
title('Level0');

subplot(2, 2, 2);
imshow(img00);
title('Level1');

subplot(2, 2, 3);
imshow(img10);
title('Level2');

subplot(2, 2, 4);
imshow(img20);
title('Level3');

save_figure(f, 'output/DataSeq1/ps5_2a_1.png');

%% compute the deltas needed for recovery

d2 = img10 - img20;
d1 = img00 - img10;
d0 = img - img00;

f = figure;
subplot(2, 2, 1);
imshow(img20);
title('img20');

subplot(2, 2, 2);
imshow(d2, []);
title('d2');

subplot(2, 2, 3);
imshow(d1, []);
title('d1');

subplot(2, 2, 4);
imshow(d0, []);
title('d0');

save_figure(f, 'output/DataSeq1/ps5_2b_1.png');

%% recovery everything back

rimg1 = img20 + d2;
rimg0 = rimg1 + d1;
rimg = rimg0 + d0;

figure;
imshow(rimg);
title('Recovered image');

err = rimg - img;

l = min(min(err));
h = max(max(err));
edges = linspace(l, h, 10);

figure;
subplot(1, 2, 1);
histogram(err, edges);
title('Errors');

subplot(1, 2, 2);
imshow(err, []);
title('Errors image');

