clc
clear all
close all

% Set the parameter H and the sample length 
H = 0.7; lg = 1000000; 
% Generate and plot wavelet-based fBm for H = 0.3
%fBm03 = wfbm(H,lg,'plot');
% Generate and plot wavelet-based fBm for H = 0.7 
%fBm07 = wfbm(H,lg,'plot');
h = figure;

FBM = wfbm(H,lg);
N = size(FBM,2);
plot(1:N,FBM);
%{
system('rm -rf *.png');
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'bw-';
nmax=800;
N = size(FBM,2);
plot(1:N,FBM);
nf=0;
for n = 1:0.3:nmax
    nf = nf+1;
   % FBM = wfbm(H,lg,'plot');
      %plot(1:N,FBM);
      xg = max(floor(N/2*(1-n/nmax)),1);
      xd = min(floor(N/2*(1+n/nmax)),N);
      ym = min(FBM(xg:xd));
      yM = max(FBM(xg:xd));
      axis([xg xd ym yM]);
      axis off
      drawnow 
      % Capture the plot as an image 
      frame = getframe(h); 
      im = frame2im(frame); 
      [imind,cm] = rgb2ind(im,256); 
      % Write to the GIF File 
      imwrite(imind,cm,['bw-' num2str(nf) '.png'],'png');
      %{
      if n == 1 
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
      else 
          imwrite(imind,cm,filename,'gif','WriteMode','append'); 
      end 
      %}
      if mod(n,100)==0
          n
      end
end
  %}