% Eigenvalues of the Laplace Transform from Wave Equation on Minkowsky with
% Hyperboloidal slices
%         U_tt + 2x U_tx + U_t + 2xU_x - (1-x^2)U_xx +P*U = 0
%  with V = U_t
%  Rodrigo P. Macedo - 28/09/18

function lbda_cplx=LaplaceWaveMink_HyperZeLuis(N)

%Chebyschev Diff. Matrix from Trefethen
[D,x]=cheb(N);

%Chebyschev Second Derivatives Matrix
D2=D^2;

%Potential
P=1;

%Declaring Identity and Zero Matrix  
Id=eye(N+1);
Zero=zeros(N+1); 

%Create matrices
L2_noDerv = P;
L2_x = 2*x;
L2_xx = -(1-x.*x);

L2 = L2_xx.*D2 + L2_x.*D + L2_noDerv.*Id


L1_noDerv = -1i;
L1_x = -2i*x;
L1 = L1_x.*D + L1_noDerv.*Id;


%Laplace Matrix
M=[[Zero, Id ]; [L2, L1] ];

%Find EigenValue
lbda = eig(M);


%Get the Complex EigenVector with positive imaginary part
lbda_cplx = [];
for(i=1:2*(N+1))
   %if (isreal(lbda(i)) ==0 )
     %  if(real(lbda(i))<0)
           lbda_cplx=[lbda_cplx; lbda(i)];
     %  end
   %end
end
lbda_cplx=sort(lbda_cplx);


