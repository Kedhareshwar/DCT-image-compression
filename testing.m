% Load the original and compressed images
original = imread('STScI-01G8H49RQ0E48YDM8WKW9PP5XS.png');
compressed = imread('compressed_image_rgb50perc.jpg');

% Resize both images to a smaller size
max_height = 1080; % Set your desired maximum height
max_width = 1920;  % Set your desired maximum width
original = imresize(original, [max_height, max_width]);
compressed = imresize(compressed, [max_height, max_width]);

% Calculate PSNR
mse = mean(mean((double(original) - double(compressed)).^2));
max_pixel = 255.0;
psnr = 20 * log10(max_pixel / sqrt(mse));

% Calculate MSE
mse_value = mse;

% Calculate SSIM
ssim_value = ssim(original, compressed);

% Display the results
fprintf('PSNR value is %.2f dB\n', psnr);
fprintf('MSE value is %.2f\n', mse_value);
fprintf('SSIM value is %.4f\n', ssim_value);
