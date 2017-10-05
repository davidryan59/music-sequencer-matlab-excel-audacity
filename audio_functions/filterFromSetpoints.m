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
## Created: 2017-05-03

function [retval] = filterFromSetpoints (waveform, sampleFreq, setpointMx)

% Format of setpoints matrix should be [freq in Hz, relative Amp in dB]
% Hz should normally be in range 1 Hz to 30000 Hz
% relative amp should be in range -120 dB to 30 dB

% Usually this function is used for filtering (negative dB),
% however can also be used to boost certain ranges (positive dB)

% Clean the parameters
sampleFreq = abs(sampleFreq(1));     % Typical value: 44100 (Hz)
waveform = waveform(:);              % Nx1 column vector now

% Check for parameter errors
if sampleFreq<1
  % Sample frequency invalid
  retval = waveform;
  return
endif
if length(waveform)<5
  % Waveform invalid
  retval = waveform;
  return
endif
row1 = size(setpointMx,1);
col1 = size(setpointMx,2);           % setpointMx has at least 1 row and 2 columns
if (row1<1)||(col1<2)||(row1>10000)   % Not too large either
  % Setpoint matrix invalid
  retval = waveform;
  return
endif

% Do the FFT
fwaveVect = fft(waveform);
lenWave = length(fwaveVect);

% Find the midpoint
mid1 = ceil(lenWave/2);          % End of 1st section
mid2 = 1+floor(lenWave/2);       % Start of 2nd section

% Find the component to process (fwaveVect2)
fwave0 = fwaveVect(1);
fwaveVect2 = fwaveVect(2:mid1);
if (mod(lenWave,2)==0)
  fwaveM = fwaveVect(lenWave/2);
else
  fwaveM = zeros(0,1);           % Empty if lenWave is odd. Single value if its even.
endif
lenWave2 = length(fwaveVect2);

% Get rid of zero and Nyquist components
fwave0 = 0 * fwave0;             % Force the time-average to zero
fwaveM = 0 * fwaveM;             % Filter out the Nyquist frequency, if it exists

% Get frequency increment, frequency vector, pitch vector
freqInc = sampleFreq./lenWave;           % Each increment in FFT range represents this range of frequencies
freqVect = freqInc.*(1:lenWave2)';       % Frequencies in the (first half of the) FFT
pitchVect = log2(freqVect);              % Pitches in the (1st half) FFT
dBVect = zeros(lenWave2,1);              % Main job is to alter this according to the setpoints

% Get minimum and maximum pitches - make them a bit smaller/larger to top and tail the setpoints.
minPitch = pitchVect(1)-0.5;        % Minimum pitch, minus half an octave just to be sure
maxPitch = pitchVect(end)+0.5;      % NOT NEEDED?

% Have now got all the info needed.
% In particular, fwaveVect2 needs to be multiplied by appropriate dB value for each corresponding pitchVect
% Need to do that on a loop

minFreq = 2.^minPitch;
nyqFreq = sampleFreq/2;

setpointMx = setpointMx(:,1:2);                              % Extract first two columns only
setpointMx(:,1) = max(minFreq,min(nyqFreq,setpointMx(:,1))); % Freqs should be +ve, between min and Nyq. Truncate otherwise.
setpointMx = sortrows(setpointMx,1);                         % Sort in ascending order of frequency

newFirstRow = [minFreq setpointMx(1,2)];
newLastRow = [nyqFreq setpointMx(end,2)];
setpointMx = [newFirstRow;setpointMx;newLastRow];         % Top and tail setpoint matrix with level sections

sectionCount = size(setpointMx,1)-1;                      % Number of sections to check amplitudes over

%% DEBUG
%display(round(setpointMx));
%display(sectionCount);
%return

for s1 = 1:sectionCount
  
  startFreq = setpointMx(s1,1);
  startPitch = log2(startFreq);
  endFreq = setpointMx(s1+1,1);
  endPitch = log2(endFreq);
  startDB = setpointMx(s1,2);
  endDB = setpointMx(s1+1,2);
  
  if startFreq==endFreq
    % This row does nothing, continue to next row
    continue
  endif
  
  % DEBUG
  %display(startPitch);
  %display(endPitch);
  %display(startPitch<=pitchVect);
  %display(pitchVect<endPitch);
  %display((startPitch<=pitchVect).*(pitchVect<endPitch));
  
  pitchInRangeIndex = and(startPitch<=pitchVect,pitchVect<endPitch);
  
  % DEBUG
  %display(sum(pitchInRangeIndex));
  %display(pitchInRangeIndex);
  
  if sum(pitchInRangeIndex)<0.5
    % No pitches found
    continue
  endif
  
  dBDiff = endDB - startDB;
  pitchDiff = endPitch - startPitch;
  
  if (abs(pitchDiff)<0.000001)||(abs(dBDiff)<0.01)
    % Constant dB in pitch range
    averageDB = (startDB+endDB)./2;
    dBVect(pitchInRangeIndex) = averageDB;
  else
    % Linear interpolation of dB in pitch range
    multFactor = dBDiff./pitchDiff;
    dBVect(pitchInRangeIndex) = startDB + multFactor.*(pitchVect(pitchInRangeIndex)-startPitch);
  endif
    
endfor

% DEBUG
%plot(freqVect,dBVect);

% Alter fwaveVect2 amplitudes based on dBVect
ampVect = 10.^(dBVect./20);
fwaveVect2 = ampVect.*fwaveVect2;

% Reconstruct signal from altered fwaveVect2
retval = real(ifft([fwave0;fwaveVect2;fwaveM;conj(fwaveVect2(end:-1:1))]));

% DEBUG
%a1 = (1:length(retval))';
%display(size(a1));
%display(size(waveform));
%display(size(retval));
%display(size(fwaveM));
%plot(a1,waveform,'r',a1,retval,'g');

endfunction
