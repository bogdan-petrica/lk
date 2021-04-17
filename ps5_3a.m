close all;


smooth_on = 0;

seqs = ["DataSeq1", "DataSeq2"];

for j=1:2
    if (~isdir('Output/' + seqs(j)))
        mkdir(char('Output/' + seqs(j)));
    end
    
    seq = read(seqs(j));

    for i=1:2
        img0 = squeeze(seq(i,:,:));
        img1 = squeeze(seq(i+1,:,:));

        if smooth_on
            img0s = smooth(img0, 5, 1);
            img1s = smooth(img1, 5, 1);
        else
            img0s = img0;
            img1s = img1;
        end

        base_name = 'Output/' + seqs(j) + '/ps5_3a_' + '_' + string(i);

        %% compute flow

        % determine l flow without using gaussian smoothing on the
        % the original images, as gaussian is reducing the quality of
        % the recovered flow
        %
        % a box with a wing size of 7 is needed to recovery the motion
        % for DataSeq1
        [u1, v1, idx1] = lk(img0s, img1s, 'box', 7, 0.002);

        f = display_flow_uv(u1, v1, jet, [-3, 3]);
        save_figure(f, base_name + '.png');
        
        f = display_flow_arrows(img1, u1, v1, idx1);
        save_figure(f, base_name + '_arrow.png');

        %% warp image0 to image1w using flow

        % warp img0 to the img1w using determined flow
        img1w = warp(img0, u1, v1);
        imwrite(img1w, char(base_name + '_warped.png'));

        figure;
        subplot(1, 2, 1);
        imshow(img1);
        title('Original image:' + string(i+1));

        subplot(1, 2, 2);
        imshow(img1w);
        title('warped image: ' + string(i) + '->' + string(i+1));

        %% delta between img1w and img1

        dw = img1 - img1w;
        imwrite(dw, char(base_name + '_warped_delta.png'));

        figure;
        imshow(dw, []);
        title('delta warped: ' + string(i+1));

        l = sqrt(u1.^2 + v1.^2);

        %% provide residual plot

        % a residual plot between flow mangitude and error
        % between the two images
        %
        % the smaller the flow magnitude the larger the error,
        % theory is that because of the large aperture used (wing size 7)
        % smaller displacements where texturation is not that good are not
        % properly receoverd
        %
        % another possibility is that the large flow is not properly
        % recovered and in places of great displacement a small flow
        % is used
        %
        % => increasing the aperture will recover the large motion better
        %    but decrease the quality of the small motion
        figure;
        scatter(l(:), dw(:));
        title('flow magnitude vs error');

        l = min(min(dw));
        h = max(max(dw));
        edges = linspace(l, h, 10);

        figure;
        histogram(dw, edges);
        title('errors delta warped: ' + string(i) + '->' + string(i+1));
        ax = gca;
        ax.YScale = 'log';

        %% delta between img0 and img1

        di = img1 - img0;
        figure;
        imshow(di, []);
        title('delta: ' + string(i) + '->' + string(i+1));

    end

end