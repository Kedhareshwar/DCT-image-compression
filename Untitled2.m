function main()
    % Load the original and compressed images
    original_image = imread('STScI-01GGF8H15VZ09MET9HFBRQX4S3.png');
compressed_image = imread('compressed_image_rgb.jpg');

    block_size = 60;  % You can adjust the block size as needed
    [psnr, mse] = block_psnr_mse(original_image, compressed_image, block_size);

    fprintf('Average PSNR: %.2f dB\n', psnr);
    fprintf('Average MSE: %.2f\n', mse);
end

function [avg_psnr, avg_mse] = block_psnr_mse(image1, image2, block_size)
    [height, width, ~] = size(image1);
    psnr_sum = 0;
    mse_sum = 0;

    for i = 1:block_size:height
        for j = 1:block_size:width
            block1 = image1(i:i+block_size-1, j:j+block_size-1, :);
            block2 = image2(i:i+block_size-1, j:j+block_size-1, :);

            % Ensure the blocks have the same shape
            min_height = min(size(block1, 1), size(block2, 1));
            min_width = min(size(block1, 2), size(block2, 2));
            block1 = block1(1:min_height, 1:min_width, :);
            block2 = block2(1:min_height, 1:min_width, :);

            mse = mean((block1 - block2).^2, 'all');

            if mse > 1e-10  % A small positive value to avoid division by zero
                psnr = 10 * log10(255^2 / mse);
                psnr_sum = psnr_sum + psnr;
                mse_sum = mse_sum + mse;
            end
        end
    end

    if psnr_sum == 0
        avg_psnr = Inf;
    else
        avg_psnr = psnr_sum / (height * width / block_size^2);
    end

    avg_mse = mse_sum / (height * width / block_size^2);
end
