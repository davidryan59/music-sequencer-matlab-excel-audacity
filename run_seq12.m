% NAVIGATE TO 'program' DIRECTORY BEFORE RUNNING!% Use this script to run the main Just Intonation sequencer% which is 'sequencer12' (as of Oct 2017)
% This script stores all the relevant settings% allowing the input CSV to be edited% and the WAV files obtained with minimum effort.% Setup workspace
clear;clc;% *** USER INPUT REQUIRED ***% Select input/output file%inputFilenameStub = 'testSequenceFile';%inputFilenameStub = 'sonata';inputFilenameStub = 'waltz';% Use this to tag different versions of the same file% Leave blank to not include a tagfileTag = '';% Specify needed directories and add them to the load pathdataDir = '../../../data/seq_12';inputDir = [dataDir '/input'];
outputDir = [dataDir '/output'];sharedDir = '../../shared';fnsAudioDir = [sharedDir '/audio'];fnsGeneralDir = [sharedDir '/general'];addpath(inputDir);addpath(outputDir);addpath(fnsAudioDir);addpath(fnsGeneralDir);% Setup a struct to input the options to the sequencer
options = struct;options.inputFilenameStub = inputFilenameStub;options.fileTag = fileTag;options.inputDir = inputDir;options.outputDir = outputDir;%options. = ;% Run the sequencer
sequencerResult = sequencer12(options);% Give suitable output to the user% (Files will also have been created upon success)display(sequencerResult);