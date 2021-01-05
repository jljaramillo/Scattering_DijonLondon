reset
set terminal x11

set pm3d
unset surface # don't need surfaces
set view map
set contour
set key outside
#set cntrparam linear # smooth out the lines
#set cntrparam levels 200 # sets the num of contour lines
set cntrparam levels incremental -20,0.1,0
set pm3d interpolate 20,20 # interpolate the color


set palette model CMY rgbformulae 7,5,15

set contour base


#Axes

set xlabel 'X'
set ylabel 'Y'
set format x '%.1f'
set format y '%.1f'
set format z '%.2f'
unset size
set size square 3
#Now plot
set dgrid3d 50,50 
splot 'PT_PS2.dat' using 1:2:3 notitle with lines lt 1
set terminal epslatex color
set output 'PT_PS.tex'
splot 'PT_PS2.dat' using 1:2:3 notitle with lines lt 1
