function [seq] = getSequence(pathImg, ids, emos)

	% Return a sequence of ids and emotions, changing at 1.5 and 2 Hz


framesNumber = 320;
seq = cell(5,framesNumber);
id = ids{randi(length(ids))};
emo = emos{randi(length(emos))};
idChange = 0;
emoChange = 0;

for iseq=1:length(seq)
	if mod(iseq,40) == 0
		idNew = ids{randi(length(ids))};
		while true
			if strcmp(idNew,id)
				idNew = ids{randi(length(ids))};
			else
				id = idNew;
				idChange = ~idChange;
				break
			end
		end
	end
	if mod(iseq,30) == 0
		emoNew = emos{randi(length(emos))};
		while true
			if strcmp(emoNew,emo)
				emoNew = emos{randi(length(emos))};
			else
				emo = emoNew;
				emoChange = ~emoChange;
				break
			end
		end
	end

	% Add id and emo to sequence
	seq{1,iseq} = id;
	seq{2,iseq} = emo;
	seq{4,iseq} = idChange;
	seq{5,iseq} = emoChange;

end



end





















% function [images] = getSequence(path)

% shinePath = [path '/shine'];
% ids = dir(shinePath);
% ids = {ids(3:end).name};


% % TODO: Number of emotions

% imgPath = [shinePath '/' ids{1}];
% imgs = dir(imgPath);
% imgs = {imgs(3:end).name};


% emotions = {};
% for iimg=1:length(imgs)
% 	img = imgs{iimg};
% 	imgEmo = img(4:5);
% 	if ~ismember(imgEmo, emotions)
% 		emotions{end+1} = imgEmo;
% 	end
% end


% % 20 frames for sequence
% % total of 600 frames
% % imgFrames = 20;
% % seqFrames = 600;

% % seqImgs = seqFrames / imgFrames;
% % seqImgs = 28; %TODO: Manage reps multiple common

% % seqIds = Shuffle(repmat(ids,1,(seqImgs / length(ids))));
% % seqEmo = Shuffle(repmat(emotions,1,(seqImgs / length(emotions))));

% seqIds = Shuffle(repmat(ids,1,2));
% seqEmo = Shuffle(repmat(emotions,1,2));

% images = {};

% %% TODO: Morph images

% for iid=1:length(seqIds)
% 	imgPath = [shinePath '/' seqIds{iid} '/'];
% 	imgs = dir(imgPath);
% 	imgs = {imgs(3:end).name};
% 	for iemo=1:length(seqEmo)
% 		expression = ['f[0-9]_' seqEmo{iemo} '_039.bmp']; % Assume frontal
% 		ims = regexp(imgs, expression, 'match');
% 		for iim=1:length(ims)
% 			if ~isempty(ims{iim})
% 				images{end+1} = [imgPath '/' ims{iim}{1}];


% 				% TODO: Apply here the RISE
% 				% TODO: Count double loop for 30 scheme

% 			end
% 		end


% 	end
% end

% end
