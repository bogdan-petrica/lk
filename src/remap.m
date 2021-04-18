function dst = remap(src, u, v)
    % remaps src based on u and v displacements
    % u, v are given in absolute values
    % all imgase must have equal sizes

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
end

function res = lookup(src, r, c)
    i = find(r >= 1 & r <= size(src, 1) & c >= 1 & c <= size(src, 2));
    
    res = zeros(size(src));
    res(i) = src(sub2ind(size(src), r(i), c(i)));
end