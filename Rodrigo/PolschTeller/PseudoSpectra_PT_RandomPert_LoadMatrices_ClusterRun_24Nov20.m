(* ::Package:: *)

(* ::Title:: *)
(*Pseudo-Spectra Polsch-Teller Potential*)


(* ::Section:: *)
(*Quasi-normal Modes and quasi-normal functions*)


(* ::Subsection:: *)
(*Numerical parameters*)


Clear["Global`*"]

SetDirectory[NotebookDirectory[]];
Prec=10 MachinePrecision;
z0=-1;
z1=1;
\[CapitalDelta]z=z1-z0;
InputParFile=ToString[$CommandLine[[Length@$CommandLine]]];
InputFile=StringDelete[InputParFile,"Parameters/"];

Print[InputParFile];
Print[InputFile];

Get[InputParFile];

Nz=100;

Print[Nz];
Print[s];

NzHigh=2 Nz;
x[i_,Nz_]:=Cos[(\[Pi] i)/Nz];
z=N[Table[z0+1/2 \[CapitalDelta]z (1+x[i,Nz]),{i,0,Nz}],Prec];
zz=N[Table[z0+1/2 \[CapitalDelta]z (1+x[i,NzHigh]),{i,0,NzHigh}],Prec];


(* ::Subsubsection:: *)
(*Load Integration Matrices*)


fn="OperatorMatrix/H_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
H=N[Import[fn,"Table"]/10^(Prec+10),Prec];

fn="OperatorMatrix/Hinv_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Hinv=N[Import[fn,"Table"]/10^(Prec+10),Prec];


(* ::Subsection:: *)
(*Generlised eigenvalue problem *)


(* ::Subsubsection:: *)
(*Random Perturbation Parameter*)


\[Epsilon]=10^(-16);


(* ::Subsubsection:: *)
(*Load ODE operator*)


fn="OperatorMatrix/M_RandomPert_eps_"<>ToString[AccountingForm@N[\[Epsilon]]]<>"_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
M=N[Import[fn,"Table"]/10^(Prec+10),Prec];

fn="OperatorMatrix/MAdj_RandomPert_eps_"<>ToString[AccountingForm@N[\[Epsilon]]]<>"_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
MAdj=N[Import[fn,"Table"]/10^(Prec+10),Prec];


(* ::Subsubsection:: *)
(*Pseudo-Spectrum*)


dblId=IdentityMatrix[2*(Nz+1)];
A=M - s*dblId;
At=Conjugate@Transpose@A;
Adj=Hinv.At.H;

AtA=At.A;
AdjA=Adj.A;




Print["Calculating Pseudo Spectra Energy Norm"];
PseudoSpectraAdjA=Eigenvalues[AdjA,-1];
PseudoSpectraAdjAData={N@Re@s,N@Im@s,N[Abs@PseudoSpectraAdjA,Prec]};
fn="Data/PseudoSpectra_RandomPert_eps_"<>ToString[AccountingForm@N[\[Epsilon]]]<>"_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>InputFile<>"_GnuPlot.dat"
Export[fn,PseudoSpectraAdjAData];
Print["Done"];




