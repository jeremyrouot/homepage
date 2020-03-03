%Bezout algo
function bezout
  
  function res = xgcd(a,b)
    aold = a;
    bold = b;
    aa=[1,0];
    bb=[0,1]; 
    res = [0,0,0];
    while(1) 
    q = floor(a / b); 
    a = mod(a,b);
    aa(1) = aa(1) - q*aa(2);  bb(1) = bb(1) - q*bb(2);
    if (a == 0) 
      res(1) = b; 
      res(2) = aa(2); 
      res(3) = bb(2);
      return;
    endif
    q = floor(b / a); 
    b = mod(b,a);
    aa(2) = aa(2) - q*aa(1);  bb(2) = bb(2) - q*bb(1);
    if (b == 0) 
      res(1) = a; 
      res(2) = aa(1); 
      res(3) = bb(1);
      return;
    endif
  endwhile
endfunction

function mc = crypte(mot,p)
  s = double(mot);
  mc = [];
  for i=1:length(s)
    a=s(i);
    % on crypte
    aux = xgcd(a,p);
    c = mod(aux(2),p);
    mc = [mc(:); c]';
  endfor
endfunction


function motclear = decrypte(mot,p)
  motclear = "";
  for i=1:length(mot)
    %on trouve le coeff de bezout associe
    r = xgcd(mot(i),p);
    cclear = char(mod(r(2),p));
    motclear = cstrcat(motclear,cclear); 
  endfor
endfunction

lp = [257 263 269 271 277 281 283 293 307 311 313 317 331 337 347 349 353 ...
359 367 373 379 383 389 397 401 409 419 421 431 433 439 443 449 457 461 463 ...
467 479 487 491 499 503 509 521 523 541 547 557 563 569 571 577 587 593 599 ...
601 607 613 617 619 631 641 643 647 653 659 661 673 677 683 691 701 709 719 ...
727 733 739 743 751 757 761 769 773 787 797 809 811 821 823 827 829 839 853 ...
857 859 863 877 881 883 887 907 911 919 929 937 941 947 953 967 971 977 983 ...
991 997];
nbp = numel(lp);
p=lp(randi(nbp));

% pour garantir l'unicité:
%sol = mod(c(2),p)

%% on donne le string crypte en ASCII
ls = {"Ou tu sors ou j'te sors, mais faudra prendre une décision."};

nbs = length(ls);
s=ls{randi(nbs)};
mc = crypte(s,p)'
decrypte(mc,p);


fid = fopen ("res_bezout.txt","w");
entry = 1;
for va=2:53
  for vb=2:53
    res = xgcd(va,vb);
    if res(1)==1
      newu = mod(res(2),vb);
      k = floor((newu - res(2))/vb);
      newv = res(3) - k*va;
      fprintf(fid,"footable[%i]:[%i,%i,%i,%i,%i]\n",entry,va,vb,res(1),newu,newv);
      entry = entry+1;
    end
  endfor
endfor
fclose(fid);

r=xgcd(99,257)
mod(r(2),257)


endfunction