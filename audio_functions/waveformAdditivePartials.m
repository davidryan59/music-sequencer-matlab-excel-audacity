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
## Created: 2017-04-27

function [retval] = waveformAdditivePartials (timeVector, partialsMx)

% Going to construct a sum of sine waves based on rows in partialsMx
% partialsMx is a set of rows of format [relativeFreq relativeAmp]
% Normally the first row would be [1, 1] for fundamental frequency at amplitude 1

% Assume timeVector is Nx1, it is straightened out below with (:)
% Assume partialsMx is Mx2

pi2 = 2.*pi;
row1 = size(partialsMx,1);
col1 = size(partialsMx,2);
timeVect = timeVector(:);

if length(timeVect)<1
  
  % Time vector invalid
  % Return zero output.
  retval = 0;
  
elseif (row1<1)||(col1<2)||(row1>1000)
  
  % Partials matrix invalid.
  % Return a suitable sine wave
  retval = sin(pi2.*timeVect);
  
else
  
  % Input valid. Return a sum of sine waves, according to the partials matrix
  relFreqVect = partialsMx(:,1);        % Mx1
  relAmpVect = partialsMx(:,2);         % Mx1
  
%  % DEBUG
%  display([relFreqVect relAmpVect]);
  
  % SPECIAL ROW: [0, N] means 'use voice N' for: N=1 sawtooth, N=2 square, other N for sine
  relFreqIndex = (relFreqVect!=0);
  voiceIndex = (relFreqVect==0);
  
  voiceTypeVect = relAmpVect(voiceIndex);
  if length(voiceTypeVect)
    % User has specified a voice for partials - use only the last voice specified in amp column
    voiceType = voiceTypeVect(end);
  else
    % Use default voice (sine wave)
    voiceType = 0;
  endif
  
  % Restrict rows to non-zero frequencies
  relFreqVect = relFreqVect(relFreqIndex);
  relAmpVect = relAmpVect(relFreqIndex);
  
%  % DEBUG
%  display([relFreqVect relAmpVect]);
  
  if !length(relFreqIndex)
    % Insert a trivial set of partials and continue
    relFreqVect = 1;
    relAmpVect = 1;
  endif
  
%  % DEBUG
%  display([relFreqVect relAmpVect]);
  
  if voiceType==1
    % Use sawtooth
    retval = waveformSawtooth(timeVect*relFreqVect')*relAmpVect;    
  elseif voiceType==2
    % Use square
    retval =  waveformSquare(timeVect*relFreqVect')*relAmpVect;    
  elseif voiceType==3
    % Use triangle
    retval =  waveformTriangle(timeVect*relFreqVect')*relAmpVect;    
  elseif voiceType==4
    % Use trapezium
    retval =  waveformTrapezium(timeVect*relFreqVect')*relAmpVect;    
  elseif voiceType==5
    % Use square5
    retval =  waveform5Square(timeVect*relFreqVect')*relAmpVect;    
  else
    % Use sine
    
    %% Long version
    %timeMx = timeVect*relFreqVect';      % Nx1 * 1xM = NxM   
    %waveMx = sin(pi2.*timeMx);           % NxM
    %retval = waveMx*relAmpVect;          % NxM * Mx1 = Nx1
    
    % Short version
    retval = sin(timeVect*(pi2.*relFreqVect)')*relAmpVect;
    
  endif

endif

endfunction
