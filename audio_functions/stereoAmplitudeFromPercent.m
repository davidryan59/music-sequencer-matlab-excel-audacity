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
## @deftypefn {Function File} {@var{retval} =} sawtooth (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: David Ryan <davidryan@David-Ryans-MacBook-Air.local>
## Created: 2016-11-02

function [retval] = stereoAmplitudeFromPercent (percentValues)

% Input vector(:) of N values in the range -100 (L) to 0 (M) to +100 (R)

percentPos = max(-1, min(1, percentValues(:)./100));
ampR = 1 + percentPos;
ampL = 1 - percentPos;

retval = [ampL ampR];

endfunction











