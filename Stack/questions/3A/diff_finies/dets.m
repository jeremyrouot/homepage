% calcul determinant utile en diff finies


for N=2:10
    A = diag(ones(N-1,1),-1)+    diag(ones(N-1,1),1) - 2 * diag(ones(N,1));
    det(A)
    B = A;
    B(N,N) = -1;
    det(B)
    
    disp(' ');
endfor
