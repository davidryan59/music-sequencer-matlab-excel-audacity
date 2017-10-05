% NAVIGATE TO 'program' DIRECTORY BEFORE RUNNING!% Use this script to run the main Just Intonation sequencer
% which is 'sequencer12' (as of Oct 2017)
% This script stores all the relevant settings
% allowing the input CSV to be edited% and the WAV files obtained with minimum effort.
% Setup workspace
clear;
clc;
% Specify directories for input, output, functions% and add them to the load path
inputDir = '../data/input/';
addpath('../data/input');outputDir = '../data/output/';
addpath('../data/output');functionsDir = 'audio_functions/';
addpath('audio_functions');

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
