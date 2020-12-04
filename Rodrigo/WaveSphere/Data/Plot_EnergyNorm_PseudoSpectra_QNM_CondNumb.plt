reset

set terminal x11


set terminal epslatex color
set output "EnergyNorm_WaveSphere.tex"

set multiplot

set size noratio 0.9, 0.28
set origin 0.02, 0.9
set xlabel "\\large{$n$}" offset 0, 1.5
set ylabel "\\large{$\\kappa_n$}" rotate by 0 offset 1
set xrange [0:20]
set xtics 4
set yrange [0:2]
set ytics 1

pl "CondNumb_N_20_Prec_47.dat" u 1:3 t"" w p pt 7 lc -1



set xlabel  "\\large{${\\rm Re}(\\omega_n)$}" offset 0,-0.1
set ylabel "\\large{${\\rm Im}(\\omega_n)$}" rotate by 0 offset 0.


zmin=-10.
zmax=2

#Countour Plot

#set palette rgbformulae 23,28,3 

#### COLOURS #####################
##	'#440154' # dark purple		##
##	'#472c7a' # purple			##
##	'#3b518b' # blue			##
##	'#2c718e' # blue			##
##	'#21908d' # blue-green		##
##	'#27ad81' # green			##
##	'#5cc863' # green			##
##	'#aadc32' # lime green		##
##	'#fde725' # yellow			##
##################################
set palette defined ( zmin     "#aadc32", (zmax+zmin)/2   "#21908d", zmax    "#0c0887" )

set pm3d 
set pm3d map
set cbrange[zmin:zmax]

set colorbox
set cntrparam level incremental zmin, 2.e-1, zmax
unset key
set cntrlabel onecolor


set yrange [-10:10]
set xrange [-20:20]
set xtics 4
set ytics 2


set size noratio 1.,1.
set origin 0.,0.



set contour base
unset surface

spl "PseudoSpectraEnergyNorm_N_20_Prec_47_GnuPlot.dat" u 2:1:(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"
repl "PseudoSpectraEnergyNorm_N_20_Prec_47_GnuPlot.dat" u (-$2):1:(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"

set surface
unset contour
unset pm3d
spl "Spectra_N_20_Prec_47.dat" u 2:1:(1) w p pt 7 ps 1 lc rgb "red"

unset multiplot

