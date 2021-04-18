function res = warp(image, du, dv)
    assert(all(size(image) == size(du)));
    assert(all(size(image) == size(dv)));
    
    image_pad = padarray(image, [1, 1], 'replicate');
    du_pad = padarray(du, [1, 1]);
    dv_pad = padarray(dv, [1, 1]);
    
    r = size(image_pad, 1);
    c = size(image_pad, 2);
    
    [u, v] = meshgrid(1:c, 1:r);
    
    temp = remap(image_pad, u + du_pad, v + dv_pad);
    res = temp(2:r-1, 2:c-1);
end

