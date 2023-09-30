start

b=binary(2000);

x=wave_gen(b,'unipolar_nrz',1000);

y=channel(x,2, 0.1, 4900);

m=match('unipolar_nrz',y);

eye_diag(m);