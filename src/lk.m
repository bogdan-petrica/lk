
function [u, v, valid] = lk(prev, curr, varargin)
    % prev              - previous image
    % curr              - current image
    % type              - box ( equal weights ) or gaussian, default is box
    % wing_size         - is the wing size of the aperture were
    %                     flow is determined, default is 7
    % threshold         - value for flow to consider it high enough, default
    %                     0.002
    assert(all(size(prev) == size(curr)));
    
    if nargin < 3
        type = 'box';
    else
        type = varargin{1};
    end

    if nargin < 4
        w = 5;
    else
        w = varargin{2};
    end
     
    if nargin < 5
        threshold = 0.002;
    else
        threshold = varargin{3};
    end
    
    if type == "gaussian"
        boxfilter = fspecial('gaussian', 2 * w + 1, 0.6 * w);
        boxfilter = boxfilter / boxfilter(w + 1, w + 1);
    else
        boxfilter = ones([2*w + 1, 2*w + 1]);
    end
    
    filter_dy = [-1, -2, -1; 0, 0, 0; 1, 2, 1] / 8;
    filter_dx = filter_dy';
    
    dy = imfilter(prev, filter_dy, 'same', 'replicate');
    dx = imfilter(prev, filter_dx, 'same', 'replicate');
    dt = curr - prev;
    
    a = imfilter(dx .* dx, boxfilter, 'same');
    b = imfilter(dx .* dy, boxfilter, 'same');
    c = b;
    d = imfilter(dy .* dy, boxfilter, 'same');
    tu = imfilter(dx .* dt, boxfilter, 'same');
    tv = imfilter(dy .* dt, boxfilter, 'same');
    
    det = a .* d - b .* c;
    trace = a + d;
    
    u = zeros(size(prev), 'double');
    v = zeros(size(prev), 'double');
    
    valid = find(det - threshold * trace > 0);
    u(valid) = (tu(valid) .* d(valid) - tv(valid) .* c(valid)) ./ det(valid);
    v(valid) = (- tu(valid) .* b(valid) + tv(valid) .* a(valid)) ./ det(valid);
end