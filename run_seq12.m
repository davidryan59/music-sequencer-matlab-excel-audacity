% Use this script to run the main Just Intonation sequencer
% which is 'sequencer12' (as of Oct 2017)
% This script stores all the relevant settings
% allowing the input CSV to be edited% and the WAV files obtained with minimum effort.
% Setup workspace
clear;
clc;
pathsetup;
% Doesnt matter if this is called multiple times?

% Specify input/output directories and input file
inputDir = '../sequencer12/input/';
outputDir = '../sequencer12/output/';

% Select input/output file
%inputFilenameStub = 'testPrevFile';
%inputFilenameStub = 'bluesSeventh2';
inputFilenameStub = 'testSequenceFile';

% Use this to tag different versions of the same file
% Leave blank to not include a tag
fileTag = 'testFileTag';

% Run the sequencer
sequencerResult = sequencer12(inputFilenameStub, inputDir, outputDir, fileTag);
display(sequencerResult);
