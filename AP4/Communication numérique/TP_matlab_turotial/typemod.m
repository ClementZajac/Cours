function typemod

r1=wave_gen([1 0 1 0],'unipolar_nrz',1000);
r1f=abs(fft(r1,64));
r2=wave_gen([1 0 1 0],'unipolar_rz',1000);
r2f=abs(fft(r2,64));
r3=wave_gen([1 0 1 0],'polar_nrz',1000);
r3f=abs(fft(r3,64));
r4=wave_gen([1 0 1 0],'polar_rz',1000);
r4f=abs(fft(r4,64));
r5=wave_gen([1 0 1 0],'bipolar_nrz',1000);
r5f=abs(fft(r5,64));
r6=wave_gen([1 0 1 0],'bipolar_rz',1000);
r6f=abs(fft(r6,64));
r7=wave_gen([1 0 1 0],'manchester',1000);
r7f=abs(fft(r7,64));
r8=wave_gen([1 0 1 0],'triangle',1000);
r8f=abs(fft(r8,64));
r9=wave_gen([1 0 1 0],'nyquist',1000);
r9f=abs(fft(r9,64));
r10=wave_gen([1 0 1 0],'duobinary',1000);
r10f=abs(fft(r10,64));
r11=wave_gen([1 0 1 0],'mod_duobinary',1000);
r11f=abs(fft(r11,64));

figure
subplot(4,3,1)
plot(r1)
title('unipolar_nrz')
subplot(4,3,2)
plot(r2)
title('unipolar_rz')
subplot(4,3,3)
plot(r3)
title('polar_nrz')
subplot(4,3,4)
plot(r4)
title('polar_rz')
subplot(4,3,5)
plot(r5)
title('bipolar_nrz')
subplot(4,3,6)
plot(r6)
title('bipolar_rz')
subplot(4,3,7)
plot(r7)
title('manchester')
subplot(4,3,8)
plot(r8)
title('triangle')
subplot(4,3,9)
plot(r9)
title('nyquist')
subplot(4,3,10)
plot(r10)
title('duobinary')
subplot(4,3,11)
plot(r11)
title('mod_duobinary')

figure
subplot(4,3,1)
plot(r1f(1:32))
title('unipolar_nrz')
subplot(4,3,2)
plot(r2f(1:32))
title('unipolar_rz')
subplot(4,3,3)
plot(r3f(1:32))
title('polar_nrz')
subplot(4,3,4)
plot(r4f(1:32))
title('polar_rz')
subplot(4,3,5)
plot(r5f(1:32))
title('bipolar_nrz')
subplot(4,3,6)
plot(r6f(1:32))
title('bipolar_rz')
subplot(4,3,7)
plot(r7f(1:32))
title('manchester')
subplot(4,3,8)
plot(r8f(1:32))
title('triangle')
subplot(4,3,9)
plot(r9f(1:32))
title('nyquist')
subplot(4,3,10)
plot(r10f(1:32))
title('duobinary')
subplot(4,3,11)
plot(r11f(1:32))
title('mod_duobinary')

