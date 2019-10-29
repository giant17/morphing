%% Face Morphing

% This code generate a sequence of images morphing between each other
% Here are the steps
	% 1. SHINE images: control for low level features, such as luminosity
	% 2. Create a sequence, changing emotion and identity at specific frequenciees
	% 3. Add watermark to images: add point when image change
	% 4. Return a video of the sequence

%% Define constants

% Directory containing images to shine
pathFrom = '~/.local/share/gdrive/Code/MA_Gianluca/Data/faceeemo/original';

% Directory in which to save shined images
pathTo = '~/.local/share/gdrive/MA_Gianluca/Data/faceemo/shined';

% Path to Shine toolbox on local computer
pathShine = '~/.local/share/toolbox/shine';

% Path where to save sequences
pathSeqs = '~/.local/share/gdrive/MA_Gianluca/Data/sequences';

% Determine wether to Shine or not
toShine = false;

%% Shine

% Shine images is toShine is true
if toShine
	shineImages(pathFrom, pathTo, pathShine);
end




% Get ids and emos
[ids emos chosenId chosenEmo] = getDims(pathTo);


seqTypes = {'valid', 'invalid', 'neutral'};
% chosenDims = {'id', 'emo'};
% Loop over emo and id


% Create the basic sequence
sequence = getSequence(pathTo, ids, emos);


% ID - Loop over types
for iType=1:length(seqTypes)
	seqType = seqTypes{iType}

	if strcmp(seqType, 'valid')
		randIdx = randi([60 260]);
		while mod(randIdx,40)
			randIdx = randi([60 260]);
		end

		sequence{1,randIdx} = chosenId;

		% Create path sequence
		pathSeq = [pathSeqs '/' num2str(randi(10000)) '-ID-' chosenId '_valid']

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);


	elseif strcmp(seqType, 'invalid')
		randIdx = randi([60 260]);
		while mod(randIdx,30)
			randIdx = randi([60 260]);
		end

		sequence{2,randIdx} = chosenEmo;

		% Create path sequence
		pathSeq = [pathSeqs '/' num2str(randi(10000)) '-ID-' chosenId '_invalid']

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);

	elseif strcmp(seqType, 'neutral')
		randIdx = 0;

		% Create path sequence
		pathSeq = [pathSeqs '/' num2str(randi(10000)) '-ID-' chosenId '_neutral']

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);
	end
end


% EMO - Loop over types
for iType=1:length(seqTypes)
	seqType = seqTypes{iType}

	if strcmp(seqType, 'valid')
		randIdx = randi([60 260]);
		while mod(randIdx,30)
			randIdx = randi([60 260]);
		end

		sequence{2,randIdx} = chosenEmo;

		% Create path sequence
		pathSeq = [pathSeqs '/' num2str(randi(10000)) '-EMO-' chosenEmo '_valid']

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);


	elseif strcmp(seqType, 'invalid')
		randIdx = randi([60 260]);
		while mod(randIdx,40)
			randIdx = randi([60 260]);
		end

		sequence{1,randIdx} = chosenId;

		% Create path sequence
		pathSeq = [pathSeqs '/' num2str(randi(10000)) '-EMO-' chosenEmo '_invalid']

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);

	elseif strcmp(seqType, 'neutral')
		randIdx = 0;

		% Create path sequence
		pathSeq = [pathSeqs '/' num2str(randi(10000)) '-EMO-' chosenEmo '_neutral']

		% Write images
		writeImages(pathTo, pathSeq, sequence, randIdx);
	end
end








% TODO: Make sequence
% TODO: Import and Morph images
% TODO: Save images

%% Create sequence





% TODO: Morphing always, more linspace size if more difference between 30/40
% TODO: How to convert frequencies in Herx lapptop

% In order to find how many frames for each change: RefreshRate/Frequency
% As an example, if refreshRate is 60 and frequency 1.5, the number of frames between cycle will be:
% 60/1.5 = 40

