function [] = shineImages(pathFrom, pathTo, pathShine)
	% This function Shine over all images given.
	% IMPORTANT: the path must contain subfolders with each id

	% pathFrom: directory from where to find images
	% pathTo: directory of output
	% pathShine: toolbox path


	% Add tolbox to path
	addpath(pathShine);


	% Create destination path if not exists
	% if ~exist(pathTo, 'folder')
		mkdir(pathTo)
	% end

	% List all sub-folders
	% folders = dir(pathFrom)
	% folders = {folders(3:end).name}

	% Initialize images and names for
	images = {};
	t = 140;
	% t = 255/2;

	% % Loop over ids
	% for ifolder=1:length(folders)
	% 	ims = dir([pathFrom '/' folders{ifolder} '/*039.bmp'])
	% 	ims = {ims.name};

	% 	% Check if id has enough emotions
	% 	if length(ims) == 8
	% 		for iimg=1:8

	% 			% Save image as gray and name
	% 			name = [pathFrom '/' folders{ifolder} '/' ims{iimg}];
	% 			names{end+1} = name;

	% 			img = rgb2gray(imread(name));
	% 			imgDelta = img(img > t) - t;
	% 			img(img > t) = mean(img(img > 29)) + imgDelta;
	% 			images{end+1} = img;


	% 		end
	% 	end
	% end

imageNames = dir(pathFrom);
names = {imageNames(3:end).name};
whiteEmo = {'01', '02', '03', '06', '07'};

for iimg=1:length(names)
	imageName = [pathFrom '/' names{iimg}];
	img = rgb2gray(imread(imageName));
	a = regexp(names{iimg}, '_', 'split');
	% if ismember(a{2}, whiteEmo)
		% img(img > t) = mean(img(img > 29)) + (abs(img(img > t)) - t);
		% tr = mean(img(img > t)) - mean(img(img > 29));
		% img(img > t) = img(img > t) - mean(img(img > 29));

% 		img(img > t) = img(img > t) - tr;

		% halfA = img(1:250,1:end);
		% halfB = img(251:end,1:end);

		% meanAll = mean(img,'all');
		% d = halfB(halfB > t) - t;

		% halfB(halfB > t) = meanAll + d - 10;
		% img = cat(1,halfA,halfB);
		% d = img(img > t) - t;
		% img(img > t) = mean(img(img > 29)) + d;


	% end
	images{end+1} = img;
end


		% Check if id has enough emotions
		% if length(ims) == 8
		% 	for iimg=1:8

				% Save image as gray and name
				% name = [pathFrom '/' folders{ifolder} '/' ims{iimg}];
				% names{end+1} = name;

	% Initialize shined
	shined = cell(1,ceil(length(images)/100));
	k = 1;

	% Shine images in batches of 100
	while true
		if length(images) > 100
			shined{k} = SHINE(images(1:100));
			images(1:100) = [];
			k = k+1;
			disp(repmat('-',1,50))
			disp(['Batch shining complete: ' num2str(k) '/' num2str(ceil(length(images)/100))])
			disp(repmat('-',1,50))
		else
			shined{k} = SHINE(images);
			break
		end
	end


	% Write Images
	k = 1;


	% Loop each shine batch
	for ishine=1:length(shined)
		% Loop each image
		for iimg=1:length(shined{ishine})

			% Get old name of image
			img = shined{ishine}{iimg};
			oldName = regexp(names{k}, '/', 'split');
			rootName = oldName{end};

			% Create destination path for image
			newName = [pathTo '/' oldName{end}];

			% Write image in new path
			imwrite(img, newName);
			disp(['Image write complete:' num2str(k) '/' num2str(length(names))])
			k = k+1;
		end
	end
end
