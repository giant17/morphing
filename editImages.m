pathFrom = '~/Datasets/MasterThesis/Faces/Original';
pathTo = '~/Datasets/MasterThesis/Faces/ShinedTest';
mkdir(pathTo);
pathShine = '~/Projects/Matlab/shine';
addpath(pathShine);

t = 145;
degradation = 0.95;

imagesName = getImagesName(pathFrom);
images = cell(size(imagesName,2),1);

for iimg=1:length(imagesName)
    imageName = imagesName{iimg};
    img = removeWhite(pathFrom, t, imageName);
    images{iimg} = img;
end

shined = shineImages(images);
writeImages(pathTo, shined, imagesName,degradation);

function [names] = getImagesName(pathFrom)
imagesName = dir(pathFrom);
names = {imagesName(3:end).name};
end

function [img] = removeWhite(pathFrom, t, imageName)

  imagePath = [pathFrom '/' imageName];
  img = imread(imagePath);

  % Split image
  imgA = img(1:250,1:end,:);
  imgB = img(251:end,1:end,:);

  % Decrease target by difference between them and the mean
  meanImg = mean(img,'all');
  deltaImg = imgB(imgB(:,:,1) > t & imgB(:,:,2) > t & imgB(:,:,3) > t) - ...
      meanImg;
  imgB(imgB(:,:,1) > t & imgB(:,:,2) > t & imgB(:,:,3) > t) = imgB(imgB(:,:,1) ...
                                                  > t & imgB(:,:,2) > t & ...
                                                  imgB(:,:,3) > t) - ...
      deltaImg;

  % Merge image
  img = (cat(1,imgA,imgB));

  % Grayscale
  img = squeeze(mean(img,3));
end

function [shined] = shineImages(images)
  shined = cell(1,ceil(length(images)/100));
  k = 1;

  while true
    if length(images) > 100
      shined{k} = SHINE(images(1:100));
      images(1:100) = [];
      k = k+1;
      disp(repmat('-',1,50))
      disp(['Batch shining complete: ' num2str(k) '/' num2str(ceil(length(images)/100))])
      disp(repmat('-',1,50))
    else
      shined{k} = SHINE(images);
      break
    end
  end
end

function [] = writeImages(pathTo, shined, imagesName,degradation)
  k = 1;
  for ishine=1:length(shined)
    for iimg=1:length(shined{ishine})
      img = shined{ishine}{iimg};
      oldName = regexp(imagesName{k}, '/', 'split');
      rootName = oldName{end};
      newName = [pathTo '/' oldName{end}];
      img = getImageSadr(img,degradation);
      imwrite(img, newName);
      disp(['Image write complete:' num2str(k) '/' num2str(length(imagesName))])
      k = k+1;
    end
  end
end

function [img] = getImageSadr(img,degradation)
    imgSize = size(img,1);
    y = fft2(double(img));
    ampl = abs(y);
    theta = angle(y);
    theta2 = theta;
    for r = 1:imgSize
        theta2(r, :) = theta(r, randperm(imgSize));
    end
    for c = 1:imgSize
        theta2(:, c) = theta(randperm(imgSize), c);
    end
    zerocrossers = sign(theta2 - theta);
    randomindices = round(rand(size(theta)));
    addorsubtract2pi = (zerocrossers.*2*pi.*(-1)) .* randomindices ;
    theta3 = theta2 + addorsubtract2pi;
    indices_newphase = round(rand(size(theta))+0.5 - degradation);
    theta4 = theta;
    theta4(indices_newphase == 1) = theta3(indices_newphase == 1);
    y2 = ampl.*exp(i*theta4);
    degraded = ifft2(y2, 'symmetric');
    mean(mean(degraded));
    if mean(mean(degraded)) < 0
        degraded = degraded - 2*mean(mean(degraded));
    end
    AvgDiff = 127 - mean(mean(degraded));
    img = uint8(degraded + AvgDiff);
end
