% Set compression factor (adjust as needed)
compressionFactor = 0.9; % e.g., 0.5 means 50% compression

% Read the original image
originalImage = imread('STScI-01GGF8H15VZ09MET9HFBRQX4S3.png'); % Replace with your image path

% Get the dimensions of the original image
[height, width, ~] = size(originalImage);

% Calculate the number of coefficients to keep based on compression factor
coefficientsToKeep = round(compressionFactor * height * width);

% Set block size for processing (larger block size reduces the number of blocks)
blockSize = 60;

% Perform DCT-based compression on each color channel
compressedImage = zeros(size(originalImage), 'uint8');
for channel = 1:3 % Process each color channel separately (R, G, B)
    channelData = originalImage(:,:,channel);

    % Perform DCT on larger blocks of the channel data
    dctChannel = blockproc(double(channelData), [blockSize blockSize], @(block_struct) dct2(block_struct.data));

    % Flatten the DCT coefficients and sort them in descending order
    dctCoefficients = reshape(dctChannel, [], 1);
    [dctSorted, dctIndices] = sort(abs(dctCoefficients), 'descend');

    % Zero out the coefficients to achieve compression
    dctCoefficients(dctIndices(coefficientsToKeep+1:end)) = 0;

    % Reshape the modified coefficients to their original block structure
    compressedDctChannel = reshape(dctCoefficients, size(dctChannel));

    % Perform inverse DCT to get the compressed channel data
    compressedChannel = uint8(blockproc(compressedDctChannel, [blockSize blockSize], @(block_struct) idct2(block_struct.data)));

    % Place the compressed channel data back into the corresponding channel of the output image
    compressedImage(:,:,channel) = compressedChannel;
end

% Display and save the original and compressed images
figure;
subplot(1, 2, 1);
imshow(originalImage);
title('Original Image');

subplot(1, 2, 2);
imshow(compressedImage);
title(['Compressed Image (', num2str(compressionFactor * 100), '%)']);

% Save the compressed image
imwrite(compressedImage, 'compressed_image_rgb.jpg'); % Replace with your desired output path
