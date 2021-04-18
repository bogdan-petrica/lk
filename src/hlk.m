function [u, v, idx] = hlk(prev, curr, k, varargin)
    assert(k >= 1);
    
    if nargin < 4
        wing_size = 5;
    else
        wing_size = varargin{1};
    end
    
    if nargin < 5
        threshold = 0.002;
    else
        threshold = varargin{2};
    end
    
    prev_pyramid = cell(k, 1);
    curr_pyramid = cell(k, 1);
    
    prev_pyramid{1} = prev;
    curr_pyramid{1} = curr;
    for i=2:k
        prev_pyramid{i} = down(prev_pyramid{i-1});
        curr_pyramid{i} = down(curr_pyramid{i-1});
    end
    
    type = 'box';
    
    disp_flow = 0;
    
    [u, v, idx] = lk(prev_pyramid{k}, curr_pyramid{k}, type, wing_size, threshold);
    
    if disp_flow
        display_flow_arrows(curr_pyramid{k}, u, v, idx);
    end
    
    for j=1:k-1
        i = k - j;
        
        u = 2*up(u);
        v = 2*up(v);
        
        u = u(1:size(prev_pyramid{i},1), 1:size(prev_pyramid{i},2));
        v = v(1:size(prev_pyramid{i},1), 1:size(prev_pyramid{i},2));
        
        [r, c, ~] = find(u ~= 0 | v ~= 0);
        idx = sub2ind(size(u), r, c);
        
        prev = warp(prev_pyramid{i}, u, v);
        
        [u0, v0, idx0] = lk(prev, curr_pyramid{i}, type, wing_size, threshold);
        
        [u1, v1] = compose_flow(u, v, u0, v0);
        [r1, c1, ~] = find(u1 ~= 0 | v1 ~= 0);
        idx1 = sub2ind(size(u1), r1, c1);
        
        if disp_flow
            display_gray_image(curr_pyramid{i});
            overlay_flow_arrows(curr_pyramid{i}, u, v, idx, [0, 0, 1.0]);
            overlay_flow_arrows(curr_pyramid{i}, u0, v0, idx0, [1.0, 0, 0]);
            overlay_flow_arrows(curr_pyramid{i}, u1, v1, idx1, [0.0, 1.0, 0]);
        end
        
        u = u1;
        v = v1;
    end
    
    [r, c, ~] = find(u ~= 0 | v ~= 0);
    idx = sub2ind(size(u), r, c);
end

function [res_du, res_dv] = compose_flow(du, dv, du0, dv0)
    assert(all(size(du) == size(dv)));
    assert(all(size(du0) == size(dv0)));
    assert(all(size(du) == size(du0)));
    res_du = remap(du, du0, dv0) + du0;
    res_dv = remap(dv, du0, dv0) + dv0;
end