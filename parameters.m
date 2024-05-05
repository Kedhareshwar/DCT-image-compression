originalImage = imread('STScI-01GGF8H15VZ09MET9HFBRQX4S3.png');
compressedImage = imread('compressed_image_rgb75%.jpg');
% Resize the original image to a smaller size
scaleFactor = 0.7; % Adjust the scale factor as needed
originalImage = imresize(originalImage, scaleFactor);
% Define the standard deviation (sigma) for Gaussian smoothing
sigma = 1.0; % You can adjust this value as needed 0.5 to 2.0

% Define the filter size (optional)
filtSize = [5, 5, 5]; % You can adjust this size as needed

% Apply Gaussian smoothing to the image
compressedImage = imgaussfilt3(originalImage, sigma, 'FilterSize', filtSize, 'Padding', 'replicate');


psnrValue = psnr(compressedImage, originalImage);
ssimValue = ssim(compressedImage, originalImage);
mseValue = immse(compressedImage, originalImage);
originalSize = numel(originalImage);
compressedSize = numel(compressedImage);
compressionRatio = originalSize / compressedSize;

% Display the metrics
disp(['PSNR: ', num2str(psnrValue)]);
disp(['SSIM: ', num2str(ssimValue)]);
disp(['MSE: ', num2str(mseValue)]);
disp(['Compression Ratio: ', num2str(compressionRatio)]);