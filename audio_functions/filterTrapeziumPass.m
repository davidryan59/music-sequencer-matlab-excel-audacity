## Copyright (C) 2016 David Ryan
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} sawtooth (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: David Ryan <davidryan@David-Ryans-MacBook-Air.local>
## Created: 2016-11-02

function [retval] = filterTrapeziumPass (waveform, sampleFreq, dBreduce, f1, f2, f3, f4)

% Reduce the amplitude by dBreduce outside of the trapezium.

% Below f1: zero amplitude
% Between f1 and f2: linearly increasing amplitude
% Between f2 and f3: original amplitude
% Between f3 and f4: linearly decreasing amplitude
% Above f4: zero amplitude

dBreduce = abs(dBreduce(1));
sampleFreq = abs(sampleFreq(1));
nyqFreq = sampleFreq/2;

min1 = 0.0001;
max1 = nyqFreq - min1;

f1 = max(min1,min(max1,abs(f1(1))));
f4 = max(f1+3*min1,min(max1,abs(f4(1))));
f2 = max(f1+min1,min(f4-2*min1,abs(f2(1))));
f3 = max(f2+min1,min(f4-min1,abs(f3(1))));
% Now in order 0, f1, f2, f3, f4, nyquist

fwave = fft(waveform(:));
lenWave = length(fwave);

mid1 = ceil(lenWave/2);          % End of 1st section
mid2 = 1+floor(lenWave/2);       % Start of 2nd section

fwave0 = fwave(1);
fwaveN = fwave(2:mid1);
fwaveM = fwave(mid1+1:mid2-1);   % Empty if lenWave is odd. Single value if its even.

% Do some stuff here
fwave0 = 0 * fwave0;             % Force the time-average to zero
fwaveM = 0 * fwaveM;             % Filter out the Nyquist frequency, if it exists

freqInc = sampleFreq./lenWave;                  % Each increment in FFT range represents this range of frequencies
freqN = freqInc.*(1:length(fwaveN))';            % Frequencies in the FFT

% Amplitudes in the increasing and decreasing sections
freqInc = (freqN - f1)./(f2-f1);
freqDec = (f4 - freqN)./(f4-f3);

% Multiply FFT signal by a trapezium amplitude vector (positive real number)
ampN = max(0,min(1,min(freqInc,freqDec)));
ampN = 10.^((dBreduce/20).*(ampN-1));
fwaveN = ampN.*fwaveN;

% Reconstruct signal
fwave2 = [fwave0;fwaveN;fwaveM;conj(fwaveN(end:-1:1))];
retval = real(ifft(fwave2));     % Real values only after inverting

endfunction















