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
## Created: 2017-11-26

function [retval] = interpMethods (numberOfPoints,startValue,endValue,methodType)

% Method Type:
% 0 - zero order interpolation (use start value throughout)
% 1 - linear interpolation (linear from start to end)
% 2 - quadratic interpolation with turning point at start
% 3 - cubic interpolation with turning points at start and end
% 4 (or -2) - quadratic interpolation with turning point at end

% numberOfPoints checked on inner script
start1 = startValue(1);
end1 = endValue(1);
method1 = real(methodType(1));

diff1 = end1-start1;

switch method1
  case 0
    retval = interpZero(numberOfPoints);
  case 1
    retval = interpLinear(numberOfPoints);
  case 2
    retval = interpQuadFwd(numberOfPoints);
  case 3
    retval = interpCubic(numberOfPoints);
  case 4
    retval = interpQuadBack(numberOfPoints);
  case -2
    retval = interpQuadBack(numberOfPoints);
  otherwise
    % use linear interpolation (case 1)
    retval = interpLinear(numberOfPoints);
endswitch

retval = start1 + diff1.*retval;

endfunction
