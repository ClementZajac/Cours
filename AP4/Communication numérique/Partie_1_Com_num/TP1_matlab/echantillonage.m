% Time vector
t = 0 : .00025 : 1;
  
% Original signal
x = cos(2 * pi * 50 * t);
  
% Reduces the sample rate of original signal by factor of 4
y = decimate(x, 4); 
  
figure()
subplot(2, 2, 1);
  
% Plot few samples of the Original signal
stem(x(1:75)) 
title('Original Signal');
  
subplot(2, 2, 2);
  
% Plots few samples of the Decimated signal
stem(y(1:75)); 
title('Decimated Signal');