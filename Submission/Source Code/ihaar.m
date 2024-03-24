function x = ihaar(w1, w2, w3, w4)

    %% Init
    n = length(w1)*2;
    x = zeros(n, n);
    %% Compute
    for i=1:n/2
        for j=1:n/2
            i0 = 2*(i-1);
            j0 = 2*(j-1);
            x(i0+1,j0+1) = 1/2*(w1(i,j)+w2(i,j)+w3(i,j)+w4(i,j));
            x(i0+1,j0+2) = 1/2*(w1(i,j)+w2(i,j)-w3(i,j)-w4(i,j));
            x(i0+2,j0+1) = 1/2*(w1(i,j)-w2(i,j)+w3(i,j)-w4(i,j));
            x(i0+2,j0+2) = 1/2*(w1(i,j)-w2(i,j)-w3(i,j)+w4(i,j));        
        end
    end
end
