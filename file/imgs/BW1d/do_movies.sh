#convert -verbose -coalesce bw.gif bw.png

#identify image.png --> return size

#for i in *.png
#do
#  rt=`basename "$i" .png`
#  convert "$i" -crop 428x338+77+37 ok"$rt".png
#done

rm bw.mp4
ffmpeg -framerate 100 -start_number 1 -i bw-%1d.png -c:v libx264 -profile:v high -pix_fmt yuv420p bw.mp4
#ffmpeg -framerate 100 -start_number 1 -i bw-%1d.png -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p bw.mp4

#mencoder mf://*.png -mf w=568:h=416:fps=25:type=png -ovc copy -oac copy -o bw.mkv

