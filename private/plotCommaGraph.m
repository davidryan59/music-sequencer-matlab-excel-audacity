## Author: David Ryan
## Created: 2018-05-29

function [retval] = plotCommaGraph(commaFreqVect, smoothCommaVect, commaFreqUnNormV, sampleRate)
  
  display ('potatoes');
  
  lenV = length(commaFreqVect);
  sampleTime = 1/sampleRate; 
  timeVect = sampleTime * ((1:lenV)');
  plot(timeVect,1200.*log(commaFreqVect)./log(2),'b',timeVect,1200*log(smoothCommaVect)./log(2),'g',timeVect,1200.*log(commaFreqUnNormV)./log(2),'r');
  
  retval = 0;
  
endfunction
