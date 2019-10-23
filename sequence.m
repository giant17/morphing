
p = '~/Data/faceemo';
ims = dir(p);
ims = {ims(3:end).name};

ids = {};
emos = {};

for iimg=1:length(ims)
    a = regexp(ims{iimg}, '_', 'split');

    if ~ismember(a{1}, ids)
        ids{end+1} = a{1};
    end
    if ~ismember(a{2}, emos)
        emos{end+1} = a{2};
    end
end

frames = 1080;
seq = cell(5,frames);
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

	% Add image
	imgName = [p '/' id '_' emo '_039.bmp'];
	seq{3,iseq} = imgName;
end


seq{1,120}
seq{2,120}

seq{1,119}
seq{2,119}
% Create morphs

i=1;
images=[];
img = imread(seq{3,i});
size(morph)
while size(img,3) < frames
	if i > frames
		break
	end
	disp(num2str(i))
	if ~(mod(i,30)) | ~(mod(i,40))

		% get morph
		imgNew = imread(seq{3,i});
		morph = minPhaseInterp(img, imgNew, linspace(0.3,.7,9));
		images = cat(3,images,morph);
		i = i+9;
		img = imgNew;
	end

	images = cat(3,images,img);
	i = i+1;
end

% Remove last images
images = images(:,:,1:end-9);

%% display

% size(images)

% images = reshape(images, [size(images,1) size(images,2) 1 size(images,3)]);

% videoName = '~/seq.avi';
% video = VideoWriter(videoName);
% open(video)
% videoSeq = immovie(images, gray);
% writeVideo(video,videoSeq)
% close(video)

white = [255 255 255];
black = [0 0 0];
gray = white / 2;
screenNumber = max(Screen('Screens'));
screenSize = get(screenNumber, 'ScreenSize');
winX = screenSize(3);
winY = screenSize(4);
k = 1;
win = Screen('OpenWindow', screenNumber, gray, [0 0 winX winY]);

for iimg=1:size(images,3)
	imageTexture = Screen('MakeTexture', win, images(:,:,iimg));
	Screen('DrawTexture', win, imageTexture, [], [], 0);

	if seq{4,iimg}
		color1=black;
	elseif ~seq{4,iimg}
		color1=white;
	end

	if seq{5,iimg}
		color2=black;
	elseif ~seq{5,iimg}
		color2=white;
	end

	x1 = CenterRectOnPointd([0 0 10 10], winX/2-5, (winY-390)/2);
	Screen('FillRect', win, color1, x1);

	x2 = CenterRectOnPointd([0 0 10 10], winX/2+5, (winY-390)/2);
	Screen('FillRect', win, color2, x2);

	% if seq{4,iimg}
	% 	color=black;
	% 	x = CenterRectOnPointd([0 0 10 10], winX/2+10, (winY-390)/2);
	% 	Screen('FillRect', win, color, x);
	% elseif seq{5,iimg}
	% 	color=black;
	% 	x = CenterRectOnPointd([0 0 10 10], winX/2-10, (winY-390)/2);
	% 	Screen('FillRect', win, color, x);
	% end


	% img = Screen('GetImage',win);
	% imgName = ['~/image' num2str(iimg) '.png'];
	% imwrite(img, imgName);



	Screen('Flip',win);
end
KbCheck;
sca;
