## Copyright (C) 2017 David Ryan
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
## @deftypefn {Function File} {@var{retval} =} square (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: David Ryan <davidryan@David-Ryans-MacBook-Air.local>
## Created: 2016-11-02

function [retval] = waveform5Square (vector1)

% Copied from waveformSquare twice, to decouple two functions
sq1 = -1+2*floor(mod(2*(0.5+vector1),2));
sq3 = -1+2*floor(mod(2*(0.5+3*vector1),2));

% Make a function based on the square wave but which removes
% all harmonics a multiple of 3
retval = 0.75*sq1-0.25*sq3;

endfunction
