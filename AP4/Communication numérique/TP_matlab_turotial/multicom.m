%clear
%close(1)
%close(2)
qmf = MakeONFilter('Haar');
D=9;
D1=D;
num=D;
n=2^D;
ds=50; % nombre de symboles
port=.1;
nbfreq=4;
niv=1;
bande=[.01];
fs=1;
bruit=randn(512,1);
[signala,ama]=anaask(n,fix(n/ds),port);
infoa=canal(real(signala),1,niv,bande,fs,ds);
wca  = FWT_PO(infoa,1,qmf);%analyse par multiresolution
[signalp,amp]=anabpsk(n,fix(n/ds),port);
infop=canal(real(signalp),1,niv,bande,fs,ds);
wcp  = FWT_PO(infop,1,qmf);%analyse par multiresolution
[signalf,amf]=anafsk(n,fix(n/ds),nbfreq);
infof=canal(real(signalf),1,niv,bande,fs,ds);
wcf  = FWT_PO(infof,1,qmf);%analyse par multiresolution
end
figure
subplot(331)
plot(ama)
subplot(332)
DisplayMultiRes(wca,1,0,qmf,'Image')
subplot(333)
PlotMultiRes(wca,1,0,qmf)
subplot(334)
plot(amp)
subplot(335)
DisplayMultiRes(wcp,1,0,qmf,'Image')
subplot(336)
PlotMultiRes(wcp,1,0,qmf)
subplot(337)
plot(amf)
subplot(338)
DisplayMultiRes(wcf,1,0,qmf,'Image')
subplot(339)
PlotMultiRes(wcf,1,0,qmf)
colormap(jet)
nvoices=100;
fmin=0.01;
[tfra,t,f,wta]=tfrscalo(hilbert(real(signala)),[1:n],0,fmin,.5,nvoices,1);
[tfrp,t,f,wtp]=tfrscalo(hilbert(real(signalp)),[1:n],0,fmin,.5,nvoices,1);
[tfrf,t,f,wtf]=tfrscalo(hilbert(real(signalf)),[1:n],0,fmin,.5,nvoices,1);
figure
subplot(331)
plot(ama)
subplot(332)
imagesc(tfra)
subplot(334)
plot(amp)
subplot(335)
imagesc(tfrp)
subplot(337)
plot(amf)
subplot(338)
imagesc(tfrf)
subplot(333);plot(tfra(nvoices,:)/max(tfra(nvoices,:)));hold on;plot(ama,'r')
subplot(336);plot(tfrp(nvoices,:)/max(tfrp(nvoices,:)));hold on;plot(amp,'r')
subplot(339);plot(tfrf(nvoices,:)/max(tfrf(nvoices,:)));hold on;plot(amf,'r')
g=ones(1,1);
h=window(51,'Hamming');
[tfra,t,freq]=tfrspwv(hilbert(real(signala)),[1:n],length(signala),g,h,1);
[tfrp,t,freq]=tfrspwv(hilbert(real(signalp)),[1:n],length(signalp),g,h,1);
[tfrf,t,freq]=tfrspwv(hilbert(real(signalf)),[1:n],length(signalf),g,h,1);
figure
ind=fix(port*length(signala)/0.5);
subplot(331)
imagesc(t,freq,tfra)
subplot(332)
plot(freq,tfra(:,100))
subplot(333)
plot(tfra(ind,:)/max(tfra(ind,:)))
hold on
plot(ama,'r')
subplot(334)
imagesc(t,freq,tfrp)
subplot(335)
plot(freq,tfrp(:,100))
subplot(336)
plot(tfrp(ind,:)/max(tfrp(ind,:)))
hold on
plot(amp,'r')
subplot(337)
imagesc(t,freq,tfrf)
subplot(338)
plot(freq,tfrf(:,100))
subplot(339)
plot(tfrf(ind,:)/max(tfrf(ind,:)))
hold on
plot(amf,'r')
end