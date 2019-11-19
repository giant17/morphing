% function [] = init(isMeg,subject,numBlock)

times = [];
addpath(genpath('/usr/share/matlab/site/m'))
%%pathSeqs ='~/.local/share/gdrive/MA_Gianluca/Data/faceemo/sequences';

numTrials = 100;
isMeg = false;

if ispc
    pathSeqs = ''
else
 pathSeqs = '~/Datasets/MasterThesis/Faces/Sequences';
end
 
%% Create Matrix

trials = createMatrix(pathSeqs, numTrials);

%% Start Psychtoolbox

% Display trial

white = [255 255 255];
black = [0 0 0];
gray = white / 2;
% screenNumber = max(Screen('Screens'));
screenNumber = 0;
screenSize = get(screenNumber, 'ScreenSize');
winX = screenSize(3);
winY = screenSize(4);
k = 1;
crossSize = 12;
winCenter = [winX/2 winY/2];

win = Screen('OpenWindow', screenNumber, gray, [0 0 winX winY]);
HideCursor;
seq = cell(320,1);

% for i=1:length(trials)
% for i=1:length(trials)
numTrials = 10;
for i=1:numTrials

	% Load image
	for iimg=1:320
        img = imread([trials{i,3} '/' num2str(iimg) '.png']);
    if ~isMeg
        img = img(11:end,:);
        img = imresize(img,[250 250]);
    end
		seq{iimg} = img;
	end

	Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 1, black, winCenter);
	Screen('Flip',win);
	intervalCross = 1;
	intervalCross = intervalCross + randi([0 100])/1000;
	% intervalCross = intervalCross + randi([0 100])/1000;

	WaitSecs(intervalCross);

	% Screen('TextSize',win,40);
	% Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 2, black, winCenter);
	% typeStim = '';
	% if strcmp(trials{i,1},'10')
	% 	typeStim = 'E';
	% elseif strcmp(trials{i,1},'11')
	% 	typeStim = 'I';
  % elseif strcmp(trials{i,2},'23')
  %   typeSti
	% end

  if ~strcmp(trials{i,2},'23')
      if strcmp(trials{i,1},'10')
          typeStim = 'E';
      elseif strcmp(trials{i,1},'11')
          typeStim = 'I';
      end
      
      DrawFormattedText(win, typeStim,'center','center');
      Screen('Flip',win);
  end
      
	intervalType = .5;
	intervalType = intervalType + randi([0 100])/1000;
	WaitSecs(intervalType);
 
  % Timer begins
  KbQueueCreate;
  KbQueueStart;
  tic;
  starttime = GetSecs;

  for iimg=1:320
      % img = imread([trials{i,3} '/' num2str(iimg) '.png']);
      % TODO: Write in a new colum trials reaction time of press button. tic present - press button
      % TODO: At the end of each block, average reaction time. NaN if there is no press
      % TODO: If press without target -> fill 9999
      imageTexture = Screen('MakeTexture', win, seq{iimg});
      Screen('DrawTexture', win, imageTexture, [], [], 0);
      DrawFormattedText(win, typeStim,'center','center');
      x = GetSecs;
      Screen('Flip',win);
      y = GetSecs;
      times = [times (y-x)];
      
      % target image
      if iimg == str2num(trials{i,4})
          targetTime = toc;
          % disp(['The target is appeared at: ' num2str(targetTime)])
      end
  end
  
  KbQueueStop;
  [pressed, firstPress] = KbQueueCheck;
  KbQueueRelease;

  if pressed
      if strcmp(trials{i,4}, 'NONE')
          trials{i,5} = '888';
      else
          firstPress(find(firstPress==0))=NaN;
          [endtime Index]=min(firstPress);
          % firstPress = firstPress(firstPress > 0);
          % firstPress = firstPress(1);
          timePress = endtime - starttime;
          deltaPress = timePress - targetTime;
          
          trials{i,5} = num2str(deltaPress);
      end
      
  end
  
  
  disp(trials{i,5}) 
  
  % reactionTime = num2str(pressTime - targetTime);
  % trials(:,5) = {reactionTime};
  % DrawFormattedText(win, reactionTime,'center','center');
	% Screen('Flip',win);
	% intervalCross = .5;
	% intervalCross = intervalCross + randi([0 100])/1000;
	% WaitSecs(intervalCross);

	Screen('DrawLines', win, [-crossSize crossSize 0 0; 0 0 -crossSize crossSize], 1, black, winCenter);
	Screen('Flip',win);

	intervalCross = .5;
	intervalCross = intervalCross + randi([0 100])/1000;

	WaitSecs(intervalCross);
end
  
  rTimes = cellfun(@str2double,trials(1:numTrials,5))
  averageReaction = mean(rTimes)

  a = ones(2,1);
  for irTime=1:numTrials
      if str2double(trials{irTime,5}) > 1 || str2double(trials{irTime,5}) < 0
          a(irTime) = 0
      end
  end
  
  acc = mean(a);
  textAccuracy = ['The accuracy is: ' num2str(acc)];
  % textAverage = ['The Average reaction time is: ' averageReaction];
  DrawFormattedText(win, textAccuracy,'center','center');
	Screen('Flip',win);
  WaitSecs(3)
sca




