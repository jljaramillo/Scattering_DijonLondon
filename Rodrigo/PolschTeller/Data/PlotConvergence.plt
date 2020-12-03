reset
set terminal x11
set logscale y
set format y "$10^{%L}$"

set xlabel "$N$" offset 0,0.5
set ylabel "${\\cal E}^{(N)}_n$" rotate by 0 offset 2.

set title "Pölsch-Teller QNM-convergence (\\texttt{Machine Precision})"
set key at 25,5. sample 1.

  pl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_15.dat" u 1:3 t"$n=0$" w lp lw 3
repl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_15.dat" u 1:4 t"$n=1$" w lp
repl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_15.dat" u 1:5 t"$n=2$" w lp lw 3
repl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_15.dat" u 1:6 t"$n=3$" w lp lw 3
repl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_15.dat" u 1:7 t"$n=4$" w lp lw 3

set terminal epslatex color
set output "Convergence_PT_MachPrec.tex"
rep
set terminal x11

set key at 25,5.e-65 sample 1.
set title "Pölsch-Teller QNM-convergence (\\texttt{$2\\times$Machine Precision})"
  pl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_31.dat" u 1:3 t"$n=0$" w lp lw 3
repl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_31.dat" u 1:4 t"$n=1$" w lp
repl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_31.dat" u 1:5 t"$n=2$" w lp lw 3
repl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_31.dat" u 1:6 t"$n=3$" w lp lw 3
repl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_31.dat" u 1:7 t"$n=4$" w lp lw 3

set terminal epslatex color
set output "Convergence_PT_2MachPrec.tex"
rep
set terminal x11

set title "Pölsch-Teller QNM-convergence (\\texttt{$5\\times$Machine Precision})"
  pl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_79.dat" u 1:3 t"$n=0$" w lp lw 3
repl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_79.dat" u 1:4 t"$n=1$" w lp
repl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_79.dat" u 1:5 t"$n=2$" w lp lw 3
repl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_79.dat" u 1:6 t"$n=3$" w lp lw 3
repl "Error_Spectra_N_100_Freq_eps_0._ksig_20._Prec_79.dat" u 1:7 t"$n=4$" w lp lw 3

set terminal epslatex color
set output "Convergence_PT_5MachPrec.tex"
rep
set terminal x11


set key at 390,5.e-3 sample 1.
set ylabel "Error $=|1 - \\omega^{(N)}/\\omega^{(N=400)}|$" rotate by 90 offset 1.5


set title "Pölsch-Teller convergence perturbed-QNM $(\\delta V_{\\rm d}=10^{-8}, \\, k=20$)"

  pl "ErrorSpectra_N_400_Freq_eps_0.00000001_ksig_20._Prec_159.dat" u 1:3 t"$\\omega = \\pm 0.86551036 + 4.49936170\\, i$" w lp lw 3
repl "ErrorSpectra_N_400_Freq_eps_0.00000001_ksig_20._Prec_159.dat" u 1:4 t"$\\omega = \\,\\,\\,\\,\\, 0.00000000 + 5.50486782\\, i$" w lp
repl "ErrorSpectra_N_400_Freq_eps_0.00000001_ksig_20._Prec_159.dat" u 1:5 t"$\\omega = \\pm 1.86409181 + 5.57531771\\, i$" w lp lw 3
repl "ErrorSpectra_N_400_Freq_eps_0.00000001_ksig_20._Prec_159.dat" u 1:6 t"$\\omega = \\pm 5.99926760 + 6.92585080\\, i$" w lp lw 3
repl "ErrorSpectra_N_400_Freq_eps_0.00000001_ksig_20._Prec_159.dat" u 1:7 t"$\\omega = \\pm 9.81564915 + 8.00708916\\, i$" w lp lw 3


set terminal epslatex color
set output "Convergence_PT_DetermPert.tex"
rep

set terminal x11