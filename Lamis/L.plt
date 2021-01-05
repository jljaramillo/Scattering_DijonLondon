reset
set terminal x11

###################################################################
set title "PT cut"
set xlabel "${\\rm Re} (\\omega_n)$" offset 0, 0.5
set ylabel "${\\rm Im} (\\omega_n)$" rotate by 0 offset 2,1.5
set xrange [-10:10]
set yrange [0.:12.]

#set key horizontal center bottom sample 0.1 width -60 outside
#set key sample 0.-1
#set ratio 2
set title""
  pl "SWZ_f.dat" u 2:(-$1) t"" w p pt 7 lc rgb "red"
repl "SWZ_c.dat" u 2:(-$1) t"" w p pt 6 lw 3.3 lc rgb "blue"
set terminal epslatex color
#set origin , 0
set output "L.tex"
repl
