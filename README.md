# Acoustic Emission Signal Analysis (SS316L)

High-resolution MATLAB DSP pipeline for analyzing acoustic emission (AE) signals from nuclear-grade stainless steel (SS316L). The workflow reconstructs raw AE waveforms, performs spectral decomposition, and differentiates GOOD vs. LOP weld signatures through time–frequency domain analysis.

## Features
- Bulk CSV ingestion of AE-Win export datasets (GOOD / LOP series)
- Reconstruction of emission waveforms (600 kHz sampling)
- Time-domain visualization with amplitude envelope inspection
- FFT-based spectral decomposition with `fft` + `fftshift`
- Frequency-magnitude profiling for defect-signature separation
- Comparative analysis of GOOD vs. LOP weld characteristics

## Technical Workflow
1. **Data Load**
   - Reads AE datasets (`*.csv`) exported from AE-Win using MATLAB I/O.
   - Converts AE numeric columns into unified matrices for batch processing.

2. **Signal Reconstruction**
   - Sampling frequency: **600,000 Hz**
   - Generates full timestamp vector (`t = 0 : 1/fs : tmax`)
   - Normalizes and plots time-domain waveforms.

3. **Frequency-Domain Analysis**
   - Computes DFT using `fft(m, x)`
   - Applies `fftshift` for centered spectrum
   - Extracts dominant frequency bands and magnitude distribution
   - Differentiates defect signatures via spectral peaks and bandwidth shifts

4. **Visualization**
   - Time domain: raw waveform, peak clusters, emission bursts
   - Frequency domain: symmetric FFT, magnitude spectrum, noise floor analysis

## Code Snippet (Core Logic)
```matlab
p = dir('D:\B.Tech\Mini Project\AE ANSII DATA\Series 01\Good\*.csv');
num = cell(size(p));

for i = 1:length(p)
    num{i} = xlsread(['D:\B.Tech\Mini Project\AE ANSII DATA\Series 01\Good\', p(i).name], 'A13:A1036');
end

m  = cell2mat(num);
fs = 600000;
ts = 1/fs;
x  = length(m);

t = 0:ts:(x-1)*ts;

figure; plot(t, m);

freq = (1:x) * (fs/x);
xdft = fftshift(fft(m, x));
mag  = abs(xdft);

figure; plot(freq, xdft);
figure; plot(freq, mag);
