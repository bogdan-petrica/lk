function f = display_flow_arrows(image, u, v, idx)   
    display_gray_image(image);
    overlay_flow_arrows(image, u, v, idx);
    
    f = gcf;
    
    f.Units = 'normalized';
    f.OuterPosition = [0, 0, 1, 1];
end