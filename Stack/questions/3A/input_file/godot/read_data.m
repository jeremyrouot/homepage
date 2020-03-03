function read_data()
  clear 
  xy = dlmread("data_xy.txt", {"x=","y="},0,2); 
  plot(xy(:,1),xy(:,2));
  [res,a] = max(sqrt(xy(:,2)./(1+xy(:,1))))

endfunction
