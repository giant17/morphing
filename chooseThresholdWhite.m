% Before shining, I need to threhsold the whiteness of teeth
% 1 Try: if > threshold -> decrease of: (x - avgImg)


% TODO: Treshold BEFORE grayscale -> Lowee halpf to avoid eyes
clear
clearvars
pathFrom = '~/.local/share/gdrive/MA_Gianluca/Data/faceemo/Facegen_output_ori039';

images = dir(pathFrom);
images = {images(3:end).name};
img = imread([pathFrom '/f1_01_039.bmp']);


imgl = reshape(img,[400*400,1,3]);

rt = 150;
for i=1:size(imgl,1)
	if imgl(i,1,1) > rt && imgl(i,1,2) > rt && imgl(i,1,3) > rt
		disp(['Found one at: ' num2str(i) ' - ' num2str(imgl(i,1,1)) ])
		% imgl(i,1,1) = 127;
		% imgl(i,1,2) = 127;
		% imgl(i,1,3) = 127;
	end
end
x = 0;
rt = 145;
for row=1:size(img,1)
	for col = 1:size(img,2)
		if img(row,col,1) > rt && img(row,col,2) > rt && img(row,col,3) > rt
			disp(['Found one - ' 'row: ' num2str(row) '/col: ' num2str(col)])
			disp(img(row,col,1))
			disp(img(row,col,2))
			disp(img(row,col,3))
			img(row,col,1) = img(row,col,1) - 50;
			img(row,col,2) = img(row,col,2) - 50;
			img(row,col,3) = img(row,col,3) - 50;
		end
	end
end


imshow(img)

%%

t = mean(x(x > rt)) - mean(x(x > 29));
img(img > rt) = img(img > rt) - t;
% size(imgl)
% imgl(:,:,1)
% imgl(12000,1,1)

% img = reshape(imgl,[400,400,3]);
% imshow(img)
%%


img(img(:,:,1) > 150) = 127;
imshow(img)

img(:,:,1) > 150 && img(:,:,2)
size(img(:,:,3))
imshow(img)

img(200,301,:)

max(max(img))



for i=1:size(imgl,1)
	if imgl(i,1,1) > 150 && imgl(i,1,2) > 150 imgl(i,1,3) > 150
		imgl(i,1,1) = 127;
		imgl(i,1,2) = 127;
		imgl(i,1,3) = 127;
	end
end

a = [1,2,3,240];
b = [1,2,3,220];
c = [1,2,3,210];
x = cat(3,a,b,c)
size(x)

x(x > 210) = [127 127 127];
x(x(:,:,2) > 200)

img
img = reshape(imgl,[400,400,3])
imshow(img)

rt = 150;
img(:,:,1) > 150 && img(:,:,2) > 150

img(img > 150) = 127;
imshow(img)
img(img(:,:,3) > rt & img(:,:,2) > rt & img(:,:,1) > rt) = 127;
imshow(img)


imshow(img);
img = rgb2gray(imread([pathFrom '/' images{2}]));
imshow(img)
max(max(img))
img(1:20,1)
img(img > 230)
% The higher value in anger faces is 242, let's try with rt
images = [];
% 1
images = cat(3,images,img);


img = rgb2gray(imread([pathFrom '/' images{2}]));
ims = [];
ims = [ims img];
rt = 127;
t = mean(img(img > rt)) - mean(img(img > 29));
img(img > rt) = img(img > rt) - t;
ims = [ims img];
montage(ims);
% imshow(img)
% 2
images = cat(3,images,img);

img = x;
rt = 100
img(img > rt) = mean(x(x > 29)) + (abs(img(img > rt)) - rt);

% 3
images = cat(3,images,img);

rt = 150;
img = x;
t = mean(x(x > rt)) - mean(x(x > 29));
img(img > rt) = img(img > rt) - t;

% 4
images = cat(3,images,img);

img = x;
img(img > rt) = mean(x(x > 29)) + (abs(img(img > rt)) - rt);

% 5
images = cat(3,images,img);

rt = 255/2;
img = x;
t = mean(x(x > rt)) - mean(x(x > 29));
img(img > rt) = img(img > rt) - t;

% 6
images = cat(3,images,img);

img = x;
img(img > rt) = mean(x(x > 29)) + (abs(img(img > rt)) - rt);

% 7
images = cat(3,images,img);

rt = 100;
img = x;
t = mean(x(x > rt)) - mean(x(x > 29));
img(img > rt) = img(img > rt) - t;

% 8
images = cat(3,images,img);

img = x;
img(img > rt) = mean(x(x > 29)) + (abs(img(img > rt)) - rt);

