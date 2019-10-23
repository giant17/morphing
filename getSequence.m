function [images] = getSequence(path)

shinePath = [path '/shine'];
ids = dir(shinePath);
ids = {ids(3:end).name};


% TODO: Number of emotions

imgPath = [shinePath '/' ids{1}];
imgs = dir(imgPath);
imgs = {imgs(3:end).name};


emotions = {};
for iimg=1:length(imgs)
	img = imgs{iimg};
	imgEmo = img(4:5);
	if ~ismember(imgEmo, emotions)
		emotions{end+1} = imgEmo;
	end
end


% 20 frames for sequence
% total of 600 frames
% imgFrames = 20;
% seqFrames = 600;

% seqImgs = seqFrames / imgFrames;
% seqImgs = 28; %TODO: Manage reps multiple common

% seqIds = Shuffle(repmat(ids,1,(seqImgs / length(ids))));
% seqEmo = Shuffle(repmat(emotions,1,(seqImgs / length(emotions))));

seqIds = Shuffle(repmat(ids,1,2));
seqEmo = Shuffle(repmat(emotions,1,2));

images = {};

%% TODO: Morph images

for iid=1:length(seqIds)
	imgPath = [shinePath '/' seqIds{iid} '/'];
	imgs = dir(imgPath);
	imgs = {imgs(3:end).name};
	for iemo=1:length(seqEmo)
		expression = ['f[0-9]_' seqEmo{iemo} '_039.bmp']; % Assume frontal
		ims = regexp(imgs, expression, 'match');
		for iim=1:length(ims)
			if ~isempty(ims{iim})
				images{end+1} = [imgPath '/' ims{iim}{1}];


				% TODO: Apply here the RISE
				% TODO: Count double loop for 30 scheme

			end
		end


	end
end

end
