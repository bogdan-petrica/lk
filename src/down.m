function res = down(image)
    v = [1, 4, 6, 4, 1]/16;
    filter = v'  * v;
    
    pad_image = padarray(double(image), [2, 2], 'replicate');
    
    src_row_count = size(image, 1);
    src_col_count = size(image, 2);
    
    dst_row_count = ceil(src_row_count/2);
    dst_col_count = ceil(src_col_count/2);
    
    dst_rows = 1:dst_row_count;
    dst_cols = 1:dst_col_count;
    
    % dst_idx = (src_idx - 1)/2 + 1
    % we add extra two because of the padding
    src_rows = 2 * (dst_rows - 1)  + 1 + 2;
    src_cols = 2 * (dst_cols - 1)  + 1 + 2;
    
    res = zeros(dst_row_count, dst_col_count, 'double');
    
    for row=-2:2
        for col=-2:2
            element = pad_image(src_rows + row, src_cols + col) * filter(row + 3, col + 3);
            res(dst_rows, dst_cols) = res(dst_rows, dst_cols) + element;
        end
    end
    
end