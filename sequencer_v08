function outputWaveform=sequencer_v08(outputSampleFreq,bitRate,outputCode,beatLength,baseFrequency,inputFilename,outputFilenameAppend)
%Read in a specified MIDI-style csv file and output a sequenced wave file
%
%Version History:
%sequencer_v05_both
%sequencer_v05_rand: randomization of individual notes timings etc introduced.
%sequencer_v05_stringsynth: make use of a synthesizer for a single string
%sequencer_v05_octave: various debugs introduced for MATLAB -> Octave
%(sequencer_v06 was a separate experiment of organising multiple tables for input - never was really used much)
%sequencer_v07: Intended to be a fresh start on sequencer_v05 development, but in Octave, and running much faster.
%sequencer_v08: Renumbering of voices (again) with 2000-2999, 3000-3999 and 5000-5999 various dynamic waveforms.
%
%outputSampleFreq: Sampling frequency (Hz) of the output file, e.g. 8000, 16000, 22050, 32000, 44000, 44100, 48000, 96000, etc.
%bitRate: 8, 16, 24, 32 for output format. 8, 16, 24 in bits, 32 is single precision. This number is checked before output.
%outputCode: 1, 3 for wave; 2, 3 for MP3. (0 will display plot but not create output file.)
%beatLength: Allows whole file to be sped up or slowed down from one parameter. May be in seconds.
%baseFrequency: Allows the whole file to be repitched from one parameter. Depending on the sequenced frequencies supplied, this may be in Hz or just a multiplier
%inputFilename: CSV file for sequencing. Format described below. No file extension.
%outputFilenameAppend: Appended to inputFilename for MP3/WAV output. No file extension. Leave blank ('') to reuse inputFilename.
%
%input file is a csv format file with the following columns:
%1: Voice: controls the waveform of the note (0 is don't play note)
%2: Note Time (beats)
%3: Note Relative Frequency: relative to the base frequency (Hz) (0 for same as original, irrespective of base frequency - e.g. percussion)
%4: Note Relative Length: relative to the beat length (beats). Can be fractional, this is improved from sequencer_v03.
%5: Note Loudness: increase or decrease the note by a number of decibels. 100dB = amplitude N, 80dB is amplitude N/10, etc. Wave files are always normalised before saving.
%6: Note Stereo Location (-1=left ... 0=middle ... 1=right) continuous scale
%
%by David Ryan, UK, 2015 (davidryan1998@hotmail.com)

tic;
inputData=load([inputFilename '.csv']);                    %load outputWaveform data from specified inputFilename format given above.
[numberOfNotes numberOfColumns]=size(inputData);           %#ok<NASGU> %numberOfColumns variable is not currently used


%CLEAN UP INPUT DATA
outputSampleFreq=max(8000,min(96000,outputSampleFreq(1)));
bitRate=max(8,min(32,floor(bitRate(1))));
outputCode=max(0,min(3,floor(outputCode(1))));
beatLength=max(0.0001,min(100,beatLength(1)));
baseFrequency=max(0.0001,min(outputSampleFreq,baseFrequency(1)));

inputData=inputData(:,1:6);              %Only going to use the first 6 columns - throw away anything else 

minTime=min(inputData(:,2));            %Col 2 is note time in beats. Find min time
inputData(:,2)=inputData(:,2)-minTime;  %Subtract min time from Col2 to remove blank time at start of sound file (or shift up negative times)

maxTime=max(inputData(:,2)+inputData(:,4));   %Col 2 is note time, Col 4 is note length. Sum to get note end time.
maxTime=maxTime*beatLength;
maxSample=1+floor(maxTime*outputSampleFreq);

                    
outputWaveform=zeros(maxSample,2);      %Mono ability removed in v07 since it was never used. Stereo waveform output.
loudnessRefDB=30;                       %This loudness dB will have amplitude 1 (barring other adjustments)
minLength=8/outputSampleFreq;                        %Notes less than this number of seconds will not be played
timeStep=1/max(8000,outputSampleFreq);


%Each note ought to have its loudness (dB) adjusted
%according to how high or low it is.
%ISO standards for equal loudness exist - use this data.
%Original data was for pure tones (sine waves)
%Summation used to calculate similar file for compound tones
equalLoudnessTable=load('EqualLoudnessData_CompoundTones_Ref_1000Hz.csv');
equalLoudRefDB=min(equalLoudnessTable(:,2));          %2nd column in table is dB values, use the minimum as a reference value
equalLoudAdj01=1;                                     %1 for adjust tuned notes (freq>0), 0 for do not adjust any notes.
                                                      %Untuned notes (e.g. drum kit) never adjusts.


time1=toc;tic;

%Repeat the whole sequencer N times
reps1=1;                  % N       - IMPROVE: THIS OUGHT TO BE FACTORED OUT INTO A PARAMETER, IF I WANT TO USE IT
                          %           ALSO CONSIDER SMALL RANDOM CHANGES IN LOUDNESS AND TIMING. NOT FREQUENCY :)
