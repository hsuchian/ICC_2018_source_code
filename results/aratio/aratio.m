
% initialization
clear 
clc

test_round = 1;

mp = 54;
Npg = 100;
Nrd = 100;
p = 0.75;

R_M = 0;       % paging ratio
R_N = 0;       % paging ratio

C_total = [];
M_total = [];
N_total = [];

A_C_total = [];
A_M_total = [];
A_N_total = [];


SuccessProb_C_rd = [];
SuccessProb_C_pg = [];
SuccessProb_M_rd = [];
SuccessProb_M_pg = [];
SuccessProb_N_rd = [];
SuccessProb_N_pg = [];

A_SuccessProb_C_rd = [];
A_SuccessProb_C_pg = [];
A_SuccessProb_M_rd = [];
A_SuccessProb_M_pg = [];
A_SuccessProb_N_rd = [];
A_SuccessProb_N_pg = [];


%{
[C_prob_rd, C_prob_pg] = CovenSuccessProb(Npg, Nrd, mp ,p);

C_prob_rd_analytic = (1 - (1/mp))^(Nrd-1) * (1 - (p/mp))^(Npg);
C_prob_pg_analytic = p * (1 - (1/mp))^Nrd * (1 - (p/mp))^(Npg-1);

calculate paging ratio
if mp > Nrd+1,
   R_N = mp*(1 - ((1-(p/mp))^(Npg)) )/(Npg*p);
else
   R_N = (1-(p/mp))^(Npg-1);
end


[N_prob_rd, N_prob_pg] = NewSuccessProb(Npg, Nrd, mp ,p);

N_prob_rd_analytic = (1 - (1/mp))^(Nrd-1) * (1 - R*Npg*p / mp );
N_prob_pg_analytic = R * p * (1 - (1/mp))^Nrd;



[M_prob_rd, M_prob_pg] = MidSuccessProb(Npg, Nrd, mp ,p);

 R_M =  (  mp - (    1 / ( 1-  ( 1 - (1/mp))^( 1+  Npg/(Nrd-1) ) ) )     )   /  Npg;
        
 if R_M > 1
        R_M = 1;
 elseif R_M < 0
      R_M = 0;
 end

M_prob_rd_analytic = (1- 1/(mp-Npg*R_M))^(Nrd-1);
M_prob_pg_analytic = R_M;
%}


%------------------------------------------------------------------------------------------------------

for P_prob  = 0.1:0.1:1,
   
       [C_prob_rd, C_prob_pg, ctotal] = CovenSuccessProb(Npg, Nrd, mp, P_prob);
       [N_prob_rd, N_prob_pg, ntotal] = NewSuccessProb(Npg, Nrd, mp, P_prob);
       [M_prob_rd, M_prob_pg, mtotal] = MidSuccessProb(Npg, Nrd, mp, P_prob);
       
       
       C_total = [C_total, ctotal];
       M_total = [M_total, mtotal];
       N_total = [N_total, ntotal];
       SuccessProb_C_rd = [SuccessProb_C_rd, C_prob_rd];
       SuccessProb_C_pg = [SuccessProb_C_pg, C_prob_pg];
       SuccessProb_M_rd = [SuccessProb_M_rd, M_prob_rd];
       SuccessProb_M_pg = [SuccessProb_M_pg, M_prob_pg];
       SuccessProb_N_rd = [SuccessProb_N_rd, N_prob_rd];
       SuccessProb_N_pg = [SuccessProb_N_pg, N_prob_pg];
       
        %------------------------------------------Calculate paging ratio------------------------------------------------
    
       if mp > Nrd+1,
          R_N = mp*(1 - ((1-(P_prob/mp))^(Npg)) )/(Npg*P_prob);
       else
          R_N = (1-(P_prob/mp))^(Npg-1);
       end
    
       if R_N > 1
          R_N = 1;
       elseif R_N < 0
          R_N = 0;
       end
        
       R_M =  (  mp - (    1 / ( 1-  ( 1 - (1/mp))^( 1+  Npg/(Nrd-1) ) ) )     )   /  Npg;
        
       if R_M > 1
          R_M = 1;
       elseif R_M < 0
          R_M = 0;
       end
       
       
       if R_N * Npg > mp
            R_N = mp/Npg;
       end
        
       if R_M * Npg > mp
            R_M = mp/Npg;
       end
       %------------------------------------------Calculate paging ratio------------------------------------------------
    
       C_prob_rd_analytic = (1 - (1/mp))^(Nrd-1) * (1 - (P_prob/mp))^(Npg);
       C_prob_pg_analytic = P_prob * (1 - (1/mp))^Nrd * (1 - (P_prob/mp))^(Npg-1);
    
       N_prob_rd_analytic = (1 - (1/mp))^(Nrd-1) * (1 - R_N*Npg*P_prob / mp );
       N_prob_pg_analytic = R_N * P_prob * (1 - (1/mp))^Nrd;
    
       if mp-Npg*R_M == 0
            M_prob_rd_analytic = 0;
       else
            M_prob_rd_analytic = (1- 1/(mp-Npg*R_M))^(Nrd-1);
       end
       M_prob_pg_analytic = R_M*P_prob;
       
       
       A_SuccessProb_C_rd = [A_SuccessProb_C_rd, C_prob_rd_analytic];
       A_SuccessProb_C_pg = [A_SuccessProb_C_pg, C_prob_pg_analytic];
       A_SuccessProb_M_rd = [A_SuccessProb_M_rd, M_prob_rd_analytic];
       A_SuccessProb_M_pg = [A_SuccessProb_M_pg, M_prob_pg_analytic];
       A_SuccessProb_N_rd = [A_SuccessProb_N_rd, N_prob_rd_analytic];
       A_SuccessProb_N_pg = [A_SuccessProb_N_pg, N_prob_pg_analytic];
       A_C_total = [A_C_total, C_prob_rd_analytic*Nrd + C_prob_pg_analytic*Npg];
       A_M_total = [A_M_total, M_prob_rd_analytic*Nrd + M_prob_pg_analytic*Npg];
       A_N_total = [A_N_total, N_prob_rd_analytic*Nrd + N_prob_pg_analytic*Npg];

    
    %{
    %------------------------------------------Calculate paging ratio------------------------------------------------
    
    if mp > Nrd+1,
       R_N = mp*(1 - ((1-(p/mp))^(Npg)) )/(Npg*p);
    else
       R_N = (1-(p/mp))^(Npg-1);
    end
    
    if R_N > 1
        R_N = 1;
    elseif R_N < 0
        R_N = 0;
    end
    
    R_M =  (  mp - (    1 / ( 1-  ( 1 - (1/mp))^( 1+  Npg/(Nrd-1) ) ) )     )   /  Npg;
        
    if R_M > 1
        R_M = 1;
    elseif R_M < 0
      R_M = 0;
    end
    %------------------------------------------Calculate paging ratio------------------------------------------------
    
    C_prob_rd_analytic = (1 - (1/mp))^(Nrd-1) * (1 - (p/mp))^(Npg);
    C_prob_pg_analytic = p * (1 - (1/mp))^Nrd * (1 - (p/mp))^(Npg-1);
    
    N_prob_rd_analytic = (1 - (1/mp))^(Nrd-1) * (1 - R*Npg*p / mp );
    N_prob_pg_analytic = R * p * (1 - (1/mp))^Nrd;
    
    M_prob_rd_analytic = (1- 1/(mp-Npg*R_M))^(Nrd-1);
    M_prob_pg_analytic = R_M;
    %}
end 

