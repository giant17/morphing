function [ids, emos,chosenId,chosenEmo] = getDims(pathImg)
	% Get the id and emotion from each image file name
	% f<ID>_<EMO>_039.bmp
	% INPUT: path of images

	chosenIdIdx = 12;
	chosenEmoIdx = 7;
	ims = dir(pathImg);
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

	% Get random chosen emo/id

	chosenId = ids{chosenIdIdx};
	chosenEmo = emos{chosenEmoIdx};

	% Remove chosen ones
	emos(chosenEmoIdx) = [];
	ids(chosenIdIdx) = [];
end
