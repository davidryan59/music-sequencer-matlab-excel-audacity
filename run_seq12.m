## Author: David Ryan
## Created: 2017-04-27

% NAVIGATE TO THIS DIRECTORY BEFORE RUNNING!
% Use this script to run the main Just Intonation sequencer
% which is 'sequencer12' (as of Oct 2017)

% This script stores all the relevant settings
% allowing the input CSV to be edited
% and the WAV files obtained with minimum effort.

% Setup workspace
clear;
clc;

% *** USER INPUT REQUIRED ***
% Select input/output file
%inputFilenameStub = 'prevTestInputFile';
inputFilenameStub = 'testInputFile';

% Use this to tag different versions of the same file
% Leave blank to not include a tag
fileTag = '';
%fileTag = 'lo';
%fileTag = 'mid';
%fileTag = 'hi';

% Specify needed directories
%codeDir = '../../../../01-input/projects/sequencers/seq-12-code';   % This directory!
inputDir = '../../../../02-input/projects/sequencers/seq-12-input';
outputDir = '../../../../03-temp-output/projects/sequencers/seq-12-output';
sharedDir = '../../../shared';
fnsAudioDir = [sharedDir '/audio'];
fnsGeneralDir = [sharedDir '/general'];
fnsPrivateDir = 'private';
colMappingFile = 'private/columnMapping.csv';

% Add them to the load path
addpath(inputDir);
addpath(outputDir);
addpath(fnsAudioDir);
addpath(fnsGeneralDir);
addpath(fnsPrivateDir);

% Setup a struct to input the options to the sequencer
options = struct;
options.inputFilenameStub = inputFilenameStub;
options.fileTag = fileTag;
options.inputDir = inputDir;
options.outputDir = outputDir;
options.colMappingFile = colMappingFile;
%options. = ;

% Run the sequencer
sequencerResult = sequencer12(options);

% Give suitable output to the user
% (Files will also have been created upon success)
display(sequencerResult);

% Finish off
% Remove directories that have been added
rmpath(inputDir);
rmpath(outputDir);
rmpath(fnsAudioDir);
rmpath(fnsGeneralDir);
rmpath(fnsPrivateDir);
