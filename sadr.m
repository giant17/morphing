function [img] = sadr(img, degradation)

    y = fft2(double(img));        % Compute DFT of x

    % get Amplitude:
    ampl = abs(y); %R = abs(Z)

    %get Phase
    theta = angle(y);%p    = unwrap(angle(y));

    theta2 = theta;
    for r = 1:400
        theta2(r, :) = theta(r, randperm(400));
    end
    for c = 1:400
        theta2(:, c) = theta(randperm(400), c);
    end
    %fixing the zero-crossing in half of the pixels:
    zerocrossers = sign(theta2 - theta);

    %make indices to one half of the phase matrix:
    randomindices = round(rand(size(theta)));

    %add or subtract 2*pi in half of the matrix (depending on the sign of change,
    %i.e. from pos to neg or from neg to pos), don't do anything to the
    %other half:
    addorsubtract2pi = (zerocrossers.*2*pi.*(-1)) .* randomindices ;

    %apply addorsubtract2pi to theta2:
    theta3 = theta2 + addorsubtract2pi;

    indices_newphase = round(rand(size(theta))+0.5 - degradation); %80% visability

    theta4 = theta; %original phase spectrum des jeweiligen bildes
    theta4(indices_newphase == 1) = theta3(indices_newphase == 1); %those get the randomized phase from Mask


    %back to FFT:
    y2 = ampl.*exp(i*theta4);

    %back to the image
    degraded = ifft2(y2, 'symmetric');

    %linear shifts to bring values back into the luminance spectrum:
    %%%AvgDiff = mean(mean(img)) - mean(mean(mask));
    mean(mean(degraded));

    if mean(mean(degraded)) < 0
        degraded = degraded - 2*mean(mean(degraded));
    end

    AvgDiff = 127 - mean(mean(degraded));

    img = degraded + AvgDiff;
end
