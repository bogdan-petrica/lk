function f = display_flow_arrows(image, u, v, idx, varargin)
    if nargin < 5
        f = figure;
    else
        f = varargin{1};
    end

    display_gray_image(image, f);
    overlay_flow_arrows(image, u, v, idx);
    
    f.Units = 'normalized';
    f.OuterPosition = [0, 0, 1, 1];
end