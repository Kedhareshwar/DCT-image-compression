compressedImage=imread('compressed_image_rgb.jpg');
originalImage=imread('STScI-01GGF8H15VZ09MET9HFBRQX4S3.png');
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