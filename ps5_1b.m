close all;

seq = read('TestSeq');

if (~isdir('Output/TestSeq'))
    mkdir('Output/TestSeq');
end

%% flow between Shift0 & ShiftR10

img0 = smooth(squeeze(seq(1,:,:)), 5, 1);
img1 = smooth(squeeze(seq(2,:,:)), 5, 1);

[u, v, idx] = lk(img0, img1, 'box', 11, 0.002);

f = display_flow_uv(u, v, jet, [-12, 12]);
save_figure(f, 'Output/TestSeq/ps5_1b_1.png');

f = display_flow_arrows(img1, u, v, idx);
save_figure(f, 'Output/TestSeq/ps5_1b_1_arrow.png');


%% flow between Shift0 & ShiftR20

img0 = smooth(squeeze(seq(1,:,:)), 5, 1);
img1 = smooth(squeeze(seq(4,:,:)), 5, 1);

[u, v, idx] = lk(img0, img1, 'box', 11, 0.002);

f = display_flow_uv(u, v, jet, [-22, 22]);
save_figure(f, 'Output/TestSeq/ps5_1b_2.png');

f = display_flow_arrows(img1, u, v, idx);
save_figure(f, 'Output/TestSeq/ps5_1b_2_arrow.png');


%% flow between Shift0 & ShiftR40

img0 = smooth(squeeze(seq(1,:,:)), 5, 1);
img1 = smooth(squeeze(seq(5,:,:)), 5, 1);

[u, v, idx] = lk(img0, img1, 'box', 11, 0.002);

f = display_flow_uv(u, v, jet, [-42, 42]);
save_figure(f, 'Output/TestSeq/ps5_1b_3.png');

f = display_flow_arrows(img1, u, v, idx);
save_figure(f, 'Output/TestSeq/ps5_1b_3_arrow.png');