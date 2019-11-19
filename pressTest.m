clear
clearvars
pathSeqs ='~/Datasets/MasterThesis/Faces/Sequences';


notMeg = true;

% Display trial

white = [255 255 255];
black = [0 0 0];
gray = white / 2;
screenNumber = max(Screen('Screens'));
screenSize = get(screenNumber, 'ScreenSize');
winX = screenSize(3)/2;
winY = screenSize(4)/2;
k = 1;
crossSize = winX / 100;
winCenter = [winX/2 winY/2];

Screen('Preference', 'SkipSyncTests',2)
win = Screen('OpenWindow', screenNumber, gray, [0 0 winX winY]);
seq = cell(320,1);

trials = cell(1,3);
trials(1,1) = {'10'};
trials(1,2) = {'21'};
trials(1,3) = {[pathSeqs '/2-10_21-240']};
i = 1

	% Load image
	for iimg=1:320
        img = imread([trials{i,3} '/' num2str(iimg) '.png']);
    if notMeg
        img = img(11:end,:);
    end
		seq{iimg} = img;
	end


	Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
	Screen('Flip',win);
	intervalCross = 1;
	intervalCross = intervalCross + randi([0 100])/1000;
	% intervalCross = intervalCross + randi([0 100])/1000;

	WaitSecs(intervalCross);

	Screen('TextSize',win,40);
	% Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
	typeStim = '';
	if strcmp(trials{i,1},'10')
		typeStim = 'E';
	elseif strcmp(trials{i,1},'11')
		typeStim = 'I';
	end

	DrawFormattedText(win, typeStim,'center','center');
	Screen('Flip',win);
	intervalType = .5;
	intervalType = intervalType + randi([0 100])/1000;


	WaitSecs(intervalType);

	for iimg=1:320
		% img = imread([trials{i,3} '/' num2str(iimg) '.png']);
		% TODO: Occlude watermarks if behavior
		% TODO: Write in a new colum trials reaction time of press button. tic present - press button
		% TODO: At the end of each block, average reaction time. NaN if there is no press
		% TODO: If press without target -> fill 9999

		imageTexture = Screen('MakeTexture', win, seq{iimg});
		Screen('DrawTexture', win, imageTexture, [], [], 0);
		Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
		Screen('Flip',win);
        
        if iimg == 80
            tic
            
            if KbCheck
                rTime = toc;
            end
        end
	end

	Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
	Screen('Flip',win);

	intervalCross = .5;
	intervalCross = intervalCross + randi([0 100])/1000;
 
	WaitSecs(intervalCross);

sca
