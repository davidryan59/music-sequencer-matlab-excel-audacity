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

function [retval] = waveformRandom (vector1,randSample)

% ASSUMING THAT randSample is between 0 and 1

% Input randSample to allow re-use of the same (long-ish) random vector
% Too small = sounds periodic
% Too long = computationally expensive
% Use an input vector of maybe 20000 (roughly half a second at 44100Hz sample rate)

randSample = randSample(:);
% Straighten any input matrix into column vector here.

lenSample = length(randSample);
vector1 = floor(mod(vector1 + lenSample*rand,lenSample)+1);
% Can now use vector2 to resample (at a random position) from the random sample

retval = -1 + 2*randSample(vector1);
% Return a random wave between -1 and 1

endfunction
