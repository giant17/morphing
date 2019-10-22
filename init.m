% Face Morphing

% TODO: Document stuff

%% Define constants

%TODO: define paths from.tp
%TODO: pathTo =
pathShine = '~/.local/share/toolbox/shine';

%% Shine images

shineImages(pathFrom, pathTo, pathShine);

%% Create sequence

% Return list ids/emos

p = '~/Data/faceemo';
x = dir(p);
x = {x(3:end).name};

ids = {};
emos = {};

for iimg=1:length(x)
    a = regexp(x{iimg}, '_', 'split');

    if ~ismember(a{1}, ids)
        ids{end+1} = a{1};
    end
    if ~ismember(a{2}, emos)
        emos{end+1} = a{2};
    end
end

ids
emos

% cat for concatenate

% TODO: if into if for morphing not doubling

frames = 300;

i = 1;
id = ids{randi(length(ids))};



length(ids)
emo = emos{randi(length(emos))};
img = imread([p '/' id '_' emo '_039.bmp']);
seq = [];
i = 1;
while size(seq,3) <= frames

	% Only 30 frame
	if (mod(i,30) == 0) && (mod(i,40) ~= 0)
		disp(['here is the ' num2str(i) ' frame'])

		% Change id
		disp('Changing id..')
		disp('iTrying first id..')
		idNew = ids{randi(length(ids))};
		id = ids{randi(length(ids))};
		while true
			if idNew == id
				idNew = ids{randi(length(ids))};
			else
				id = idNew;
				break
			end
		end

		% New Image
		newImgName = [p '/' id '_' emo '_039.bmp'];
		newImage = imread(newImgName);

		% Morph
		morph = minPhaseInterp(img, newImage, linspace(.3,.7,9));
		seq = cat(3,seq,morph);

		% Add frames
		i = i + 9;

		% Old image
		img = newImage;

	% Only 40 frame
	elseif (mod(i,40) == 0) && (mod(i,30) ~= 0)
		disp(['here is the ' num2str(i) ' frame'])

		% Change emotion
		disp('Changing emo..')
		emoNew = emos{randi(length(emos))};
		while true
			if emoNew == emo
				emoNew = emos{randi(length(emos))};
			else
				emo = emoNew;
				break
			end
		end

		% New Image
		newImgName = [p '/' id '_' emo '_039.bmp'];
		newImage = imread(newImgName);

		% Morph
		morph = minPhaseInterp(img, newImage, linspace(.3,.7,9));
		seq = cat(3,seq,morph);

		% Add frames
		i = i + 9;

		% Old image
		img = newImage;

	% Both
	elseif (mod(i,30) == 0) & (mod(i,30) == 0)
		disp(['here is the ' num2str(i) ' frame'])

		% Change id
		disp('Changing id..')
		idNew = ids{randi(length(ids))};
		while true
			if idNew == id
				idNew = ids{randi(length(ids))};
			else
				id = idNew;
				break
			end
		end

		% Change emotion
		disp('Changing emo..')
		emoNew = emos{randi(length(emos))};
		while true
			if emoNew == emo
				emoNew = emos{randi(length(emos))};
			else
				emo = emoNew;
				break
			end
		end

		% New Image
		newImgName = [p '/' id '_' emo '_039.bmp'];
		newImage = imread(newImgName);

		% Morph
		morph = minPhaseInterp(img, newImage, linspace(.3,.7,9));
		seq = cat(3,seq,morph);

		% Add frames
		i = i + 9;

		% Old image
		img = newImage;
	end


	% Add image
	seq = cat(3,seq,img);
	i = i + 1;
end



