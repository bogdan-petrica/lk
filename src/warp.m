function res = warp(image, du, dv)
    assert(all(size(image) == size(du)));
    assert(all(size(image) == size(dv)));
    
    r = size(image, 1);
    c = size(image, 2);
    
    [u, v] = meshgrid(1:c, 1:r);
    
    res = remap(image, u + du, v + dv);
end

