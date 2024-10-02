load lighthouse.mat; %load image data, it is stored in xx
ww = xx; %storing data in new variable
ww_ds = ww(1:2:end, 1:2:end); %downscaling image and storing it in ww_ds

%Plot images
figure;
show_img(ww); %Original Image
figure;
show_img(ww_ds); %Downsampled Image

%Lab Exercise 3.2: Reconstruction of Images
% Create the downsampled image by a factor of 3
xx3 = ww(1:3:end, 1:3:end);

% Display the downsampled image
figure;
show_img(xx3); %Downsampled Image by 3

%3.2a
xr1 = (-2).^(0:6);
L = length(xr1);
nn = ceil((0.999:1:4*L)/4);
xr1hold = xr1(nn);
figure;
plot(xr1hold);
stem(nn, xr1hold); title('Stem Plot with Discrete Values');
xlabel('Sample Index');
ylabel('Signal Value');
grid on;

%3.2b Interpolating rows
xx3 = ww(1:3:end, 1:3:end);
xholdrows = zeros(size(xx3,1), 3*size(xx3,2));
for i = 1:size(xx3,1)
    row = xx3(i,:);
    xholdrows(i,:) = row(ceil((0.999:1:3*length(row))/3));
end
figure;
show_img(xholdrows);


%3.2c Interpolating column
xhold = zeros(3*size(xholdrows,1), size(xholdrows,2));
for i = 1:size(xholdrows,2)
    col = xholdrows(:,i);
    xhold(:,i) = col(ceil((0.999:1:3*length(col))/3));
end
figure;
show_img(xhold);
title('Hawa - Zero-Order Hold Interpolated Image');
xlabel('X Pixel Index');
ylabel('Y Pixel Index');


%3.d Linear interpolation
n1 = 0:6;
xr1 = (-2).^n1;
tti = 0:0.1:6;
xr1linear = interp1(n1, xr1, tti);
figure;
stem(tti, xr1linear);

%3.2e 
% Interpolate rows
xx3 = ww(1:3:end, 1:3:end);
[xrows, xcols] = size(xx3);
xinterp1 = zeros(xrows, 3*xcols);
for i = 1:xrows
    xinterp1(i,:) = interp1(1:xcols, xx3(i,:), 1:1/3:xcols, 'linear');
end

% Interpolate columns
[rows, cols] = size(xinterp1);
xinterp = zeros(3*rows, cols);
for i = 1:cols
    xinterp(:,i) = interp1(1:rows, xinterp1(:,i), 1:1/3:rows, 'linear');
end
figure;
show_img(xinterp);

