function res = smooth(image, varargin)
    if size(varargin) < 3
        w = 4;
    else
        w = varargin(3);
    end
    
    if size(varargin) < 4
        sigma = 1;
    else
        sigma = varargin(4);
    end

    f = fspecial('gaussian', 2 * w + 1, sigma);
    res = conv2(image, f, 'same') / sum(sum(f));
end