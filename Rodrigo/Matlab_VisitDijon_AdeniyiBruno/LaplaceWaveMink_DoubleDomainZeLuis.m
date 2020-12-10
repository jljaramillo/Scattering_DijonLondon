% Eigenvalues of the Laplace Transform from Wave Equation on Minkowsky with
% Double domain:
% Domain I: Field: U, coordinate: 0 <= sigma <= 1 
%  -(1-sigma^2)U_sigmasigma + 2 sigma U_sigma + P U = - 2 s U_sigma   [if sigma !=0 ]
%  U = V [if sigma = 0]     
%
% Domain II: Field: V, coordinate: -1 <= rho <= 0
%  -(1-rho^2)U_rhorho + 2 rho U_rho + P U =  2 s U_rho   [if rho !=0 ]
%  U_sigma - V_rho =  s (U + V) [if sigma = 0] 
%  
%  Rodrigo P. Macedo - 28/09/18

function lbda_cplx=LaplaceWaveMink_DoubleDomainZeLuis(N)

%Chebyschev Diff. Matrix from Trefethen
n=N+1;
[D,x]=cheb(N);

%Declaring Identity and Zero Matrix  
Id=eye(n);
Zero=zeros(n);

%Map Chebyshev grid into Domain I coordinates
sigma = 0.5*(x+1);
D_sigma = 2*D;
D_sigmasigma = D_sigma*D_sigma;

%Map Chebyshev grid into Domain II coordinates
rho = 0.5*(x-1);
D_rho = 2*D;
D_rhorho = D_rho*D_rho;

%Potential
P=1;

 

%%%%%%%%%%%%%%%%%%%%% Create Operators Domain I %%%%%%%%%%%%%%%%%%%%%%%%%
A_I = -(1-sigma.*sigma).*D_sigmasigma + 2*sigma.*D_sigma + P.*Id;
A_I_II = Zero;

B_I = -2*D_sigma;
B_I_II = Zero;

%Manipulate lines to include boundary conditions at sigma=rho=0
% Domain I corresponds to i = N
% Domain II correponds to i = 0
A_I(n,:)=0;   %(n,:) means the line (n) of A and ALL the columns (:)
A_I(n,n)=1;

A_I_II(n,1) = -1;

B_I(n,:)=0;

%%%%%%%%%%%%%%%%%%%%% Create Operators Domain II %%%%%%%%%%%%%%%%%%%%%%%%%
A_II = -(1-rho.*rho).*D_rhorho + 2*rho.*D_rho + P.*Id;
A_II_I = Zero;

B_II= 2*D_rho;
B_II_I = Zero;

%Manipulate lines to include boundary conditions at sigma=rho=0
% Domain I corresponds to i = N
% Domain II correponds to i = 0
A_II(1,:)= -D_rho(1,:);
A_II_I(1,:)=D_sigma(n,:);

B_II(1,:)=0;
B_II(1,1)=1;
B_II_I(1,n)=1;



%Laplace Matrix l.h.s
A=[[A_I, A_I_II ]; [A_II_I, A_II] ];

%Laplace Matrix r.h.s
B=[[B_I, B_I_II ]; [B_II_I, B_II] ];



%Find EigenValue
lbda = eig(A,B);

%Get the Complex EigenVector with postitve imaginary part
lbda_cplx = [];
for(i=1:2*(N+1))
   if (isreal(lbda(i)) ==0 )
       if(imag(lbda(i))>0)
           lbda_cplx=[lbda_cplx; lbda(i)];
       end
   end
end
lbda_cplx=sort(lbda_cplx);


