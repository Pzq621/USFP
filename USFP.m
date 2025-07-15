
clear;close all;
clc;

RF_3D = load(['Rawdata.mat']);

% Parameter setting
num_rec=RF_line_samples; 
fs=5*10^7;  % Sample frequency
Ts=1/fs;
N0=2*10^5;
L0=100000;
ya=(zeros(1,L0))';
aa=1;
window=10;
interval=0;
freqstart=88000*2+25000-14000*0; freqstop=266000-14000+60000;freqstart1=1; freqstop1=freqstop-freqstart-1; % 8-12 MHz
dia_u1=zeros(20,1);
N2=(L0+RF_length)*(window+1);
n2=0:N2-1;
f2=n2*fs/N2;

% New variation
Curve=zeros(ROI_lines_info,1);
Amp=zeros(ROI_lines_info,1);

Rec_TimeDomain=RF_3D.RF_3D(:,1,1);
for n0=1:1:ROI_lines_info;
    siga=([]);
for m0=1:1:10
    sigm=RF_3D.RF_3D(:,m0,n0);
    sigmm=sigm();
    sigmm=[sigmm;ya];
    siga=[siga;sigmm];
end
sigrec=siga';


clear siga
clear recup


Xrec=fft(sigrec,N2);
ampl2=abs(Xrec);
frec=f2;
amplrec=ampl2(freqstart:freqstop); 
[ecoup,ecodown] = envelope(amplrec,200,'peak'); 
recup=ecoup;

f1=1;
[m,l]=max(recup(f1:42600));
Curve(n0)=l;
Amp(n0)=m;

end
s=(Curve+freqstart+f1)*fs/N2;
plot(s);
figure();plot(Amp);

