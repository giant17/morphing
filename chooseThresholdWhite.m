% Before shining, I need to threhsold the whiteness of teeth
% 1 Try: if > threshold -> decrease of: (x - avgImg)


pathFrom = '~/.local/share/gdrive/MA_Gianluca/Data/faceemo/Facegen_output_ori039';

images = dir(pathFrom);
images = {images(3:end).name};
img = rgb2gray(imread([pathFrom '/' images{2}]));
% imshow(img)

% The higher value in anger faces is 242, let's try with rt
images = [];

% 1
images = cat(3,images,img);

x = img;
rt = 230;
t = mean(x(x > rt)) - mean(x(x > 29));
img(img > rt) = img(img > rt) - t;

% 2
images = cat(3,images,img);

img = x;
rt = 100
img(img > rt) = mean(x(x > 29)) + (abs(img(img > rt)) - rt);

% 3
images = cat(3,images,img);

rt = 200;
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
img(img(200:end,1:end) > rt)

rt = 230
a = img(200:end,1:end) > rt;

img(a);

img(img(200:end,1:end) > 150);



img = x;
rt = 100;
halfA = img(1:250,1:end);
halfB = img(251:end,1:end);

meanAll = mean(img,'all');
d = halfB(halfB > rt) - rt;

halfB(halfB > rt) = meanAll + d - 10;
img = cat(1,halfA,halfB);
images = cat(3, images, img);



mean(img,'all')
kj

rt = 140;
 = img(img > rt) - rt
img(img > rt) = mean(img(img > 29)) + d;

images = cat(3, images, img);

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












