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

Nz=400;
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


fn="OperatorMatrix/M_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
MnoPert=N[Import[fn,"Table"]/10^(Prec+10),Prec];

fn="OperatorMatrix/H0_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
H0=N[Import[fn,"Table"]/10^(Prec+10),Prec];
H0Inv=Inverse@H0;


(* ::Subsubsection:: *)
(*Frequency Perturbation*)


(* ::Input::Initialization:: *)
kk=60;
\[Omega]=2*\[Pi]*kk;
Vpert=N[Cos[\[Omega]*z],Prec];


(* ::Subsubsection:: *)
(*Function for Random Perturbation*)


(* ::Input::Initialization:: *)
FuncName="NoFunc";
Func[\[Sigma]_]:=1;(*Exp[-1/(\[Sigma]^2)];*)
FuncVec=Limit[Func[aa], aa->\[Sigma], Direction->"FromAbove"];


Id=IdentityMatrix[Nz+1];
Zero=ConstantArray[0,{Nz+1,Nz+1}];
\[Delta]M=ArrayFlatten[{
{Zero,Zero} , 
{FuncVec*Vpert*Id/(1+\[Sigma]),Zero} }];

\[Delta]Mt=Transpose@\[Delta]M;
\[Delta]MAdj=H0Inv.\[Delta]Mt.H0;
Norm\[Delta]M=Sqrt[Eigenvalues[\[Delta]MAdj.\[Delta]M,1][[1]]]


(* ::Input::Initialization:: *)
\[Epsilon]=10^(-8);
M=MnoPert+\[Delta]M*\[Epsilon]/Norm\[Delta]M;


(* ::Subsubsection:: *)
(*Eigenvalue problem*)


Print["Calculating QNM"];
EigenSol=Eigenvalues[M];

SpectrumData=Table[{Re@EigenSol[[iqnm]],Im@EigenSol[[iqnm]]},{iqnm,1,Length@EigenSol}];
fn="Data/Spectra_spin_"<>ToString[spin]<>"_l_"<>ToString[l]<>"_"<>FuncName<>"FreqPert_eps_"<>ToString[AccountingForm@N[\[Epsilon]]]<>"_ksig_"<>ToString[N[kk]]<>"_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Export[fn,N[SpectrumData,Prec],"Table"];
Print["Done"];
