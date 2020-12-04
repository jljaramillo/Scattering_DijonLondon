reset
set terminal x11

set title "Pölsch-Teller QNM Spectra"

set xlabel "${\\rm Re}\\,(\\omega_n)$"
set ylabel "${\\rm Im}\\,(\\omega_n)$" rotate by 0 offset 2
set yrange [0:50]
set xrange [-2:2]

pl "Spectra_N_100_Prec_159.dat" u 2:(-$1) t"" w p pt 7 lc rgb "red"

set terminal epslatex color
set output "PolschTeller_QNM.tex"
rep
set terminal x11

###################################################################
set title "Pölsch-Teller QNM Perturbed-Spectra: Random Potential"
set xlabel "${\\rm Re}\\,(\\omega_n)$" offset 0, 0.5
set ylabel "${\\rm Im}\\,(\\omega_n)$" rotate by 0 offset 2,1.5
set xrange [-10:10]
set yrange [0.:12.]


#set key horizontal center bottom sample 0.1 width -3 outside

set key sample 0.1


pl "Spectra_N_100_Prec_159.dat" u 2:(-$1) t"$||\\delta V_r||=0$" w p pt 7 lc rgb "red"
set terminal epslatex color
set output "PolschTeller_PertQNM_Random_NoPert.tex"
rep
set terminal x11

set title""
pl "Spectra_N_100_Prec_159.dat" u 2:(-$1) t"" w p pt 7 lc rgb "red"
repl "Spectra_N_100_eps_1e-16_Prec_159.dat" u 2:(-$1) t"$||\\delta V_r||=10^{-16}$" w p pt 2 ps 1.5 lc rgb "black"
set terminal epslatex color
set output "PolschTeller_PertQNM_Random_-16.tex"
rep
set terminal x11

set title""
pl "Spectra_N_100_Prec_159.dat" u 2:(-$1) t"" w p pt 7 lc rgb "red"
repl "Spectra_N_100_eps_1e-8_Prec_159.dat" u 2:(-$1) t"$\||\\delta V_r||=10^{-8}$" w p pt 1 lw 3 ps 1.5 lc rgb "black"
set terminal epslatex color
set output "PolschTeller_PertQNM_Random_-8.tex"
rep
set terminal x11


pl "Spectra_N_100_Prec_159.dat" u 2:(-$1) t"" w p pt 7 lc rgb "red"
repl "Spectra_N_100_eps_1._Prec_159.dat" u 2:(-$1) t"$||\\delta V_r||=10^{0}$" w p pt 3 ps 1.5 lw 2 lc rgb "black"
set terminal epslatex color
set output "PolschTeller_PertQNM_Random_0.tex"
rep
set terminal x11

###################################################################
set title "Pölsch-Teller QNM Perturbed-Spectra: Deterministic Potential"
set xlabel "${\\rm Re}\\,(\\omega_n)$" offset 0, 0.5
set ylabel "${\\rm Im}\\,(\\omega_n)$" rotate by 0 offset 2,1.5
set xrange [-10:10]
set yrange [0.:12.]


pl "Spectra_N_100_Prec_159.dat" u 2:(-$1) t"$||\\delta V_d||=0$" w p pt 7 lc rgb "red"
set terminal epslatex color
set output "PolschTeller_PertQNM_Deter_NoPert.tex"
rep
set terminal x11

set title ""
#set key horizontal center bottom sample 0.1 width -10 outside
pl "Spectra_N_100_Freq_eps_1.e-8_ksig_1_Prec_159.dat" u 2:(-$1) t"$||\\delta V_d||\\!=\\!10^{-8},k=1$" w p pt 4 ps 1.6 lw 5 lc rgb "blue"
repl "Spectra_N_100_Prec_159.dat" u 2:(-$1) t"" w p pt 7 lc rgb "red"
set terminal epslatex color
set output "PolschTeller_PertQNM_Determ_k1_-8.tex"
rep
set terminal x11


pl "Spectra_N_300_Freq_eps_1.e-8_ksig_10_Prec_159.dat" u 2:(-$1)  t"$||\\delta V_d||\\!=\\!10^{-8},k = 10$" w p pt 8 ps 1. lw 5 lc rgb "blue"
repl "Spectra_N_100_Prec_159.dat" u 2:(-$1) t"" w p pt 7 lc rgb "red"
set terminal epslatex color
set output "PolschTeller_PertQNM_Determ_k10_-8.tex"
rep
set terminal x11

pl "Spectra_N_300_Freq_eps_1.e-8_ksig_20_Prec_159.dat" u 2:(-$1) t"$||\\delta V_d||\\!=\\!10^{-8},k = 20$" w p pt 12 ps 1. lw 5 lc rgb "blue"
repl "Spectra_N_100_Prec_159.dat" u 2:(-$1) t"" w p pt 7 lc rgb "red"
set terminal epslatex color
set output "PolschTeller_PertQNM_Determ_k20_-8.tex"
rep


set terminal epslatex color
set output "PolschTeller_PertQNM_Determ.tex"
rep
set terminal x11
###################################################################
set title "Pölsch-Teller pseudospectra"
set ylabel "${\\rm Im}\\,(\\omega_n)$" rotate by 0 offset -1.
##Countour Plot
set format y "% h"
unset logscale y

zmin=-30.
zmax=0.

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
set cbtics 3

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




set terminal epslatex color
set output "PolschTeller_PseudoSpectra.tex"

set multiplot

set contour base
unset surface

spl "PseudoSpectraEnergyNorm_N_100_Prec_159Re_s_[-6,0]_Im_s_[0,6].dat" u 2:(-$1):(log10(sqrt($3))) t"" w l lt -1 lw 1.5 lc rgb "white"

set title ""

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

spl "Spectra_N_100_Prec_159.dat" u 2:(-$1):(1) t"" w p pt 7 lc rgb "red"

unset multiplot


set terminal x11

set surface
unset contour
unset pm3d