
function save_figure(f, name)
    frame = getframe(f);
    img = frame.cdata;
    i = find(img(:) ~= 240);
    [r, c, ~] = ind2sub(size(img), i);
    m = [min(r), min(c), max(r), max(c)];
    imwrite(img(m(1):m(3),m(2):m(4),:), char(name));
end