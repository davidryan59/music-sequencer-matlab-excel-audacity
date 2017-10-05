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

function [retval] = waveformSawtooth (vector1)

retval = 1 - 2 * (vector1 - floor(vector1));
% Return a sawtooth wave between -1 and 1

% Note: in May 2017 this was inverted, previously -1 + 2 * ...
% This was in order to make the waveform agree with the natural sawtooth
% which is s1 + (1/2)s2 + (1/3)s3... (sN is sin(2*pi*N*t))
% This aids additive processing with sawtooths / squares of different frequencies.

endfunction
