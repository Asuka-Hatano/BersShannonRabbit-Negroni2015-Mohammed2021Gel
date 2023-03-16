function F=isometric(x,TCatilde, TCastar, Tstar, X_w, X_p)
% Negroni Parameters
alpha_neg=0.5; %[kPa]
beta_neg=80; %[/um]
Ke=105000; %[kPa/um^5]
Le=10;
L0=0.97;
Lm=1.05;
Ap=1008e+04; %[kPa/um/mM]
Aw=Ap/5;  %[kPa/um/mM]

%x
%alpha_neg*(exp(beta_neg*(Lm-x))-1)
%Ke*(x-L0)^5+Le*(x-L0)+Fb
F=alpha_neg*(exp(beta_neg*(Lm-x))-1)-Ke*(x-L0)^5-Le*(x-L0)-Aw*TCatilde*(x-X_w)- Ap*(TCastar+Tstar)*(x-X_p);