close all;
clear all;

seqName = "TestSeq";

if (~isdir('Output/' + seqName))
    mkdir(char('Output/' + seqName));
end

seq = read(seqName);

indices = [1, 2; 1, 4; 1, 5];

base_name = "Output/" + seqName + "/ps5_4a";

for i=1:size(indices,1)
    
    img0 = squeeze(seq(indices(i,1),:,:));
    img1 = squeeze(seq(indices(i,2),:,:));

    [u, v, idx] = hlk(img0, img1, 6, 2, 0.01);
    f = display_flow_uv(u, v, jet, [-45, 45]);
    save_figure(f, base_name + "_" + string(indices(i,2)) + "_uv.png");

    f = display_flow_arrows(img1, u, v, idx);
    save_figure(f, base_name + "_" + string(indices(i,2)) + "_arrows.png");

    img1w = warp(img0, u, v);

    delta = (img1w - img1 + 1.)/2.;
    figure;
    imshow(delta);
    title('Delta image');
    
    imwrite(delta, char(base_name + "_" + string(indices(i,2)) + "_delta.png"));
end