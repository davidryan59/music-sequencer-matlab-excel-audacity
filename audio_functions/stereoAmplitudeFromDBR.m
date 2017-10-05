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

function [retval] = stereoAmplitudeFromDBR (dBR)

% Input vector(:) of N values representing how much louder R channel is than L channel
% Suggested range is -50 (almost full L) to +50 (almost full R)
% Output Nx2 values representing the amplitude onto each stereo channel

ampR = 2./(1+10.^(dBR(:)./20));
ampL = 2./(1+10.^(-dBR(:)./20));
% Previous function took square roots of these amplitudes (with a ./10 divisor)
% This conserved power
% However, it was thought better to not do that
% Then the two tracks stereo combined into mono give a constant amplitude
% In otherwords - split on constant amplitude, not constant power

% Effective range of dBR is around -50 to +50, beyond that there is little difference.

retval = [ampL ampR];

endfunction











