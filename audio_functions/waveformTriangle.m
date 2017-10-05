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

function [retval] = waveformTriangle (vector1)

% Adjust phase so that final wave starts at 0 ascending
vector2 = vector1+0.25;

% This gives a sawtooth period 1
vector2 = vector2 - floor(vector2);  

% This gives a triangle period 1, from 0 to 0.5
vector2 = min(vector2,1-vector2);

% After scaling, it has mean 0 and amplitude 1
retval = 4*vector2 - 1;

endfunction











