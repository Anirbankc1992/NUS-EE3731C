function imRe = haar_rec(im, J)    
    %% Init
    N = size(im, 1);    
    if J > log(N)/log(2), J = floor(log(N)/log(2)); end
    imRe = im;    
    %% Transform    
    for i = J:-1:1        
        w1 = imRe(1:(N/(2^i)), 1:(N/(2^i)));
        w2 = imRe((N/(2^i)+1):(N/(2^(i-1))), 1:(N/(2^i)));
        w3 = imRe(1:(N/(2^i)), (N/(2^i)+1):(N/(2^(i-1))));
        w4 = imRe((N/(2^i)+1):(N/(2^(i-1))), (N/(2^i)+1):(N/(2^(i-1))));
        imRe(1:(N/(2^(i-1))), 1:(N/(2^(i-1)))) = ihaar(w1, w2, w3, w4);
    end
end
