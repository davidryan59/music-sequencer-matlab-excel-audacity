## Author: David Ryan
## Created: 2018-05-28

function [retval] = processChannel(waveV, ampV, padVStart, padVEnd, sampleRate, filterMx)
  
  %
  zerosStart = length(padVStart);
  zerosEnd = length(padVEnd);
  
  % Apply amplitudes and padding to waveform
  retval = [padVStart;ampV.*waveV;padVEnd];
  
  % Do the filter
  retval = filterFromSetpoints(retval,sampleRate,filterMx);
  
  % Fade to zero in padding sections
  % by -80 dB (for 16 bit audio max needed is 96dB)
  retval = fadeStartAndEnd(retval,zerosStart,zerosEnd,-80);  % -80dB
  
  % Restrict amplitude to +/-1
  %% OLD VERSION - Amplitude changes...
  %retval = waveformNormalise(retval);
  % NEW VERSION - Hard Clip at 1 (24 May 2018)
  retval = max(-1, min(1, retval));
  
endfunction
