function imTr2 = denoise(imTr, J, sigma, thr) 
    N = length(imTr);
    imTr2 = imTr;
    for i = 1:J
        % Extract
        w2 = imTr2((N/(2^i)+1):(N/(2^(i-1))), 1:(N/(2^i)));
        w3 = imTr2(1:(N/(2^i)), (N/(2^i)+1):(N/(2^(i-1))));
        w4 = imTr2((N/(2^i)+1):(N/(2^(i-1))), (N/(2^i)+1):(N/(2^(i-1))));
        % Threshold
        w2 = wthresh(w2, thr, 3*sigma);
        w3 = wthresh(w3, thr, 3*sigma);
        w4 = wthresh(w4, thr, 3*sigma);
%         w2 = w2.*(abs(w2)>=3*sigma);
%         w3 = w3.*(abs(w3)>=3*sigma);
%         w4 = w4.*(abs(w4)>=3*sigma);
        % Push back        
        imTr2((N/(2^i)+1):(N/(2^(i-1))), 1:(N/(2^i))) = w2;
        imTr2(1:(N/(2^i)), (N/(2^i)+1):(N/(2^(i-1)))) = w3;
        imTr2((N/(2^i)+1):(N/(2^(i-1))), (N/(2^i)+1):(N/(2^(i-1)))) = w4;
    end
end