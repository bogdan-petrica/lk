function display_gray_image(image)
    figure;
    imagesc(image);
    colormap gray;
    ax = gca;
    ax.YDir = 'reverse';
    ax.DataAspectRatio = [ size(image), 1 ];
end