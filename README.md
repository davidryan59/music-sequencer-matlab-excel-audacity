# Sequencer in MATLAB / Octave
* Inputs in Excel / CSV
* Outputs in .wav format

## Need these GitHub repos
- Sequencer: https://github.com/davidryan59/music-sequencer-matlab-excel-audacity
- Shared functions: https://github.com/davidryan59/matlab-octave-shared-functions

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
(Updated Nov 2018)

* Make the following directory structure first:
- octave (or matlab! But octave is free...)
  - 01-code
    - shared (2)
      - audio
      - general
    - projects
      - sequencers
        - seq-12-code (1)
  - 02-input
    - projects
      - sequencers
        - seq-12-input (3)
  - 03-temp-output
    - projects
      - sequencers
        - seq-12-output (4)

Then:
(1) Sync GitHub sequencer repo to dir *octave/01-code/projects/sequencers/seq-12-code*
(2) Sync GitHub shared functions repo to dir *octave/01-code/shared*
(3) Start writing Excel/CSV sequence files in the input dir. Run the sequencer on them (use run_seq12 file to specify inputs)
(4) Receive .wav output files in the output dir, and mix them using a suitable post-processing tool (Audacity is an excellent choice, and it is free.)

## Result
I made many music files with this sequencer (or prev versions v10, v11).

You can listen to my tracks at: https://soundcloud.com/davidryan59/tracks

Also see the notation paper at: https://arxiv.org/abs/1612.01860

Dr. David Ryan, April 2018
