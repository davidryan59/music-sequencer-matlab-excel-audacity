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
## @deftypefn {Function File} {@var{retval} =} bandPass (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: David Ryan <davidryan@David-Ryans-MacBook-Air.local>
## Created: 2016-11-02

function [retval] = waveformBandPass (audio1, sampleRate)

if (nargin < 2)
sampleRate = 44100;
endif

% Filter out most of the stuff below 30 Hz and approaching the Nyquist frequency sampleRate/2

% Perform a quadratic (2-stage) smoothing step to remove stuff near Nyquist frequency
% Removes the high (H) frequencies
audioLM = average3point(average3point(audio1(:)));

% Perform a long moving average (roughly 1100 points for 44100Hz sample rate)
% which preferentially filters out low frequencies below 30Hz
% Isolate the low (L) frequencies)
param1 = floor(sampleRate(1)/40);
param2 = param1 + 10;
audioL = (averageMoving([0;audioLM;0],param1))(2:end-1);
audioL = (averageMoving([0;audioL;0],param2))(2:end-1);
% This adds a zero at start and end, does a moving average, truncates the outer 2 points.

% Return only the mid range (M) frequencies
retval = audioLM - audioL;

endfunction