for currRep=1:reps1

%Write each individual note to output waveform, by retuning, timeshifting and scaling input waveforms.
for currNote=1:numberOfNotes
    
    %Deal with individual row from sequenced data  
    currVoice=abs(floor(inputData(currNote,1)));               %Must be integer. Voice 0 is "don't play note"
    currStartTime=inputData(currNote,2)*beatLength;            %Time in seconds. Will be zero or positive since timings shifted earlier.
    currFreq=abs(inputData(currNote,3)*baseFrequency);         %Frequency in Hz (abs)
    currLength=abs(inputData(currNote,4)*beatLength);          %Note length in seconds (abs)
    currLoudness=inputData(currNote,5);                        %Loudness in dB relative to reference value, positive or negative. Ref = 100dB for amplitude=1 (Jan 2015)
    currStereoPosition=min(1,max(-1,inputData(currNote,6)));   %Stereo position between -1 (left) and +1 (right)

    if currFreq>0 && equalLoudAdj01==1
        equalLoudAdjustForFreqDB=linearInterpolate(currFreq,equalLoudnessTable)-equalLoudRefDB;
                                     %Tuned note, frequency specified. Use standard curve to calibrate loudness.
    else
        equalLoudAdjustForFreqDB=0;
                                     %Untuned note (e.g. a drum kit) or calibration not required.
    end

    currAmpMult=10^((currLoudness+equalLoudAdjustForFreqDB-loudnessRefDB)/20);
                                     %Loudness is measured in decibels (dB).
                                     %Increasing dB by 20 gives 10x the amplitude. Constant is arbitrary.
            
    if currVoice>0 && currLength>minLength             %if zero voice, don't play. if low length, don't play.

        phaseOffset=rand;                                 % Between 0 and 1
        timeVectorFreq1=(0:timeStep:currLength)';         % Needs to start at zero for correct decays
        timeVectorFreqAdj1=timeVectorFreq1+phaseOffset;   % Phase offset. A column vector of times for a freq=1 wave
        currSamples=length(timeVectorFreq1);

        % digitN decomposition of currVoice
        rem1=currVoice;
        digit1=mod(rem1,10);       % digit1, digit2, ... control various aspects of waveform
        rem2=(rem1-digit1)/10;
        digit2=mod(rem2,10);
        rem3=(rem2-digit2)/10;
        digit3=mod(rem3,10);
        rem4=(rem3-digit3)/10;
        digit4=mod(rem4,10);
        %rem5=(rem4-digit4)/10;
        %digit5=mod(rem5,10);
        %rem6=(rem4-digit4)/10;
        %digit6=mod(rem5,10);

        loudnessDecayDBs=round(((12-digit1)^3-27)/10);         % From digit1=9 to 0: 0, 4, 10, 19, 32, 49, 70, 97, 130, 170 dB/s

        loudnessDecayVector=10.^((-loudnessDecayDBs/20).*timeVectorFreq1);  % -20dB = amplitude * 0.1

        % SOME SIMPLE WAVEFORMS FIRST
        if digit4==0            % Simple Waveforms
      
            if digit3==0        % Simple harmonic waveforms
  
                if digit2==1                                               % sine wave   19...10
                    currMonoWaveform=sin((2*pi*currFreq).*timeVectorFreqAdj1);

                elseif digit2==2                                           % sawtooth    29...20
                    currMonoWaveform=sawtooth(currFreq.*timeVectorFreqAdj1);

                elseif digit2==3                                           % square      39...30
                    currMonoWaveform=square(currFreq.*timeVectorFreqAdj1);

                elseif digit2==4                                           % triangle    49...40
                    currMonoWaveform=triangle(currFreq.*timeVectorFreqAdj1);

                else  %digit2==5  (to 9)                                   % square5     59...50 (or default)
                    currMonoWaveform=square5(currFreq.*timeVectorFreqAdj1);

                endif

            elseif digit3==1    % Noise waveform (noiseTunedRange)    199...100

                centsRange=400+50*(digit2+1)^2;    % Between 450 and 5400 cents
                startFreq=currFreq*2^(-centsRange/(2*1200));
                endFreq=currFreq*2^(centsRange/(2*1200));
                currMonoWaveform=noiseTunedRange(currSamples,startFreq,endFreq,outputSampleFreq);

            else  %digit3==2    % Noise waveform (noiseExpDecay)      299...200 (or default)

                dBOct=round(((digit2+2)^2-1)/5);
                currMonoWaveform=noiseExpDecay(currSamples,currFreq,dBOct,outputSampleFreq);

            endif
    
        % Access thousands of waveforms by digit decomposition and general trapezoid (or interpolated) waveform
        elseif digit4>=2 && digit4<=5 

            param2=10^(-digit2/3);
            param3=10^((6-digit3)/3);
            paramVector=1-1./(1+param2+param3.*timeVectorFreq1);

            if digit4==2
                currMonoWaveform=trapezoid(currFreq.*timeVectorFreqAdj1,1,paramVector,0);     % sawTriOsc [1,p,0]

            elseif digit4==3
                currMonoWaveform=trapezoid(currFreq.*timeVectorFreqAdj1,paramVector,1,1);     % squareTriOsc  [p,1,1]

            else  %digit4==5
                currMonoWaveform=squareTriInterp5(currFreq.*timeVectorFreqAdj1,paramVector);  % squareTriInterp5

            endif

        else        % All other digit4 possibilities here - DEFAULT

            currMonoWaveform=triangle(currFreq.*timeVectorFreqAdj1);    % Triangle wave as default, since its simple.

        endif

        % Full trapezoid somewhere here? Use 5 or 6 digits?

        currMonoWaveform=smoothEdges(currAmpMult*(loudnessDecayVector.*currMonoWaveform),outputSampleFreq);   %Scale and smooth waveform
        
        %DEBUG
        %length(currMonoWaveform)
        %length(timeVectorFreq1)

        currLeftStereoFactor=1-currStereoPosition;      %0 to 2. Mono (in the middle) is 1 each.
        currRightStereoFactor=2-currLeftStereoFactor;   %0 to 2
        currStereoRowMxMult=[currLeftStereoFactor,currRightStereoFactor];     % monoWave*thisFactor is col * row mx, gives Nx2 mx
        

        %need to add waveform to outputWaveform at time currStartTime  
      
        outputSSNoClip=1+floor(currStartTime*outputSampleFreq);      %start sample
        outputSSClip=max(1,min(maxSample,outputSSNoClip));           %tuned sample will be added here    
    
        outputESNoClip=outputSSNoClip+currSamples-1;                 %end sample
        outputESClip=max(1,min(maxSample,outputESNoClip));           %tuned sample will end here   
     
        waveSS=1+(outputSSClip-outputSSNoClip);
        waveES=currSamples-(outputESNoClip-outputESClip);
        
        outputWaveform(outputSSClip:outputESClip,:)=outputWaveform(outputSSClip:outputESClip,:)+currMonoWaveform(waveSS:waveES,1)*currStereoRowMxMult;   
    end
