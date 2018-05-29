## Author: David Ryan
## Created: 2018-05-29

function [retval] = getFileTags(freqMult, beatsPerMinute, sampleRate, bitRate, fileTag, parameterSet)
  
  freqMultText = '';
  if abs(freqMult-1) > 0.00001
    freqMultText = ['-' num2str(round(freqMult*1000)) 'relfreq'];
  endif
  
  bpmText = '';
  if beatsPerMinute > 10
    bpmText = ['-' num2str(round(beatsPerMinute)) 'bpm'];
  endif
  
  srText = '';
  if sampleRate > 10
    srText = ['-' num2str(round(sampleRate)) 'Hz'];
  endif
  
  bitText = '';
  if bitRate > 7
    bitText = ['-' num2str(round(bitRate)) 'bit'];
  endif
  
  paramSetText = '';
  if parameterSet > 0.5
    paramSetText = ['-SET' num2str(round(parameterSet))];
  endif
  
  retval = [freqMultText bpmText srText bitText fileTag paramSetText];
  
endfunction
