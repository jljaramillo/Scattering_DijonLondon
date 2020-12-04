reset

set terminal x11


set terminal epslatex color
set output "EnergyNorm_PolschTeller.tex"

set multiplot

set size noratio 1.07, 0.26
set origin -0.14, 0.97
set xlabel "\\large{$n$}" offset 0, 1.5
set ylabel "{$\\log\\left(\\dfrac{\\kappa_n}{\\kappa_0}\\right)$}" rotate by 0 offset 7
set xrange [0:12]
set xtics 4
#set logscale y
set yrange [0:30]
set ytics 15
#set format y "$10^{%L}$"


k0=61.8079957757295617551808818461071969407832971602604

pl "CondNumb_N_100_Prec_159.dat" u 1:(log10($3/k0)) t"" w p pt 7 lc -1



##Countour Plot
set xlabel  "\\large{${\\rm Re}(\\omega_n)$}" offset 0,-0.1
set ylabel "\\large{${\\rm Im}(\\omega_n)$}" rotate by 0 offset -1.,1.2
set format y "% h"
unset logscale y


zmin=-30.
zmax=0.

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
set cntrparam level incremental zmin, 3, zmax
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



spl "PseudoSpectraEnergyNorm_N_100_Prec_159Re_s_[-6,0]_Im_s_[0,6].dat" u 2:(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"
spl "PseudoSpectraEnergyNorm_N_100_Prec_159Re_s_[-6,0]_Im_s_[0,6].dat" u (-$2):(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"

spl "PseudoSpectraEnergyNorm_N_100_Prec_159Re_s_[-6,0]_Im_s_[6,10].dat" u 2:(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"
spl "PseudoSpectraEnergyNorm_N_100_Prec_159Re_s_[-6,0]_Im_s_[6,10].dat" u (-$2):(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"

spl "PseudoSpectraEnergyNorm_N_100_Prec_159Re_s_[-10,-6]_Im_s_[6,10].dat" u 2:(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"
spl "PseudoSpectraEnergyNorm_N_100_Prec_159Re_s_[-10,-6]_Im_s_[6,10].dat" u (-$2):(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"

spl "PseudoSpectraEnergyNorm_N_100_Prec_159Re_s_[-10,-6]_Im_s_[0,6].dat" u 2:(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"
spl "PseudoSpectraEnergyNorm_N_100_Prec_159Re_s_[-10,-6]_Im_s_[0,6].dat" u (-$2):(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"

spl "PseudoSpectraEnergyNorm_N_100_Prec_159Re_s_[-12,-10]_Im_s_[0,10].dat" u 2:(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"
spl "PseudoSpectraEnergyNorm_N_100_Prec_159Re_s_[-12,-10]_Im_s_[0,10].dat" u (-$2):(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"


set surface
unset contour
unset pm3d



set key at 10.8, 14.9 samplen 1.9
spl "Spectra_N_100_Freq_eps_1.e-8_ksig_1_Prec_159.dat" u 2:(-$1):(1) t"$||\\delta V_d||\\!=\\!10^{-8},k=1$" w p pt 4 ps 1.6 lw 5 lc rgb "blue"

set key at 10.3, 13.9 samplen 0.1
spl "Spectra_N_300_Freq_eps_1.e-8_ksig_10_Prec_159.dat" u 2:(-$1):(1) t"$||\\delta V_d||\\!=\\!10^{-8},k = 10$" w p pt 8 ps 1. lw 5 lc rgb "blue"

set key at 10.3, 12.9 samplen 0.1
#spl "Spectra_N_350_Freq_eps_1.e-8_ksig_30_Prec_159.dat" u 2:(-$1):(1) t"$||\\delta V_d||\\!=\\!10^{-8},k = 30$" w p pt 12 ps 1. lw 5 lc rgb "blue"
spl "Spectra_N_300_Freq_eps_1.e-8_ksig_20_Prec_159.dat" u 2:(-$1):(1) t"$||\\delta V_d||\\!=\\!10^{-8},k = 20$" w p pt 12 ps 1. lw 5 lc rgb "blue"


spl "Spectra_N_100_Prec_159.dat" u 2:(-$1):(1) t"" w p pt 7 ps 1.1 lc rgb "red"



set key at -2.4, 14.9 samplen 0.01
spl "Spectra_N_100_eps_1e-16_Prec_159.dat" u 2:(-$1):(1) t"$||\\delta V_r||=10^{-16}$" w p pt 2 ps 1.5 lc rgb "black"

set key at -2.2, 13.9 samplen 1.0
spl "Spectra_N_100_eps_1e-8_Prec_159.dat" u 2:(-$1):(1) t"$\||\\delta V_r||=10^{-8}$" w p pt 1 lw 3 ps 1.5 lc rgb "black"

set key at -1.7, 12.9 samplen 2.9
spl "Spectra_N_100_eps_1._Prec_159.dat" u 2:(-$1):(1) t"$||\\delta V_r||=10^{0}$" w p pt 3 ps 1.5 lw 2 lc rgb "black"





#set key at -3.0, 14. samplen 5.6
#spl "Spectra_N_100_Prec_159.dat" u 2:(-$1):(1) t"$||\\delta V||=0$" w p pt 7 ps 2. lc rgb "red"
#
#set key at 10.8, 13. samplen 1.
#spl "Spectra_N_300_Freq_eps_1.e-8_ksig_20_Prec_159.dat" u 2:(-$1):(1) t"$,||\\delta V_d||=10^{-8}\\quad k = 20$" w p pt 2 ps 1. lw 5 lc rgb "blue"
#
#set key at 11.2, 14. samplen 2.6
#spl "Spectra_N_100_Freq_eps_1.e-8_ksig_1_Prec_159.dat" u 2:(-$1):(1) t"$,||\\delta V_d||=10^{-8}\\quad k = 1$" w p pt 4 ps 1. lw 5 lc rgb "blue"
#
#
#set key at -4.2, 13. samplen 0.01
#spl "Spectra_N_100_eps_1e-16_Prec_159.dat" u 2:(-$1):(1) t"$||\\delta V_r||=10^{-16}$" w p pt 3 ps 1. lc rgb "black"
#
#set key at 1.9, 14. samplen 1.0
#spl "Spectra_N_100_eps_1e-8_Prec_159.dat" u 2:(-$1):(1) t"$,\||\\delta V_r||=10^{-8}$" w p pt 1 lw 3 ps 1. lc rgb "black"
#
#
#set key at 3.1, 13. samplen 5.8
#spl "Spectra_N_100_eps_1._Prec_159.dat" u 2:(-$1):(1) t"$,||\\delta V_r||=1$" w p pt 2 ps 1. lw 5 lc rgb "black"




unset multiplot

