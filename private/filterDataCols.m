## Author: David Ryan
## Created: 2018-05-30

function [retval] = filterDataCols(dataImport, colMappingMx)
  
  % IMPROVE: If a column is duplicated in dataImport it will give unpredictable results
  % Deduplicate column headers first...
  
  % Specify which columns to retain, in which order
  finalColOrder = colMappingMx(:,1)';
  defaultValues = colMappingMx(:,2)';
  
  % Work out an index vector from the specified column order
  controlRow = dataImport(1,:);
  matchMx = (finalColOrder == controlRow');
  unitVect = 1:length(controlRow);
  orderVect = unitVect * matchMx;
  
  % Remove control row, add a column of zeros, then shift orderVect by 1
  dataImport = dataImport(2:end,:);
  dataRows = size(dataImport, 1);
  dataImport = [zeros(dataRows,1), dataImport];
  orderVect = orderVect + 1;
  
  % Do the transformation of input data here
  dataImport = dataImport(:,orderVect);
  
  % Adjust columns that need to default (to values other than 0)
  defaultValueMx = ones(dataRows,1) * defaultValues;
  colsToDefault = (orderVect==1);
  dataImport(:,colsToDefault) = defaultValueMx(:,colsToDefault);
  
  % Return the transformed data matrix
  retval = dataImport;
  
endfunction
