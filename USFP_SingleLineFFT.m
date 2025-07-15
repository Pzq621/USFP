clear;
clc;

RF_length = 128 ;         
% RF_lines = 5750;        
RF_line_samples = 201;   
ROI_lines_info = [20];  
RF_lines=RF_line_samples*ROI_lines_info;

% Read raw data
[file,path] = uigetfile('*.bin');
fid = fopen([path,file],'rb') ;
RF_2D = fread(fid, [RF_length,RF_lines], 'int16');
fclose(fid);


%% Reshape to single line matrix 
RF_3D = reshape(RF_2D,[RF_length,RF_line_samples,sum(ROI_lines_info)]);  % reshape to 3D matrix, 1D denotes RF data, 2D denotes RF line samples, 3D denotes each line of all ROIs



num_rec=RF_line_samples; 
fs=5*10^7;  
Ts=1/fs;
N0=2*10^5; 
L0=100000;
ya=(zeros(1,L0))';



aa=1;
window=10; 
interval=0;

freqstart=88000*2+25000-14000*0; freqstop=150000*2;freqstart1=1; freqstop1=freqstop-freqstart-1; %取频谱区间初始freqstart1=10000; 设置窗口
dia_u1=zeros(40,1);
N2=(L0+RF_length)*(window+1);
n2=0:N2-1;
f2=n2*fs/N2;

siga=([]);

Rec_TimeDomain=RF_3D(:,1,10);

for m0=1:1:10
    sigm=RF_3D(:,m0,16);
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

