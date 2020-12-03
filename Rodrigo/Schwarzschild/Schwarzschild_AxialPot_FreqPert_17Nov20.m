(* ::Package:: *)

(* ::Title:: *)
(*QNM Schwarzschild Potential*)


(* ::Section:: *)
(*Quasi-normal Modes and quasi-normal functions and excitation factor*)


(* ::Subsection:: *)
(*Numerical parameters*)


Clear["Global`*"]
SetDirectory[NotebookDirectory[]];
Prec=500;
z0=0;
z1=1;
\[CapitalDelta]z=z1-z0;

Nz=500;
nz=Nz+1

spin=-2;
l=2;
x[i_,Nz_]:=Cos[(\[Pi] i)/Nz];
z=N[Table[z0+1/2 \[CapitalDelta]z (1+x[i,Nz]),{i,0,Nz}],Prec];
(*\[Sigma]=z;*)


(* ::Subsection:: *)
(*Spectral Routines*)


ChebGaussCoefficients[f_, Prec_]:=Module[
{nf, Nf,c,x},
nf=Length@f;
Nf=nf-1;


x[j_]:=N[ Cos[Pi*(j+1/2)/(Nf+1)] ,Prec];

c=Table[  2 Sum[f[[j+1]]*ChebyshevT[m,x[j]],{j,0,Nf}]  /nf        ,{m,0,Nf}]
];

ChebInterpolation[c_,a_,b_,x_]:=Module[
{nc, Nc},
nc=Length@c;
Nc=nc-1;

y=(2 x-(a+b))/(b-a);

c[[1]]/2+Sum[c[[i+1]]*ChebyshevT[i,y],{i,1,Nc}]
];

ChebLobattoCoefficients[f_, Prec_]:=Module[
{nf, Nf,c,x},
nf=Length@f;
Nf=nf-1;

x[j_]:=N[Cos[j \[Pi]/Nf],Prec];

c=Table[  ( 2-KroneckerDelta[m,Nf]) /(2Nf) (  f[[1]]+(-1)^m f[[nf]] + 2 Sum[f[[j+1]]*ChebyshevT[m,x[j]],{j,1,Nf-1}]  )        ,{m,0,Nf}]
];

DefiniteIntegral[c_,a_,b_]:=Module[
{kf,nc,Nc, Int},
nc=Length@c;
Nc=nc-1;
kf=Floor[Nc/2];
Int=c[[1]]- 2Sum[c[[2 k +1]]/(4 k ^2 -1),{k,1,kf}];
(b-a)*Int/2
];


(* ::Subsection:: *)
(*Spectral Differentiation matrices*)


Id=IdentityMatrix[Nz+1];
Zero=ConstantArray[0,{Nz+1,Nz+1}];

k[i_,Nz_]:=If[i*(i-Nz)==0, 2,1];



dx[i_,j_,Nz_]:=If[i!=j,
k[i,Nz]*(-1)^(i-j)/(k[j,Nz]*(x[i,Nz]-x[j,Nz])),
0
];
Dz=N[2/\[CapitalDelta]z * Table[dx[i,j,Nz], {i,0,Nz}, {j,0,Nz}],Prec ];

For[i=0, i<=Nz, i++,
Dz[[i+1,i+1]]= -Sum[ Dz[[i+1,j+1]], {j,0,Nz} ];
];


D2z=N[Dz.Dz,Prec];


(* ::Subsection:: *)
(*Generlised eigenvalue problem *)


(* ::Subsubsection:: *)
(*Potential*)


\[Epsilon]=10^(-3);
kk=30;
\[Omega]=2*\[Pi]*kk;

Vpert=N[Sin[\[Omega]*z],Prec];
One=ConstantArray[1,Nz+1];
V=l*(l+1)*One+(1-spin^2)*z;

cVpert=ChebLobattoCoefficients[Vpert, Prec];
ListLogPlot[Abs@cVpert]


(* ::Subsubsection:: *)
(*Discrete ODE operator*)


L1=(z^2*(1-z)*D2z + z*(2-3*z)*Dz-(V+\[Epsilon]*Vpert)*Id)/(1+z);
L2= ((1-2*z^2)*Dz-2*z*Id )/(1+z);
 
