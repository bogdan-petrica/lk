function res = warp(image, du, dv)
    assert(all(size(image) == size(du)));
    assert(all(size(image) == size(dv)));
    res = remap(image, du, dv);
end

