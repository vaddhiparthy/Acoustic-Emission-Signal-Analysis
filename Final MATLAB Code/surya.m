clc;clear all;close all;
p=dir('D:\B.Tech\Mini Project\AE ANSII DATA\Series 02\Slag\*.csv');
num=cell(size(p));
for i=1:length(p)
num{i}=xlsread(['D:\B.Tech\Mini Project\AE ANSII DATA\Series 02\Slag\',p(i).name],'A13:A1036');
end
m=cell2mat(num);
fs=600000;
ts=1/fs;
x=length(m);
tmax=(x-1)*ts;
t=0:ts:tmax;
figure;plot(t,m)
freq=[1:x]*(fs/x);
xdft=fftshift(fft(m,x));
mag=abs(xdft);
figure;plot(freq,xdft)
figure;plot(freq,mag)

   
