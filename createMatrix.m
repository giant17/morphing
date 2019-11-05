function [trials] = createMatrix(pathSeqs, numTrials)

	% Initialize
	trials = cell(numTrials,3);

	% Row 1 - ID/EMO (10/11)
	trials(1:50,1) = {'10'};
	trials(51:100,1) = {'11'};

	% Row 2 - Validity (21/22/23)
	trials(1:35,2) = {'21'};
	trials(36:43,2) = {'22'};
	trials(44:50,2) = {'23'};

	trials(51:85,2) = {'21'};
	trials(86:93,2) = {'22'};
	trials(94:100,2) = {'23'};

	% Row 3 - Path Sequence

	trials(:,3) = {''};

	for i=1:numTrials
		x = dir([pathSeqs '/*-' trials{i,1} '_' trials{i,2} '*']);
		x = {x.name};
		seqs = {};
		for iseq=1:length(x)
			seqs{end+1} = [pathSeqs '/' x{iseq}];
		end

		chosenSeq = seqs{randi(length(seqs))};


		while true
			% TODO: Change ismember
			if ismember(chosenSeq, trials(:,3))
				chosenSeq = seqs{randi(length(seqs))};
			else
				break
			end
		end

		trials(i,3) = {chosenSeq};
	end

	% Shuffle trials
	trials = Shuffle(trials);
end
