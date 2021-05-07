(* ::Package:: *)

(* ::Title:: *)
(*QNM Schwarzschild Potential*)


(* ::Section:: *)
(*Quasi-normal Modes and quasi-normal functions*)


(* ::Subsection:: *)
(*Numerical parameters*)


Clear["Global`*"]

SetDirectory[NotebookDirectory[]];
Prec=500;
z0=0;
z1=1;
\[CapitalDelta]z=z1-z0;

Nz=20;
spin=-2;
l=2;

NzHigh=2 Nz;
x[i_,Nz_]:=Cos[(\[Pi] i)/Nz];

X=N[Table[x[i,Nz],{i,0,Nz}],Prec];
XX=N[Table[x[i,NzHigh],{i,0,NzHigh}],Prec];

z=N[Table[z0+1/2 \[CapitalDelta]z (1+x[i,Nz]),{i,0,Nz}],Prec];
zz=N[Table[z0+1/2 \[CapitalDelta]z (1+x[i,NzHigh]),{i,0,NzHigh}],Prec];

\[Sigma]=z;(*(1+z)/2;*)
\[Sigma]\[Sigma]=zz;(*(1+zz)/2;*)


(* ::Subsubsection:: *)
(*Load Matrices*)


fn="OperatorMatrix/AxialParity/M_spin_"<>ToString[spin]<>"_l_"<>ToString[l]<>"N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
M=N[Import[fn,"Table"]/10^(Prec+10),Prec];

fn="OperatorMatrix/AxialParity/MAdj0_spin_"<>ToString[spin]<>"_l_"<>ToString[l]<>"N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
MAdj0=N[Import[fn,"Table"]/10^(Prec+10),Prec];

fn="OperatorMatrix/AxialParity/H0_spin_"<>ToString[spin]<>"_l_"<>ToString[l]<>"N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
H0=N[Import[fn,"Table"]/10^(Prec+10),Prec];


(* ::Subsubsection:: *)
(*Eigenvalue problem*)


Print["Calculating QNM"];
EigenSol=Eigensystem[M];

SpectrumData=Table[{Re@EigenSol[[1,iqnm]],Im@EigenSol[[1,iqnm]]},{iqnm,1,Length@EigenSol[[1]]}];
fn="Data/AxialParity/Spectra_spin_"<>ToString[spin]<>"_l_"<>ToString[l]<>"_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Export[fn,N[SpectrumData,Prec],"Table"];

EigenSolAdj0=Eigensystem[MAdj0];


Print["Done"];


(* ::Subsubsection:: *)
(*Conditioning Number*)


Print["Conditioning Number"];
r=EigenSol[[2]];
ntotal=Length@r;

l0=EigenSolAdj0[[2]];


Normr0=Table[Sqrt[  Conjugate@r[[i]] . H0 . r[[i]]  ],{i,1,ntotal}];



Norml0=Table[Sqrt[  Conjugate@l0[[i]] . H0 . l0[[i]]],{i,1,ntotal}];


l0r0=Table[l0[[i]] . H0 . r[[i]],{i,1,ntotal}];


\[Kappa]0=Abs[Normr0*Norml0/l0r0];


\[Kappa]0Raw=Table[{Re@EigenSol[[1,i]], Im@EigenSol[[1,i]], \[Kappa]0[[i]]},{i,1,ntotal}];


\[Kappa]0DataComplex=Select[\[Kappa]0Raw, #[[2]] > 0 &];
\[Kappa]0DataReal=Select[\[Kappa]0Raw, #[[2]] == 0 &];


fn="Data/AxialParity/CondNumbQNM0_spin_"<>ToString[spin]<>"_l_"<>ToString[l]<>"_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Export[fn,N[\[Kappa]0DataComplex,Prec],"Table"];
fn="Data/AxialParity/CondNumbBranch0_spin_"<>ToString[spin]<>"_l_"<>ToString[l]<>"_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Export[fn,N[\[Kappa]0DataReal,Prec],"Table"];
Print["Done"];
