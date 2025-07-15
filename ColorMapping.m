
close all



frequencyData = freq; % frequency rawdata
signalStrength = amp; % amplitude rawdata

figure;

% Color mapping
imagesc(frequencyData);
colormap(jet); % jet colormap
clim([9500000 10000000])
colormap(flipud(colormap))
colorbar;
title('Frequency color mapping');
xlabel('X axis');
ylabel('Y axis');

% Transparency mask
hold on;
h = imagesc(frequencyData);
set(h, 'AlphaData', signalStrength); 
hold off;