% https://de.mathworks.com/help/images/examples/deblurring-images-using-a-wiener-filter.html?requestedDomain=www.mathworks.com
% Deblurring Images Using a Wiener Filter

%% openExample('images/WienerImageDeblurringExample');
I = im2double(imread('yourImage.jpg'));
imshow(I)
title('Orginal')
Orginal = im2double(imread('yourImage.jpg'));
 

%% simulate Motion Blur
LEN = 21;
THETA = 11;
PSF = fspecial('motion', LEN, THETA);
blurred = imfilter(I, PSF, 'conv', 'circular');
imshow(blurred)
title('Blurred Image')

%% restore the blurred Image
wnr1 = deconvwnr(blurred, PSF, 0);
imshow(wnr1)
title('Restored Image')


%% simulate Blur and Noise
noise_mean = 0;
noise_var = 0.0001;
blurred_noisy = imnoise(blurred, 'gaussian', noise_mean, noise_var);
imshow(blurred_noisy)
title('Simulate Blur and Noise')
    

%% restore the Blurred an Noisy Image: First Attemt
wnr2 = deconvwnr(blurred_noisy, PSF, 0);
imshow(wnr2)
title('Restoration of Blurred, Noisy Image - NSR 0 0')


%% restore the Blurred and Noisy Image: Second Attempt
signal_var = var(I(:));
wnr3 = deconvwnr(blurred_noisy, PSF, noise_var / signal_var);
imshow(wnr3)
title('Restoration of Blurred, Noisy Image- Estimated NSR');

%% Simulate Blur and 8-Bit Quantization Noise
I = imread('yourImage.jpg');
class(I)
blurred_quantized = imfilter (I, PSF, 'conv', 'circular');
class(blurred_quantized)
imshow(I)

%% Restore the Blurred, Quantized Image: First Attempt
wnr4 = deconvwnr(blurred_quantized, PSF, 0);
imshow(wnr4)
title('Restoration of blurred, quantized image - NSR = 0');

%% Restore the Blurred Quantized Image: Second Attempt
uniform_quantization_var = (1/256)^2 / 12;
signal_var = var(im2double(I(:)));
wnr5 = deconvwnr(blurred_quantized, PSF, uniform_quantization_var / signal_var);
imshow(wnr5)
title('Restoration of Blurred, Quantized Image - Estimated NSR');