% 9
images = cat(3,images,img);

rt = mean(img(img > 29));
img = x;
t = mean(x(x > rt)) - mean(x(x > 29));
img(img > rt) = img(img > rt) - t;

% 10
images = cat(3,images,img);

img = x;
img(img > rt) = mean(x(x > 29)) + (abs(img(img > rt)) - rt);

% 11
images = cat(3,images,img);

rt = 255/2;
img = x;
img(img > rt) = img(img > rt) - mean(img(img > 29))

% 12
images = cat(3,images,img);

img = x;
s = mean(img(img > rt) - mean(img(img > 29)))
mean(img(img > 29))
img(img > rt) - s




q = img(img > rt);

s = img(img > rt) - rt

img(img > rt) = mean(img(img > 29)) + s;
images = cat(3,images,img);

rt = 230;
img = x;
meanUp = mean(img(img > rt));
meanAll = mean(img(img > 29));
diffMean = meanUp - meanAll;

img(img > rt) = img(img > rt) - diffMean;

images = cat(3, images, img);

rt = 170;
img = x;
meanUp = mean(img(img > rt));
meanAll = mean(img(img > 29));
diffMean = meanUp - meanAll;

img(img > rt) = img(img > rt) - diffMean;

images = cat(3, images, img);

img = x;
img(img(150:end,1:end) > rt)

rt = 230
a = img(150:end,1:end) > rt;

img(a);

img(img(150:end,1:end) > 150);



img = x;
rt = 100;
halfA = img(1:250,1:end);
halfB = img(251:end,1:end);

meanAll = mean(img,'all');
d = halfB(halfB > rt) - rt;

halfB(halfB > rt) = meanAll + d - 10;
img = cat(1,halfA,halfB);
images = cat(3, images, img);



mean(img,'all');

rt = 140;
d = img(img > rt) - rt
img(img > rt) = mean(img(img > 29)) + d;

images = cat(3, images, img);


rt = 255/2;
img = x;
img(img > rt) = img(img > rt) - 100;

images = cat(3,images,img);

rt = 255/2;
img = x;
img(img > rt) = img(img > rt) - 70;

images = cat(3,images,img);

rt = 255/2;
img = x;
img(img > rt) = img(img > rt) - 40;

images = cat(3,images,img);

rt = 255/2;
img = x;
img(img > rt) = img(img > rt) - 50;

images = cat(3,images,img);

rt = 255/2;
img = x;
img(img > rt) = img(img > rt) - 60;

images = cat(3,images,img);

montage(images)
% pathFrom = '~/.local/share/gdrive/MA_Gianluca/Data/faceemo/Facegen_output_ori039';
% imageNames = dir(pathFrom);
% names = {imageNames(3:end).name}

% whiteEmo = {'01', '02', '03', '06', '07'};

% for iimg=1:length(names)
% 	a = regexp(names{iimg}, '_', 'split');

% 	if ismember(a{2}, whiteEmo)
% 		disp(names{iimg})
% 	end
% end



%% After Shined

imgName = '~/shined/f1_01_039.bmp';
img = imread(imgName);
images = [];
images = cat(3,images,img);

rt = 120;
img(img > rt) = img(img > rt) - 50;
images = cat(3,images,img);
montage(images);



clear
clearvars
pathFrom = '~/Datasets/MasterThesis/Faces/Original';
imgName = [pathFrom '/f10_01_039.bmp'];
t = 120;
img = imread(imgName);
imgA = img(1:250,1:end,:);
imgB = img(251:end,1:end,:);

% imshow(img)
meanImg = mean(img,'all');
% deltaImg = img(img(:,:,1) > t & img(:,:,2) > t & img(:,:,3) > t) - meanImg;
% img(img(:,:,1) > t & img(:,:,2) > t & img(:,:,3) > t) = img(img(:,:,1) > t ...
%                                                     & img(:,:,2) > t & img(:,:,3) ...
%                                                     > t) - deltaImg;
% imshow(img)

deltaImg = imgB(imgB(:,:,1) > t & imgB(:,:,2) > t & imgB(:,:,3) > t) - ...
    meanImg;
size(deltaImg)
imgB(imgB(:,:,1) > t & imgB(:,:,2) > t & imgB(:,:,3) > t) = imgB(imgB(:,:,1) > t ...
                                                    & imgB(:,:,2) > t & imgB(:,:,3) ...
                                                    > t) - deltaImg;

x = (cat(1,imgA,imgB));
figure
imshow(x)
y = imread(imgName);
figure
imshow(y)
