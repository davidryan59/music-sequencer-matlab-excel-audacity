% Use this script to run the main Just Intonation sequencer (April 2017)
% which is 'sequencer11'
% This script is a 5-character shortcut which stores all the relevant settings
% allowing the input CSV to be edited and the WAV files obtained with minimum effort.

% Setup workspace
clear;
clc;
pathsetup;
% Doesnt matter if this is called multiple times?

% Specify input/output directories and input file
inputDir = 'sequencer11/input/';
outputDir = 'sequencer11/output/';

% Select input/output file
%inputFilenameStub = 'testPrevFile';
%inputFilenameStub = 'bluesSeventh2';
inputFilenameStub = 'boogie1';

% Use this to tag different versions of the same file
% Leave blank to not include a tag
fileTag = '';

% Run the sequencer
sequencerResult = sequencer12(inputFilenameStub,inputDir,outputDir,fileTag);
display(sequencerResult);
