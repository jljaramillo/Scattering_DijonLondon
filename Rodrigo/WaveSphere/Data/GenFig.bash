#!/bin/bash

########## INSTRUCTION ###################
#  1) Select Gnuplot script one wants to run
#  2) Observer file naming the output within script: e.g. NAME.tex
#  3) Find (or create) in folder Latex_Sources/ specific file with extension NAME_latex.tex
#  4) Certify that line 52 in NAME_latex.tex has the correct NAME.tex as input
#  5) Copy NAME_latex.tex to folder were this script is saved
#  6) Run ./GenFig
##########################################

rm -f *.log
rm -f *.aux
rm -f *.dvi
rm -f *.pdf

gnuplot Plot_EnergyNorm_PseudoSpectra.plt
gnuplot Plot_EnergyNorm_PseudoSpectra_QNM_CondNumb.plt



for f in *_latex.tex
do
 echo "******** Processing Latex $f********************************"
 latex $f

 f_dvi=${f%.*}.dvi
 

 echo "******** Processing dvipdf $f_dvi ******************************"
 dvipdf $f_dvi
 
 f_pdf=${f_dvi%.*}.pdf

 echo "******** Processing pdfcrop $f_pdf *****************************"
 pdfcrop $f_pdf
 
 echo "********************************************************************************"
 echo ""
done



for f_crop in *-crop.pdf

do
  f_name=${f_crop%_*}.pdf
  echo "******** removing crop and latex names from $f_name *****************************"
  mv $f_crop $f_name
  cp $f_name ../$f_name
done

rm -f *.log
rm -f *.aux
rm -f *.dvi
rm -f *.out
rm -f *_latex.pdf



