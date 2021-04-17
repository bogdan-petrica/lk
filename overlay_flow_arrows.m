function overlay_flow_arrows(image, u, v, idx, varargin)
    if nargin < 5
        color = [ 0, 0, 1.0 ];
    else
        color = varargin{1};
    end

    [r, c] = ind2sub(size(image), idx);
    hold on;
    quiver(c, r, u(idx), v(idx), 0, 'Color', color);
    hold off;
end