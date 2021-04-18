function dst = remap(src, u, v)
    % remaps src based on u and v displacements
    % u, v are given in absolute values
    % all imgase must have equal sizes
    assert(all(size(src) == size(u)));
    assert(all(size(u) == size(v)));
    
    %{
    r = size(src, 1);
    c = size(src, 2);
    
    [uu, vv] = meshgrid(1:c, 1:r);
    %}
    
    %{
    r = size(du, 1);
    c = size(du, 2);
    
    [u, v] = meshgrid(1:c, 1:r);
    
    u0 = u + du0;
    v0 = v + dv0;
    %}
    
    src_pad = padarray(src, [1, 1], 'replicate');
    u_pad = padarray(u, [1, 1], 'replicate');
    v_pad = padarray(v, [1, 1], 'replicate');
    
    r = size(u_pad, 1);
    c = size(v_pad, 2);
    
    [uu_pad, vv_pad] = meshgrid(1:c, 1:r);
    
    uu_pad = uu_pad + u_pad;
    vv_pad = vv_pad + v_pad;
    
    dst_pad = interp2(src_pad, uu_pad, vv_pad, 'linear');
    iidx = find(isnan(dst_pad));
    temp = interp2(src_pad, uu_pad, vv_pad, 'nearest', 0);
    dst_pad(iidx) = temp(iidx);
    dst = dst_pad(2:r-1,2:c-1);
    
    

    %{
    % r0.a0
    r0 = floor(v);
    a0 = v - r0;
    
    % c0.b0
    c0 = floor(u);
    b0 = u - c0;
    
    a = lookup(src, r0, c0);
    b = lookup(src, r0, c0 + 1);
    c = lookup(src, r0 + 1, c0);
    d = lookup(src, r0 + 1, c0 + 1);
    
    top = (1-b0).* a + b0 .* b;
    bottom = (1-b0) .* c + b0 .* d;
    
    dst = (1-a0) .* top + a0 .* bottom;
    
    %}
    
end

function res = lookup(src, r, c)
    i = find(r >= 1 & r <= size(src, 1) & c >= 1 & c <= size(src, 2));
    
    res = zeros(size(src));
    res(i) = src(sub2ind(size(src), r(i), c(i)));
end