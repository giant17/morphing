function [] = writeImages(pathImg, pathSeq, sequence, randIdx)


	% imgName = [pathImg '/' id '_' emo '_039.bmp'];
	% seq{3,iseq} = imgName;
	degradation=.95;
	i=1;
	images=[];
	img = imread([pathImg '/' sequence{1,i} '_' sequence{2,i} '_039.bmp']);


	frames = length(sequence);
	while true
		if i >= (frames+1)
			break
		end

		x = regexp(pathSeq, '/', 'split');
		disp([x{end} ':' num2str(i) '/' num2str(frames)])

		if ~(mod(i,30)) || ~(mod(i,40))

			% get morph
			% imgNew = imread(seq{3,i});
			imgNew = imread([pathImg '/' sequence{1,i} '_' sequence{2,i} '_039.bmp']);

			% Threshold - Dynamic: diminish than x
			% t = 140;
			% imgNew(imgNew > t) = t;
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

	mkdir(pathSeq)

	for iimg=1:size(images,3)
		disp(['Writing image: ' num2str(iimg) '/' num2str(size(images,3)) '-' num2str(randIdx)])
		img = images(:,:,iimg);


		% Apply watermarks
		if sequence{4,iimg}
			img(1:10,195:200) = 0;
		else
			img(1:10,195:200) = 255;
		end

		if sequence{5,iimg}
			img(1:10,200:205) = 0;
		else
			img(1:10,200:205) = 255;
		end

		if iimg == randIdx
			img(1:10,1:10) = 255;
		end

		% Sadr degradation
		img = sadr(img, degradation);

		% Write image
		imgName = [pathSeq '/' num2str(iimg) '.png'];
		imwrite(uint8(img),imgName);

	end

		% Save variables
		% matName = [pathSeq '/' 'seq.mat'];
		% save(matName)
end
