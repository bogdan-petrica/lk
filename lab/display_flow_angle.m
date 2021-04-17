function display_flow_angle(u, v, idx, varargin)
    if nargin < 4
        f = figure;
    else
        f = varargin{1};
    end

    set(0, 'CurrentFigure', f);
    imshow(flow_angle(u, v, idx));
end
