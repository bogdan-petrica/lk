function display_gray_image(image, varargin)
    if nargin < 2
        f = figure;
    else
        f = varargin{1};
    end

    set(0, 'CurrentFigure', f);
    imagesc(image);
    colormap gray;
    ax = gca;
    ax.YDir = 'reverse';
    ax.DataAspectRatio = [ size(image), 1 ];
end