%% Face Morphing

% This code generate a sequence of images morphing between each other
% Here are the steps
	% 1. SHINE images: control for low level features, such as luminosity
	% 2. Create a sequence, changing emotion and identity at specific frequenciees
	% 3. Add watermark to images: add point when image change
	% 4. Return a video of the sequence

%% Define constants

% clear
% clearvars
% Directory containing images to shine
pathFrom = '~/Datasets/MasterThesis/Faces/Original';

% Directory in which to save shined images
% pathTo = '~/.local/share/gdrive/MA_Gianluca/Data/faceemo/shined';
pathTo = '~/Datasets/MasterThesis/Faces/Shined';
mkdir(pathTo);

% Path to Shine toolbox on local computer
pathShine = '~/Projects/Matlab/shine';

% Path where to save sequences
% pathSeqs = '~/.local/share/gdrive/MA_Gianluca/Data/sequences';
pathSeqs = '~/Datasets/MasterThesis/Faces/Sequences';
% pathSeqs = '~/sequences';


% Exclude target
mult10 = [80 150 200];

% Determine wether to Shine or not
toShine = false;

%% Shine

% Before shining, I need to threhsold the whiteness of teeth
% Try: if > threshold -> decrease of: (x - avgImg)



% Shine images is toShine is true
if toShine
	shineImages(pathFrom, pathTo, pathShine);
end


%% Get Dimensions

% Get ids and emos
[ids, emos, chosenId, chosenEmo] = getDims(pathTo);

% Filter Ids to
% to remove
% 4
% 10
% 12
% 13
% 16

ids = [{'f1'},{'f3'},{'f5'},{'f6'},{'f7'},{'f9'},{'f14'},{'f15'},{'f17'}, ...
       {'f18'},{'f19'},{'f20'}];

chosenId = 'f7';
chosenEmo = '06';


% Emotional codes
% 00 - neutral
% 01 - angry
% 02 - disgust
% 03 - fear
% 06 - happiness
% 07 - surprise
emos = [{'01'},{'02'},{'03'},{'07'}];

%% Create Sequence

seqTypes = {'21', '22', '23'};
% chosenDims = {'id', 'emo'};
% Loop over emo and id

% Create the basic sequence
sequence = getSequence(pathTo, ids, emos);
% Get random code
% randCode = num2str(randi(10000));
randCode = num2str(length(dir(pathSeqs)));




for iType=1:length(seqTypes)
	seqType = seqTypes{iType};

% 11-21 - ID VALID
	if strcmp(seqType, '21')
		randIdx = randi([60 260]);
    while true
        if mod(randIdx,40) == 0 && ~ismember(randIdx,mult10)
            break
        else
            randIdx = randi([60 260]);
        end
    end

		sequence = getSequence(pathTo, ids, emos);
		sequence{1,randIdx} = chosenId;

		% Create path sequence
		pathSeq = [pathSeqs '/' randCode '-11' '_21-' num2str(randIdx)];

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);

    
% 11-22 - ID INVALID
	elseif strcmp(seqType, '22')
		randIdx = randi([60 260]);
    while true
        if mod(randIdx,30) == 0 && ~ismember(randIdx,mult10)
            break
        else
            randIdx = randi([60 260]);
        end
    end

		sequence = getSequence(pathTo, ids, emos);
		sequence{2,randIdx} = chosenEmo;

		% Create path sequence
		pathSeq = [pathSeqs '/' randCode '-11' '_22-' num2str(randIdx)];

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);

% 11-23 - ID NEUTRAL
	elseif strcmp(seqType, '23')
		randIdx = randi([60 260]);
    while true
        if mod(randIdx,40) == 0 && ~ismember(randIdx,mult10)
            break
        else
            randIdx = randi([60 260]);
        end
    end
    
		sequence = getSequence(pathTo, ids, emos);
		sequence{1,randIdx} = chosenId;

		% Create path sequence
		pathSeq = [pathSeqs '/' randCode '-11' '_23-' num2str(randIdx)];

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);
	end
end


% 10 - EMO

for iType=1:length(seqTypes)
	seqType = seqTypes{iType};

% 10-21 - EMO VALID
	if strcmp(seqType, '21')
		randIdx = randi([60 260]);
    while true
        if mod(randIdx,30) == 0 && ~ismember(randIdx,mult10)
            break
        else
            randIdx = randi([60 260]);
        end
    end

		sequence = getSequence(pathTo, ids, emos);
		sequence{2,randIdx} = chosenEmo;

		% Create path sequence
		pathSeq = [pathSeqs '/' randCode '-10' '_21-' num2str(randIdx)];

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);

% 10-22 - EMO INVALID
	elseif strcmp(seqType, '22')
		randIdx = randi([60 260]);
    while true
        if mod(randIdx,40) == 0 && ~ismember(randIdx,mult10)
            break
        else
            randIdx = randi([60 260]);
        end
    end

		sequence = getSequence(pathTo, ids, emos);
		sequence{1,randIdx} = chosenId;

		% Create path sequence
		pathSeq = [pathSeqs '/' randCode '-10' '_22-' num2str(randIdx)];

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);

    % 10-23 - EMO NEUTRAL
	elseif strcmp(seqType, '23')
		randIdx = randi([60 260]);
    while true
        if mod(randIdx,30) == 0 && ~ismember(randIdx,mult10)
            break
        else
            randIdx = randi([60 260]);
        end
    end

		sequence = getSequence(pathTo, ids, emos);
		sequence{2,randIdx} = chosenEmo;
    
		% Create path sequence
		pathSeq = [pathSeqs '/' randCode '-10' '_23-' num2str(randIdx)]

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);
	end
end
