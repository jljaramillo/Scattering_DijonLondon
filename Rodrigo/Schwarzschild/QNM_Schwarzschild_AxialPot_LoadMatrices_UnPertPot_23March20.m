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

Nz=500;
nz=Nz+1;
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


fn="OperatorMatrix/AxialParity/M_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
MnoPert=N[Import[fn,"Table"]/10^(Prec+10),Prec];

fn="OperatorMatrix/AxialParity/H0_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
H0=N[Import[fn,"Table"]/10^(Prec+10),Prec];
(*H0Inv=Inverse@H0;*)


(* ::Subsubsection:: *)
(*Frequency Perturbation*)


(* ::Input::Initialization:: *)
kk=0;
Print[kk];
\[Omega]=2*\[Pi]*kk;
Vpert=N[Cos[\[Omega]*z],Prec];


(* ::Subsubsection:: *)
(*Function for Random Perturbation*)


(* ::Input::Initialization:: *)
FuncName="Cos";
Func[\[Sigma]_]:=1;(*Exp[-1/(\[Sigma]^2)];*)
FuncVec=Limit[Func[aa], aa->\[Sigma], Direction->"FromAbove"];


Id=IdentityMatrix[Nz+1];
Zero=ConstantArray[0,{Nz+1,Nz+1}];
\[Delta]M=ArrayFlatten[{
{Zero,Zero} , 
{FuncVec*Vpert*Id/(1+\[Sigma]),Zero} }];




(* ::Input::Initialization:: *)
\[Epsilon]=0;
Print[\[Epsilon]];
M=MnoPert; (*+\[Delta]M*\[Epsilon]/Norm\[Delta]M*);


(* ::Subsubsection:: *)
(*Eigenvalue Problem*)


Print["Calculating QNM"];
EigenSol=Eigensystem[N[M,Prec]];
Print["Done"];

PosQNM=Position[EigenSol[[1]],x_/;Im@x!=0]//Flatten;
nQNM=Length@PosQNM
EigenSolQNM=Table[EigenSol[[j,PosQNM[[i]]]],{j,1,Length@EigenSol},{i,1,nQNM}];

PosBranch=Position[EigenSol[[1]],x_/;Im@x==0]//Flatten;
nBranch=Length@PosBranch
EigenSolBranchCut=Table[EigenSol[[j,PosBranch[[i]]]],{j,1,Length@EigenSol},{i,1,nBranch}];


SpectrumData=Table[{Re@EigenSolQNM[[1,iqnm]],Im@EigenSolQNM[[1,iqnm]]},{iqnm,1,Length@EigenSolQNM[[1]]}];

BranchCutData=Table[{Re@EigenSolBranchCut[[1,iqnm]],Im@EigenSolBranchCut[[1,iqnm]]},{iqnm,1,Length@EigenSolBranchCut[[1]]}];

Print["Export Data"];
fn="Data/AxialParity/Spectra"<>FuncName<>"_N_"<>ToString[Nz]<>"_spin"<>ToString[spin]<>"_l"<>ToString[l]<>"_Freq_eps_"<>ToString[N[\[Epsilon]]]<>"_ksig_"<>ToString[kk]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Export[fn,N[SpectrumData,Prec],"Table"];

fn="Data/AxialParity/BranchSpectra"<>FuncName<>"_N_"<>ToString[Nz]<>"_spin"<>ToString[spin]<>"_l"<>ToString[l]<>"_Freq_eps_"<>ToString[N[\[Epsilon]]]<>"_ksig_"<>ToString[kk]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat";
Export[fn,N[BranchCutData,Prec],"Table"];
Print["Done"];



