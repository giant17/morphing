
%% Load Variables
pathSeqs = '~/.local/share/gdrive/MA_Gianluca/Data/sequences';

%% Create Matrix

trials = createMatrix(pathSeqs, numTrials);

%% Start Psychtoolbox

white = [255 255 255];
black = [0 0 0];
gray = white / 2;
screenNumber = max(Screen('Screens'));
screenSize = get(screenNumber, 'ScreenSize');
winX = screenSize(3);
winY = screenSize(4);
k = 1;

Screen('Preference', 'SkipSyncTests',2)
win = Screen('OpenWindow', screenNumber, gray, [0 0 winX winY]);

crossSize = winX / 100;
winCenter = [winX/2 winY/2];
Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
Screen('Flip',win);
intervalCross = 1;
intervalCross = intervalType + randi([0 100])/1000;
% intervalCross = intervalCross + randi([0 100])/1000;

WaitSecs(intervalCross);

Screen('TextSize',win,40);
% Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
DrawFormattedText(win, 'E','center','center');
Screen('Flip',win);
intervalType = .5;
intervalType = intervalType + randi([0 100])/1000;


WaitSecs(intervalType);
x = dir(pathSeqs);
x = {x(3:end).name}a

seq = [pathSeqs '/2-11_22-90'];
ii = [];
for i=1:320
	img = imread([seq '/' num2str(i) '.png']);
	ii = cat(3,ii,img);

	imageTexture = Screen('MakeTexture', win, img);
	Screen('DrawTexture', win, imageTexture, [], [], 0);
	Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
	Screen('Flip',win);
end

Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
Screen('Flip',win);

intervalCross = .5;
intervalCross = intervalType + randi([0 100])/1000;

aaitSecs(intervalCross);



