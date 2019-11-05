
%% Load Variables
clear
clearvars
pathSeqs = '~/.local/share/gdrive/MA_Gianluca/Data/sequences';
numTrials = 100;

%% Create Matrix

trials = createMatrix(pathSeqs, numTrials);

%% Start Psychtoolbox

% Display trial

white = [255 255 255];
black = [0 0 0];
gray = white / 2;
screenNumber = max(Screen('Screens'));
screenSize = get(screenNumber, 'ScreenSize');
winX = screenSize(3);
winY = screenSize(4);
k = 1;
crossSize = winX / 100;
winCenter = [winX/2 winY/2];

Screen('Preference', 'SkipSyncTests',2)
win = Screen('OpenWindow', screenNumber, gray, [0 0 winX winY]);

for i=1:length(trials)

	Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
	Screen('Flip',win);
	intervalCross = 1;
	intervalCross = intervalCross + randi([0 100])/1000;
	% intervalCross = intervalCross + randi([0 100])/1000;

	WaitSecs(intervalCross);

	Screen('TextSize',win,40);
	% Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
	typeStim = ''
	if strcmp(trials{i,1},'10')
		typeStim = 'I'
	elseif strcmp(trials{i,1},'11')
		typeStim = 'E'
	end

	DrawFormattedText(win, typeStim,'center','center');
	Screen('Flip',win);
	intervalType = .5;
	intervalType = intervalType + randi([0 100])/1000;


	WaitSecs(intervalType);

	for iimg=1:320
		img = imread([trials{i,3} '/' num2str(iimg) '.png']);

		imageTexture = Screen('MakeTexture', win, img);
		Screen('DrawTexture', win, imageTexture, [], [], 0);
		Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
		Screen('Flip',win);
	end

	Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
	Screen('Flip',win);

	intervalCross = .5;
	intervalCross = intervalType + randi([0 100])/1000;

	WaitSecs(intervalCross);
end



sca

