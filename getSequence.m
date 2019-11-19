function [seq] = getSequence(pathImg, ids, emos)

	% Return a sequence of ids and emotions, changing at 1.5 and 2 Hz

% ids = [{'f1'},{'f3'},{'f5'},{'f7'},{'f9'},{'f14'},{'f15'}, ...
%        {'f17'},{'f18'},{'f19'},{'f20'}];

% emos = [{'01'},{'02'},{'03'},{'07'}];

% pathImg = '~/Datasets/MasterThesis/Faces/Shined';

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
