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

function [retval] = fadeStartAndEnd (waveform, samplesAtStart, samplesAtEnd, dBReduce)

% Fade the start and end of a track by a certain number of dB
% dBReduce should be a negative number, e.g. -30

% Check input
samplesAtStart = round(abs(samplesAtStart(1)));
samplesAtEnd = round(abs(samplesAtEnd(1)));
samplesBoth = samplesAtStart+samplesAtEnd;
dBReduce = max(-200,min(-1,-abs(dBReduce(1))));
lenWave = length(waveform);

if samplesBoth>lenWave
  samplesAtStart = round(samplesAtStart./samplesBoth);
  samplesAtEnd = round(samplesAtEnd./samplesBoth);
endif

% Fade from 0 to 1 at start
tempPadAmp = dBReduce.*(1-interpLinear(samplesAtStart));
tempPadAmp = 10.^(tempPadAmp./20);
tempRange = 1:samplesAtStart;
waveform(tempRange) = waveform(tempRange).*tempPadAmp;

% Fade from 1 to 0 at end
tempPadAmp = dBReduce.*(interpLinear(samplesAtEnd));
tempPadAmp = 10.^(tempPadAmp./20);
tempRange = (lenWave-samplesAtEnd+1):lenWave;
waveform(tempRange) = waveform(tempRange).*tempPadAmp;

retval = waveform;

endfunction
