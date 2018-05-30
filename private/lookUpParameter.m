## Author: David Ryan
## Created: 2018-05-29

function [retval] = lookUpParameter(originalValue, lookupNum, paramVect, vectControl)
  
  % DEBUG
  %display(['lookUpParameter running for ' num2str(lookupNum)]);
  
  % The type to find should be a positive integer
  lookupNum = round(lookupNum(1));
  
  % Find the control rows which match this number
  matchingRows = (vectControl==lookupNum);
  
  % Find the highest row number
  lenV = length(paramVect);
  vectUnit = (1:lenV)';
  highestFoundIndex = max(vectUnit.*matchingRows);
  
  if highestFoundIndex > 0
    % Extract new parameter value
    retval = paramVect(highestFoundIndex);
  else
    % Keep the existing parameter value
    retval = originalValue;
  endif
  
endfunction
