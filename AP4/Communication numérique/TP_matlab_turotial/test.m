b=binary(500);
y=modulate(b,'ask',8000,1000);
z=channel(y,1,0.5,4900);
waveplot(z)
demol=mixer(z,osc(8000));
t=match('unipolar_nrz',demol);

eye_diag(t);
%z2=rc(500,z);
%z3=match('polar_nrz',z2);
%eye_diag(z3);

%
b4=[ 1 0 0 1 0];
x4=wave_gen(b4,'polar_nrz',1000);
waveplot(x4);
z4=match('polar_nrz',x4);
%waveplot(z4);
%
T2=10e-03;
debit2=1/T2;
x=wave_gen(b4,'triangle',debit2);
%waveplot(x)
%
T2=10e-03;
debit2=1/T2;
x2=wave_gen(b4,'manchester',debit2);
y2=match('manchester',x2);
%waveplot(y2)
