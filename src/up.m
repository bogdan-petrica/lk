
function res = up(image)
    u = [2, 12, 2]/16;
    v = [1, 1]/2;
    
    src_row_count = size(image, 1);
    src_col_count = size(image, 2);
    
    pad_image = padarray(double(image), [1 1], 'replicate');
    
    res = zeros(2 * src_row_count, 2 * src_col_count, 'double');
    
    src_rows = 1:src_row_count;
    src_cols = 1:src_col_count;
    
    res = up_step(pad_image, res, u' * u, src_rows, src_cols, 2 * src_rows - 1, 2 * src_cols - 1);
    res = up_step(pad_image, res, u' * v, src_rows, src_cols, 2 * src_rows - 1, 2 * src_cols - 1 + 1);
    
    res = up_step(pad_image, res, v' * u, src_rows, src_cols, 2 * src_rows - 1 + 1, 2 * src_cols - 1);
    res = up_step(pad_image, res, v' * v, src_rows, src_cols, 2 * src_rows - 1 + 1, 2 * src_cols - 1 + 1);
end

function res = up_step(pad_image, acc, filter, src_rows, src_cols, dst_rows, dst_cols)
    if size(filter,1) == 3
        start_row = -1;
    else
        start_row = 0;
    end
    
    if size(filter, 2) == 3
        start_col = -1;
    else
        start_col = 0;
    end
    
    off_row = 1 - start_row;
    off_col = 1 - start_col;

    for row = start_row:1
        for col = start_col:1
            element = pad_image(src_rows + 1 + row, src_cols + 1 + col) * filter(row + off_row, col + off_col);
            acc(dst_rows, dst_cols) = acc(dst_rows, dst_cols) + element;
        end
    end
    
    res = acc;
end
