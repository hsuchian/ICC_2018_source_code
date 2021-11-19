
%Yining r(x,y)

x = (  mp - (    1 / ( 1-  ( 1 - (1/mp))^( 1+  Npg/(Nrd-1) ) ) )     )   /  Npg;
y = (1- 1/(mp-Npg*x))^(Nrd-1) * Nrd    +     x * P_prob * Npg


% my r(x,y)

x1 = (1-(p/mp))^(Npg-1);

y1 = (1 - (1/mp))^(Nrd-1) * (1 - (1-(p/mp))^(Npg-1)*Npg*p / mp ) * Nrd    +    (1-(p/mp))^(Npg-1) * p * (1 - (1/mp))^Nrd * Npg