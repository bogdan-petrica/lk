function display_flow_angle_legend(xc, yc)
    d = 2 * max(xc, yc);
    [u, v] = meshgrid(1:d, 1:d);
    
    u = u - xc - 1;
    v = v - yc - 1;
    
    vidx = find(u.^2 + v.^2 <= (d/2)^2);
    
    display_flow_angle(u, v, vidx);
end
