function display_flow_mag(u, v, idx)
    assert(all(size(u) == size(v)));
    img = zeros(size(u));
    img(idx) = sqrt(u(idx).^2 + v(idx).^2);
    display_gray_image(img);
    colormap jet;
    colorbar;
end
