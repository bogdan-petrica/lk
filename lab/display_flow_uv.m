function f = display_flow_uv(u, v, colors, varargin)
    if nargin < 4
        lim = [ -6, 6 ];
    else
        lim = varargin{1};
    end
    
    if nargin < 5
        f = figure;
    else
        f = varargin{2};
    end

    set(0, 'CurrentFigure', f);
    ax = subplot(1, 2, 1);
    
    imagesc(u);
    title('U displacement');
    colormap(colors);
    colorbar;
    ax.CLim = lim;
    ax.YDir = 'reverse';
    ax.DataAspectRatio = [ size(u), 1 ];
    
    ax = subplot(1, 2, 2);
    imagesc(v);
    title('V displacement');
    colormap(colors);
    colorbar;
    ax.CLim = lim;
    ax.YDir = 'reverse';
    ax.DataAspectRatio = [ size(v), 1 ];
    
    f.Units = 'normalized';
    f.OuterPosition = [0, 0, 1, 1];
end