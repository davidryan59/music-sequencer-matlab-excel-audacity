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
## @deftypefn {Function File} {@var{retval} =} movAvg (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: David Ryan <davidryan@David-Ryans-MacBook-Air.local>
## Created: 2016-11-02

function [retval] = averageMoving (vector1,points1)

vector1=vector1(:);  % Make any matrix into a column vector
len1=length(vector1); % Returned smoothed vector will be same length as this

offset2 = min(1000000,max(0, round((points1(1) - 1 ) / 2 )));  % 0, 1, 2, 3...
points2 = offset2 * 2 + 1;                                     % 1, 3, 5, 7...

if (offset2 == 0)
retval = vector1;    % Moving average on 1 point returns straightened vector
return
endif

vector2 = [vector1(1)*ones(offset2,1) ; vector1 ; vector1(end)*ones(offset2,1)];
vector3 = [0;cumsum(vector2)];

vectStart = vector3(1:len1);
vectEnd = vector3((end-len1+1):end);

retval = (vectEnd - vectStart)/points2;

endfunction
