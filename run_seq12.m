

% This script is a 5-character shortcut which stores all the relevant settings



clear;


% Doesnt matter if this is called multiple times?


inputDir = 'sequencer11/input/';
outputDir = 'sequencer11/output/';


%inputFilenameStub = 'testPrevFile';
%inputFilenameStub = 'bluesSeventh2';


% Use this to tag different versions of the same file



% Run the sequencer
sequencerResult = sequencer12(inputFilenameStub,inputDir,outputDir,fileTag);
