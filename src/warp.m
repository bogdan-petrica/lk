function res = warp(image, du, dv)
    assert(all(size(image) == size(du)));
    assert(all(size(image) == size(dv)));
    
    idx = 1:(size(du,1)*size(du,2));
    [r, c] = ind2sub(size(du), idx);
    
    u = reshape(c, size(du)) + du;
    v = reshape(r, size(dv)) + dv;
    
    res = remap(image, u, v);
end

