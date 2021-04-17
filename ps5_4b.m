close all;
clear all;

seqName = "DataSeq1";

if (~isdir('Output/' + seqName))
    mkdir(char('Output/' + seqName));
end

seq = read(seqName);

indices = [1, 2; 2, 3];

base_name = "Output/" + seqName + "/ps5_4b";

for i=1:size(indices,1)
    
    img0 = squeeze(seq(indices(i,1),:,:));
    img1 = squeeze(seq(indices(i,2),:,:));

    [u, v, idx] = hlk(img0, img1, 5, 4, 0.02);
    f = display_flow_uv(u, v, jet, [-10, 10]);
    save_figure(f, base_name + "_" + string(indices(i,2)) + "_uv.png");

    f = display_flow_arrows(img1, u, v, idx);
    save_figure(f, base_name + "_" + string(indices(i,2)) + "_arrows.png");

    img1w = warp(img0, u, v);

    delta = (img1w - img1 + 1.)/2.;
    figure;
    imshow(delta);
    title('Delta image');
    
    imwrite(delta, char(base_name + "_" + string(indices(i,2)) + "_delta.png"));
    
    figure;
    imshow(img1w);
    title('Warped image');
    imwrite(img1w, char(base_name + "_" + string(indices(i,2)) + "_warped.png"));
    
end