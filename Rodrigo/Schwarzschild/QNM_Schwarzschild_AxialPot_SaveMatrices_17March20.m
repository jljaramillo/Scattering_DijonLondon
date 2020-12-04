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

DzHighRes=N[2/\[CapitalDelta]z * Table[dx[i,j,NzHigh], {i,0,NzHigh}, {j,0,NzHigh}],Prec ];


For[i=0, i<=Nz, i++,
Dz[[i+1,i+1]]= -Sum[ Dz[[i+1,j+1]], {j,0,Nz} ];
];

For[i=0, i<=NzHigh, i++,
DzHighRes[[i+1,i+1]]= -Sum[ DzHighRes[[i+1,j+1]], {j,0,NzHigh} ];
];

DzHighResT=Transpose@DzHighRes;

D2z=N[Dz.Dz,Prec];
(*D2zHigh=N[DzHighRes.DzHighRes,Prec];*)


(* ::Subsection:: *)
(*Interpolation Matrix*)


ChebyLobattoInterpolationVector[xl_,Nl_,x\[Alpha]_,Prec]:=Module[
{\[Alpha],l},
Table[
If[l==0,
1/(2Nl)+Sum[(2-KroneckerDelta[j,Nl])ChebyshevT[j,x\[Alpha]]/(2Nl),{j,1,Nl}],
If[l==Nl,
1/(2Nl)+Sum[(2-KroneckerDelta[j,Nl])(-1)^j ChebyshevT[j,x\[Alpha]]/(2Nl),{j,1,Nl}],
1/(Nl)+Sum[(2-KroneckerDelta[j,Nl]) ChebyshevT[j,xl[[l+1]]]ChebyshevT[j,x\[Alpha]]/(Nl),{j,1,Nl}]
]
],
{l,0,Nl}
]

];

ChebyLobattoInterpolationMatrix[xl_,Nl_,x\[Alpha]_,N\[Alpha]_,Prec]:=Module[
{\[Alpha],l},
Table[
If[l==0,
1/(2Nl)+Sum[(2-KroneckerDelta[j,Nl])ChebyshevT[j,x\[Alpha][[\[Alpha]+1]]]/(2Nl),{j,1,Nl}],
If[l==Nl,
1/(2Nl)+Sum[(2-KroneckerDelta[j,Nl])(-1)^j ChebyshevT[j,x\[Alpha][[\[Alpha]+1]]]/(2Nl),{j,1,Nl}],
1/(Nl)+Sum[(2-KroneckerDelta[j,Nl]) ChebyshevT[j,xl[[l+1]]]ChebyshevT[j,x\[Alpha][[\[Alpha]+1]]]/(Nl),{j,1,Nl}]
]
],
{\[Alpha],0,N\[Alpha]},{l,0,Nl}
]

]


ILowToHigh=ChebyLobattoInterpolationMatrix[X,Nz,XX,NzHigh,Prec];
ILowToHighT=Transpose@ILowToHigh;


(* ::Subsection:: *)
(*Integration In Hilbert Space L^2[(-1,1)]*)


ChebyLobattoHilbertIntegration[z_,Nz_,Prec_]:=Module[
{i,j},
Table[
If[i!=j,
0,
If[i==0 || i==Nz,
(1/Nz - Sum[(2-KroneckerDelta[2k,Nz])/(Nz(4k^2-1)),{k,1,Floor[Nz/2]}]),
(2/Nz - 2Sum[(2-KroneckerDelta[2k,Nz])*ChebyshevT[2k,z[[i+1]]]/(Nz(4k^2-1)),{k,1,Floor[Nz/2]}])
]
],
 {i,0,Nz}, {j,0,Nz}
]
]
G=\[CapitalDelta]z/2*ChebyLobattoHilbertIntegration[XX,NzHigh,Prec];
(*h=ILowToHighT.G.ILowToHigh;
hinv=Inverse@h;*)


(* ::Subsection:: *)
(*Generlised eigenvalue problem *)


(* ::Subsubsection:: *)
(*Potential, Metric Factors and differential operators*)


OneHighRes=ConstantArray[1,NzHigh+1];
IdHighRes=IdentityMatrix[NzHigh+1];

\[Alpha]highRes=1+\[Sigma]\[Sigma];
\[Gamma]HighRes=\[Sigma]\[Sigma]^2*(1-\[Sigma]\[Sigma]);
VHighRes=l*(l+1)OneHighRes+(1-spin^2)*\[Sigma]\[Sigma];


One=ConstantArray[1,Nz+1];
V=l*(l+1)*One+(1-spin^2)*\[Sigma];
L2=(\[Sigma]^2*(1-\[Sigma])*D2z + \[Sigma]*(2-3*\[Sigma])*Dz-V*Id)/(1+\[Sigma]);
L1= ( (1-2*\[Sigma]^2)*Dz-2*\[Sigma]*Id )/(1+\[Sigma]);


(* ::Subsubsection:: *)
(*Hilbert Space inner-product Matrices*)


G1=\[Alpha]highRes*G;
G2=VHighRes*G;
G3=DzHighResT.(\[Gamma]HighRes*G).DzHighRes;


H1=ILowToHighT.G1.ILowToHigh;
H2=ILowToHighT.G2.ILowToHigh;
H3=ILowToHighT.G3.ILowToHigh;

AHighRes=G2+G3;
AInvHighRes=Inverse@AHighRes;

A=ILowToHighT.AHighRes.ILowToHigh;
Ainv=Inverse@A;

L2t=Transpose@L2;
L2tInv=Inverse@L2t;

Bi=-L2tInv.A;

BiiInv=-L2.Ainv;
Bii=Inverse@BiiInv;


H0=ArrayFlatten[{
{H2+H3,Zero} , 
{Zero,H1} }];
H0Inv=Inverse@H0;

Hi=ArrayFlatten[{
{A,Zero} , 
{Zero,Bi} }];

HiInv=Inverse@Hi;

Hii=ArrayFlatten[{
{A,Zero} , 
{Zero,Bii} }];

HiiInv=Inverse@Hii;


(* ::Subsubsection:: *)
(*Discrete ODE operators and 'Adjoints'*)


M=ArrayFlatten[{
{Zero,Id} , 
{L2,L1} }];
Mt=Transpose@M;


MAdj0=H0Inv.Mt.H0;

MAdj1=HiInv.Mt.Hi;

MAdj2=HiiInv.Mt.Hii;


(* ::Subsubsection:: *)
(*Export Matrices*)


fn="OperatorMatrix/M_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Export[fn,IntegerPart[10^(Prec+10)*M],"Table"];

fn="OperatorMatrix/MAdj0_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Export[fn,IntegerPart[10^(Prec+10)*MAdj0],"Table"];

fn="OperatorMatrix/MAdj1_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Export[fn,IntegerPart[10^(Prec+10)*MAdj1],"Table"];

fn="OperatorMatrix/MAdj2_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Export[fn,IntegerPart[10^(Prec+10)*MAdj2],"Table"];

fn="OperatorMatrix/H0_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Export[fn,IntegerPart[10^(Prec+10)*H0],"Table"];

fn="OperatorMatrix/Hi_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Export[fn,IntegerPart[10^(Prec+10)*Hi],"Table"];

fn="OperatorMatrix/Hii_N_"<>ToString[Nz]<>"_Prec_"<>ToString[Floor[Prec]]<>".dat"
Export[fn,IntegerPart[10^(Prec+10)*Hii],"Table"];










