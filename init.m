%% Face Morphing

% This code generate a sequence of images morphing between each other
% Here are the steps
	% 1. SHINE images: control for low level features, such as luminosity
	% 2. Create a sequence, changing emotion and identity at specific frequenciees
	% 3. Add watermark to images: add point when image change
	% 4. Return a video of the sequence

%% Define constants

clear
clearvars
% Directory containing images to shine
pathFrom = '~/.local/share/gdrive/MA_Gianluca/Data/faceemo/Facegen_output_ori039';

% Directory in which to save shined images
% pathTo = '~/.local/share/gdrive/MA_Gianluca/Data/faceemo/shined';
pathTo = '~/shined';

% Path to Shine toolbox on local computer
pathShine = '~/repos/forks/shine';

% Path where to save sequences
pathSeqs = '~/.local/share/gdrive/MA_Gianluca/Data/sequences';

% Determine wether to Shine or not
toShine = false;

%% Shine

% Before shining, I need to threhsold the whiteness of teeth
% 1 Try: if > threshold -> decrease of: (x - avgImg)



% Shine images is toShine is true
if toShine
	shineImages(pathFrom, pathTo, pathShine);
end


%% Get Dimensions

% Get ids and emos
[ids emos chosenId chosenEmo] = getDims(pathTo);
emos(5) = [];
emos(5) = [];
emos
%% Create Sequence

seqTypes = {'21', '22', '23'};
% chosenDims = {'id', 'emo'};
% Loop over emo and id

% Create the basic sequence
sequence = getSequence(pathTo, ids, emos);
% Get random code
% randCode = num2str(randi(10000));
randCode = num2str(length(dir(pathSeqs)));

% 11 - Loop over types
for iType=1:length(seqTypes)
	seqType = seqTypes{iType}

	if strcmp(seqType, '21')
		randIdx = randi([60 260]);
		while mod(randIdx,40)
			randIdx = randi([60 260]);
		end

		sequence = getSequence(pathTo, ids, emos);
		sequence{1,randIdx} = chosenId;

		% Create path sequence
		pathSeq = [pathSeqs '/' randCode '-11' '_21-' num2str(randIdx)]

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);

	elseif strcmp(seqType, '22')
		randIdx = randi([60 260]);
		while mod(randIdx,30)
			randIdx = randi([60 260]);
		end

		sequence = getSequence(pathTo, ids, emos);
		sequence{2,randIdx} = chosenEmo;

		% Create path sequence
		pathSeq = [pathSeqs '/' randCode '-11' '_22-' num2str(randIdx)]

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);

	elseif strcmp(seqType, '23')
		randIdx = 0;
		sequence = getSequence(pathTo, ids, emos);

		% Create path sequence
		pathSeq = [pathSeqs '/' randCode '-11' '_23']

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);
	end
end


% 10 - Loop over types
for iType=1:length(seqTypes)
	seqType = seqTypes{iType}

	if strcmp(seqType, '21')
		randIdx = randi([60 260]);
		while mod(randIdx,30)
			randIdx = randi([60 260]);
		end

		sequence = getSequence(pathTo, ids, emos);
		sequence{2,randIdx} = chosenEmo;

		% Create path sequence
		pathSeq = [pathSeqs '/' randCode '-10' '_21-' num2str(randIdx)]

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);


	elseif strcmp(seqType, '22')
		randIdx = randi([60 260]);
		while mod(randIdx,40)
			randIdx = randi([60 260]);
		end

		sequence = getSequence(pathTo, ids, emos);
		sequence{1,randIdx} = chosenId;

		% Create path sequence
		pathSeq = [pathSeqs '/' randCode '-10' '_22-' num2str(randIdx)]

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);

	elseif strcmp(seqType, '23')
		randIdx = 0;
		sequence = getSequence(pathTo, ids, emos);

		% Create path sequence
		pathSeq = [pathSeqs '/' randCode '-10' '_23']

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);
	end
end
