function res = read(seq)
    dir_path = "input/" + seq;
    
    images = dir(char(dir_path));
    names = [];
    
    for i=1:size(images)
        name = string(images(i).name);
        if name ~= "." && name ~= ".."
            disp(name);
            names = [names; name];
        end
    end
    
    names = sortrows(names);
    
    names_count = size(names, 1);
    
    assert(names_count > 0);
    
    img0 = read_single_image(dir_path + "/" + names(1));
    
    res = zeros(names_count, size(img0, 1), size(img0, 2), 'double');
    res(1,:,:) = img0;
    
    for i=2:names_count
        res(i,:,:) = read_single_image(dir_path + "/" + names(i));
    end
end

function res = read_single_image(path)
    img = imread(char(path));
    if (class(img) == "uint8")
        img = double(img) / 255;
    end
    
    if (size(img, 3) == 3)
        a = img(:,:, 1);
        b = img(:,:, 2);
        c = img(:,:, 3);
        
        img = (a + b + c)/3;
    end
    res = img;
end