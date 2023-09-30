clear all;
close all;
clc;

%% G�n�ration du signal
Fe = 20000;
N = 1024;
k = 0:N-1;
t = k/Fe;
f1 = ;
f2 = ;
f3 = ;
a1 = ;
a2 = ;
a3 = ;
x1 = ;
x2 = ;
x3 = ;
s = x1 + x2 + x3;

% Calcule de la Transform�e de Fourier du signal s(t)
f = k*Fe/N;
TFs = abs(fft(s));

figure (1)
subplot (2,1,1);
plot (t, s, '');
title ('G�n�ration du signal s(t)');
xlabel ('Temps (s)');
ylabel ('Amplitude');
grid
subplot (2,1,2);
plot (f, TFs, '');
title ('Transform�e de Fourier du signal s(t)');
xlabel ('Fr�quence (Hz)');
ylabel ('Amplitude [M(f)]');
grid

%% G�n�ration du bruit
p = 0.8;
moy = 0;
b = moy + p*randn(1,N);
figure (2)
plot (t, b, 'k');
title ('G�n�ration du signal b(t)')
xlabel ('Temps (s)');
ylabel ('Amplitude')
grid

%% Ajout du bruit au signal 
Sb = ;
figure (3)
plot (t, Sb, 'g');
title ('G�n�ration du signal bruit� Sb(t)');
xlabel ('Temps (s)');
ylabel ('Amplitude');
grid

TFSb = abs(fft(Sb));
figure (4)
plot (f, TFSb, '');
title ('Transform�e de Fourier du signal bruit� Sb(t)')
xlabel ('Fr�quence (Hz)');
ylabel ('Amplitude [M(f)]')
grid


figure (5)
subplot (2,1,1);
plot (t, TFs, '');
title ('Transform�e de Fourier du signal s(t)')
xlabel ('Temps (s)');
ylabel ('Amplitude [M(f)]')
grid
subplot (2,1,2);
plot (f, TFSb, 'r');
title ('Transform�e de Fourier du signal Sb(t)')
xlabel ('Fr�quence (Hz)');
ylabel ('Amplitude [M(f)]')
grid
%% Extraction du signal x2


te = 1/Fe;
f2 = 3750;
fn1 = 3700;
fn2 = 3800;
fn3 = 16200;
fn4 = 16300;
n = N*f2/Fe;
n1 = round(N*fn1/Fe);
n2 = round(N*fn2/Fe);
n3 = round(N*fn3/Fe);
n4 = round(N*fn4/Fe);
p = [zeros(1,n1) ones(1,n2-n1) zeros(1,n3-n2) ones(1,n4-n3) zeros(1,n1)];
TFx2 = p.*TFs;
figure (6)
subplot (2,2,1);
plot (t, p, '');
title ('G�n�ration du signal p(n)')
xlabel ('Points (N)');
ylabel ('Amplitude P(N)')
grid
subplot (2,2,2);
plot (f, p, '');
title ('Signal p(t) dans le domaine fr�quentiel)')
xlabel ('Fr�quence (Hz)');
ylabel ('Amplitude [P(f)]')
grid
subplot (2,2,3);
plot (TFx2, '');
title ('Transform�e de Fourier du signal x2(t)')
xlabel ('Points (N)');
ylabel ('Amplitude [X(N)]')
grid
subplot (2,2,4);
plot (f, TFx2, 'r');
title ('Transform�e de Fourier du signal x2(t)')
xlabel ('Fr�quence (Hz)');
ylabel ('Amplitude [X(f)]')
grid

%% Extraction du signal X2(t)
X2 = ifft(TFx2);
figure (7)
plot (t, X2, 'k');
title ('G�n�ration du signal X2(t)');
xlabel ('Temps (s)');
ylabel ('Amplitude X2(t)');
grid

% Comparaison de x2(t) initial et X2(t) extrait
e = conv(normalize(x2),normalize(real(X2)));
figure (8)
subplot (3,1,1);
plot (t, x2, '');
title ('G�n�ration du signal x2(t) initial');
xlabel ('Temps (s)');
ylabel ('Amplitude x2(t)');
grid
subplot (3,1,2);
plot (t, X2, 'k');
title ('G�n�ration du signal X2(t) extrait')
xlabel ('Temps (s)');
ylabel ('Amplitude [X2(t)]')
grid
subplot (3,1,3);
plot ( e, 'r');
title ('Convolution (x2,X2)')
xlabel ('Echantillons');
ylabel ('Amplitude')
grid





