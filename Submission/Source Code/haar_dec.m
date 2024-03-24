function imTr = haar_dec(im, J)    
    %% Init
    N = size(im, 1);    
    if J > log(N)/log(2), J = floor(log(N)/log(2)); end
    imTr = zeros(N, N);
    w1 = im;
    %% Transform
    for i = 1:J
        [w1,w2,w3,w4] = haar(w1);
        imTr(1:(N/(2^i)), 1:(N/(2^i))) = w1;
        imTr((N/(2^i)+1):(N/(2^(i-1))), 1:(N/(2^i))) = w2;
        imTr(1:(N/(2^i)), (N/(2^i)+1):(N/(2^(i-1)))) = w3;
        imTr((N/(2^i)+1):(N/(2^(i-1))), (N/(2^i)+1):(N/(2^(i-1)))) = w4;
    end
end