M=ArrayFlatten[{

{Zero,Id} , 
{L1,L2} }];


(* ::Subsubsection:: *)
(*Eigenvalue Problem*)


Print["Calculating QNM"];

EigenSol=Eigensystem[N[M,Prec]];


PosQNM=Position[EigenSol[[1]],x_/;Im@x!=0]//Flatten;
nQNM=Length@PosQNM
EigenSolQNM=Table[EigenSol[[j,PosQNM[[i]]]],{j,1,Length@EigenSol},{i,1,nQNM}];

PosBranch=Position[EigenSol[[1]],x_/;Im@x==0]//Flatten;
nBranch=Length@PosBranch
EigenSolBranchCut=Table[EigenSol[[j,PosBranch[[i]]]],{j,1,Length@EigenSol},{i,1,nBranch}];


SpectrumData=Table[{Re@EigenSolQNM[[1,iqnm]],Im@EigenSolQNM[[1,iqnm]]},{iqnm,1,Length@EigenSolQNM[[1]]}];

BranchCutData=Table[{Re@EigenSolBranchCut[[1,iqnm]],Im@EigenSolBranchCut[[1,iqnm]]},{iqnm,1,Length@EigenSolBranchCut[[1]]}];

fn="Data/AxialPot/Spectra_N_"<>ToString[Nz]<>"_spin"<>ToString[spin]<>"_l"<>ToString[l]<>"_Freq_eps_"<>ToString[N[\[Epsilon]]]<>"_ksig_"<>ToString[kk]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat";
Export[fn,N[SpectrumData,Prec],"Table"];

fn="Data/AxialPot/BranchSpectra_N_"<>ToString[Nz]<>"_spin"<>ToString[spin]<>"_l"<>ToString[l]<>"_Freq_eps_"<>ToString[N[\[Epsilon]]]<>"_ksig_"<>ToString[kk]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat";
Export[fn,N[BranchCutData,Prec],"Table"];

(*ListPlot[{SpectrumData,BranchCutData}]*)


(* ::Subsubsection:: *)
(*QNM Set*)


QNMUnit[i_]:=Join[{Reverse[EigenSolQNM[[1]]][[i]]},Reverse[EigenSolQNM[[2]]][[i]]];
QNMSetRaw=  Table[QNMUnit[i],{i,1,nQNM}];
QNMSet=SortBy[QNMSetRaw,Abs@Re[#] &];



(* ::Subsubsection:: *)
(*Choose QNM*)


ntotal=19;
s=Table[QNMSet[[n+1,1]],{n,0,ntotal}];
\[Phi]=Table[QNMSet[[n+1,1+j]],{n,0,ntotal},{j,1,nz}];
\[Psi]=Table[QNMSet[[n+1,1+nz+j]],{n,0,ntotal},{j,1,nz}];

An=Table[A[s[[n+1]]],{n,0,ntotal}];
Cn=Table[c[s[[n+1]]].\[Phi][[n+1]],{n,0,ntotal}];



sData=Table[{Re@s[[n+1]],Im@s[[n+1]]},{n,0,ntotal}];
fn="Data/AxialPot/QNM_N_"<>ToString[Nz]<>"_spin"<>ToString[spin]<>"_l"<>ToString[l]<>"_Freq_eps_"<>ToString[N[\[Epsilon]]]<>"_ksig_"<>ToString[kk]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat";
Export[fn,N[sData,30],"Table"];

fn=Table["Data/AxialPot/QNMSet"<>ToString[n]<>"_N_"<>ToString[Nz]<>"_spin"<>ToString[spin]<>"_l"<>ToString[l]<>"_Freq_eps_"<>ToString[N[\[Epsilon]]]<>"_ksig_"<>ToString[kk]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat",{n,0,ntotal}];
For[n=0, n<=ntotal, n++,
QNMSetData=Table[{Re@QNMSet[[n+1,i]],Im@QNMSet[[n+1,i]]},{i,1,Length@QNMSet[[n+1]]}];
Export[fn[[n+1]],N[QNMSetData,30],"Table"];
]