end

end %N repetitions

time2=toc;tic;


outputFilename=[inputFilename,outputFilenameAppend];

%Check bit rate
bitRateChecked=checkBitRate(bitRate);

%Create various output files according to outputCode
outCode4=mod(floor(outputCode),4);
wavIfTrue=mod(outCode4,2);           %outCode4=1, 3 gives a wav file
mp3IfTrue=(outCode4-wavIfTrue)/2;    %outCode4=2, 3 gives an mp3 file
if wavIfTrue
    %Create a WAV file
    wavwrite(waveNormaliseCentre(outputWaveform),outputSampleFreq,bitRateChecked,[outputFilename,'.wav']);
end
if mp3IfTrue %#ok<BDLGI>
    %Create an MP3 file
    if true          %%outputStereoIfTrue - variable removed
        encoding=2;
    else
        encoding=1;
    end
    mp3write(waveNormaliseCentre(outputWaveform),outputSampleFreq,bitRateChecked,[outputFilename,'.mp3'],encoding);
end


time3=toc;tic;


%Make a chart of channel 1 to visually check output. Limit to 100000 samples to keep plot speed fast.
timeIndex=1:min(100000,maxSample);
timeValues=(timeIndex-1)/outputSampleFreq;
plot(transpose(timeValues),outputWaveform(timeIndex,1),'r',transpose(timeValues),outputWaveform(timeIndex,2),'g');
set(gcf,'Name','Plot of Sequenced Waveform','NumberTitle','off');


time4=toc;tic;
disp('');
disp(['Times in seconds for setup, loop, file, graph: ',num2str(time1),', ',num2str(time2),', ',num2str(time3),', ',num2str(time4),'.']);
disp('');


end