% TODO: refreshRate = Screen('FrameRate', screenNumber)
% TODO: Morphing from 0 or 30?
% TODO(Morphing range) Morphing from 0 or 30?

% Return list ids/emos










%% STUFF to process

% p = '~/Data/faceemo';
% x = dir(p);
% x = {x(3:end).name};

% ids = {};
% emos = {};

% for iimg=1:length(x)
%     a = regexp(x{iimg}, '_', 'split');

%     if ~ismember(a{1}, ids)
%         ids{end+1} = a{1};
%     end
%     if ~ismember(a{2}, emos)
%         emos{end+1} = a{2};
%     end
% end

% ids
% emos

% % cat for concatenate

% % TODO: if into if for morphing not doubling

% frames = 300;

% i = 1;
% id = ids{randi(length(ids))};



% length(ids)
% emo = emos{randi(length(emos))};
% img = imread([p '/' id '_' emo '_039.bmp']);
% seq = [];
% i = 1;
% while size(seq,3) <= frames

% 	% Only 30 frame
% 	if (mod(i,30) == 0) && (mod(i,40) ~= 0)
% 		disp(['here is the ' num2str(i) ' frame'])

% 		% Change id
% 		disp('Changing id..')
% 		disp('iTrying first id..')
% 		idNew = ids{randi(length(ids))};
% 		id = ids{randi(length(ids))};
% 		while true
% 			if idNew == id
% 				idNew = ids{randi(length(ids))};
% 			else
% 				id = idNew;
% 				break
% 			end
% 		end

% 		% New Image
% 		newImgName = [p '/' id '_' emo '_039.bmp'];
% 		newImage = imread(newImgName);

% 		% Morph
% 		morph = minPhaseInterp(img, newImage, linspace(.3,.7,9));
% 		seq = cat(3,seq,morph);

% 		% Add frames
% 		i = i + 9;

% 		% Old image
% 		img = newImage;

% 	% Only 40 frame
% 	elseif (mod(i,40) == 0) && (mod(i,30) ~= 0)
% 		disp(['here is the ' num2str(i) ' frame'])

% 		% Change emotion
% 		disp('Changing emo..')
% 		emoNew = emos{randi(length(emos))};
% 		while true
% 			if emoNew == emo
% 				emoNew = emos{randi(length(emos))};
% 			else
% 				emo = emoNew;
% 				break
% 			end
% 		end

% 		% New Image
% 		newImgName = [p '/' id '_' emo '_039.bmp'];
% 		newImage = imread(newImgName);

% 		% Morph
% 		morph = minPhaseInterp(img, newImage, linspace(.3,.7,9));
% 		seq = cat(3,seq,morph);

% 		% Add frames
% 		i = i + 9;

% 		% Old image
% 		img = newImage;

% 	% Both
% 	elseif (mod(i,30) == 0) & (mod(i,30) == 0)
% 		disp(['here is the ' num2str(i) ' frame'])

% 		% Change id
% 		disp('Changing id..')
% 		idNew = ids{randi(length(ids))};
% 		while true
% 			if idNew == id
% 				idNew = ids{randi(length(ids))};
% 			else
% 				id = idNew;
% 				break
% 			end
% 		end

% 		% Change emotion
% 		disp('Changing emo..')
% 		emoNew = emos{randi(length(emos))};
% 		while true
% 			if emoNew == emo
% 				emoNew = emos{randi(length(emos))};
% 			else
% 				emo = emoNew;
% 				break
% 			end
% 		end

% 		% New Image
% 		newImgName = [p '/' id '_' emo '_039.bmp'];
% 		newImage = imread(newImgName);

% 		% Morph
% 		morph = minPhaseInterp(img, newImage, linspace(.3,.7,9));
% 		seq = cat(3,seq,morph);

% 		% Add frames
% 		i = i + 9;

% 		% Old image
% 		img = newImage;
% 	end


% 	% Add image
% 	seq = cat(3,seq,img);
% 	i = i + 1;
% end


