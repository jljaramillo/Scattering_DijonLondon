reset

set terminal x11


set terminal epslatex color
set output "PseudoSpectra_eps_1e-16_PolschTeller.tex"

set title "Pölsch-Teller Potential - Random Perturbation $||\\delta V_{\\rm r}|| = 10^{-16}$" offset 0,-2.

set multiplot

##Countour Plot
set xlabel  "\\large{${\\rm Re}(\\omega_n)$}" offset 0,-0.1
set ylabel "\\large{${\\rm Im}(\\omega_n)$}" rotate by 0 offset -1.,1.2
set format y "% h"

zmin=-20.
zmax=0.
dz = 1.

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
set cntrparam level incremental zmin, dz, zmax
unset key
set cntrlabel onecolor


set xrange [-10:10]
set yrange [0.:12.]
set xtics 2
set ytics 2


set size ratio -1 1.,1.
set origin 0.,0.


set contour base
unset surface



spl "Data/PolschTeller/PseudoSpectra_RandomPert_eps_0.0000000000000001_N_100_Prec_159Re_s_[-6,0]_Im_s_[0,6].dat" u 2:(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"
spl "Data/PolschTeller/PseudoSpectra_RandomPert_eps_0.0000000000000001_N_100_Prec_159Re_s_[-6,0]_Im_s_[0,6].dat" u (-$2):(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"

spl "Data/PolschTeller/PseudoSpectra_RandomPert_eps_0.0000000000000001_N_100_Prec_159Re_s_[-6,0]_Im_s_[6,10].dat" u 2:(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"
spl "Data/PolschTeller/PseudoSpectra_RandomPert_eps_0.0000000000000001_N_100_Prec_159Re_s_[-6,0]_Im_s_[6,10].dat" u (-$2):(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"

spl "Data/PolschTeller/PseudoSpectra_RandomPert_eps_0.0000000000000001_N_100_Prec_159Re_s_[-10,-6]_Im_s_[6,10].dat" u 2:(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"
spl "Data/PolschTeller/PseudoSpectra_RandomPert_eps_0.0000000000000001_N_100_Prec_159Re_s_[-10,-6]_Im_s_[6,10].dat" u (-$2):(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"

spl "Data/PolschTeller/PseudoSpectra_RandomPert_eps_0.0000000000000001_N_100_Prec_159Re_s_[-10,-6]_Im_s_[0,6].dat" u 2:(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"
spl "Data/PolschTeller/PseudoSpectra_RandomPert_eps_0.0000000000000001_N_100_Prec_159Re_s_[-10,-6]_Im_s_[0,6].dat" u (-$2):(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"

spl "Data/PolschTeller/PseudoSpectra_RandomPert_eps_0.0000000000000001_N_100_Prec_159Re_s_[-12,-10]_Im_s_[0,10].dat" u 2:(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"
spl "Data/PolschTeller/PseudoSpectra_RandomPert_eps_0.0000000000000001_N_100_Prec_159Re_s_[-12,-10]_Im_s_[0,10].dat" u (-$2):(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"


unset multiplot

