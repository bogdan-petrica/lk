close all;
clear all;

seqName = "Juggle";

if (~isdir('Output/' + seqName))
    mkdir(char('Output/' + seqName));
end

seq = read(seqName);

indices = [1, 2; 2, 3];

base_name = "Output/" + seqName + "/ps5_4c";

for i=1:size(indices,1)
    
    img0 = squeeze(seq(indices(i,1),:,:));
    img1 = squeeze(seq(indices(i,2),:,:));

    [u, v, idx] = hlk(img0, img1, 6, 2, 0.001);
    f = display_flow_uv(u, v, jet, [-30, 30]);
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
    
    display_flow_mag(u, v, idx);
    
    display_flow_angle(u, v, idx);
    
end