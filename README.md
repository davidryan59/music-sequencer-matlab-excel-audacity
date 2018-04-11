# Sequencer in MATLAB / Octave
* Inputs in Excel / CSV
* Outputs in .wav format

## Need these GitHub repos
- Sequencer: https://github.com/daveryan23/music_sequencer_matlab_excel_audacity
- Shared functions: https://github.com/daveryan23/matlab_octave_shared_functions

## Scope of Project
Created a Music Sequencer using:
- Excel for sequencing the notes, into CSV format
- MATLAB (or Octave, its free!) for turning CSV data
  into a series of .wav audio files, 1 for each channel
- Audacity for mixing the different .wav files together.

## What I did
- The Excel and MATLAB have been developed across approx 2015-2017.
- Although this repo has been updated extensively in Oct 2017, my original example files are retained, in 'original_examples' directory.

## Tools I used
- Excel (sequencing)
- MATLAB (processing)
- Audacity (post-processing)

## To run
- Summary: use run_seq12.m to setup inputs and outputs correctly, and run the sequencer12.m
- Input/output directories also needed
- Excel in the input directory
- Find the outputted .wav files in the output directory

## Required directory structure
* Make the following directory structure first:
- octave (or matlab! But octave is free...)
  - data
    - seq_12
      - input  (3)
      - output (4)
  - src
    - projects
      - seq_12 (1)
    - shared   (2)
      - audio
      - general
Then:
(1) Sync GitHub sequencer repo to dir *src/projects/seq_12*
(2) Sync GitHub shared functions repo to dir *src/shared*
(3) Start writing Excel/CSV sequence files in the input dir
Run the sequencer on them (use run_seq12 file to specify inputs)
(4) Receive .wav output files in the output dir

## Result
I made many music files with this sequencer (or prev versions v10, v11).

You can listen to my tracks at: https://soundcloud.com/daveryan23/tracks

Also see the notation paper at: https://arxiv.org/abs/1612.01860

Dr. David Ryan, April 2018
