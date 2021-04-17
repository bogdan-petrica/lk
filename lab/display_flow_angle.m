function display_flow_angle(u, v, idx, varargin)
    if nargin < 4
        f = figure;
    else
        f = varargin{1};
    end

    assert(all(size(u) == size(v)));

    hsv_colors = [((0:100)/100)', ones(101, 1) * 0.7, ones(101, 1) * 0.7];
    colors = [ 0, 0, 0; hsv2rgb(hsv_colors) ];
    
    angle = (atan2(-v, u) + pi)/2/pi;
    angle_idx = round(angle * (size(hsv_colors, 1) - 1) + 1) + 1;
    
    image = zeros(size(u));
    image(idx) = angle_idx(idx);

    set(0, 'CurrentFigure', f);
    imshow(ind2rgb(image, colors));
end
