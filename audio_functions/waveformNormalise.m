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
## @deftypefn {Function File} {@var{retval} =} waveNormalise (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: David Ryan <davidryan@David-Ryans-MacBook-Air.local>
## Created: 2016-11-02

function [retval] = waveformNormalise (audio1)

% There should be either 1 (mono) or 2 (stereo) columns,
% and many rows.
% If there are more columns than rows, transpose audio
if (size(audio1,1) < size(audio1,2))
  audio1=audio1';
endif

% Allow amplitudes between -max and max.
% Must be within -1 to 1.
maxAmp = 0.9999;

% Minimum amplitude to increase to maxAmp - must be greater than 0
minAmp = 0.000001;

% Find the maximum value in both columns, suitably bounded.
colsMult = max(minAmp,max(max(abs(audio1))));

retval = maxAmp * (audio1./colsMult);
% Note - doing it this way maps a zero to a zero. Probably a good thing.

endfunction
