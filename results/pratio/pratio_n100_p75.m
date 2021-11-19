% initialization
clear 
clc

test_round = 100;

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


for Paging_ratio_plug  = 0:0.05:1,
   
       [C_prob_rd, C_prob_pg, ctotal] = CovenSuccessProb2(Npg, Nrd, mp, p, Paging_ratio_plug);
       [N_prob_rd, N_prob_pg, ntotal] = NewSuccessProb2(Npg, Nrd, mp, p, Paging_ratio_plug);
       [M_prob_rd, M_prob_pg, mtotal] = MidSuccessProb2(Npg, Nrd, mp, p, Paging_ratio_plug);
       
       
       C_total = [C_total, ctotal];
       M_total = [M_total, mtotal];
       N_total = [N_total, ntotal];
       SuccessProb_C_rd = [SuccessProb_C_rd, C_prob_rd];
       SuccessProb_C_pg = [SuccessProb_C_pg, C_prob_pg];
       SuccessProb_M_rd = [SuccessProb_M_rd, M_prob_rd];
       SuccessProb_M_pg = [SuccessProb_M_pg, M_prob_pg];
       SuccessProb_N_rd = [SuccessProb_N_rd, N_prob_rd];
       SuccessProb_N_pg = [SuccessProb_N_pg, N_prob_pg];
       
       %{
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
       %}
       %------------------------------------------Calculate paging ratio------------------------------------------------
       
       if Paging_ratio_plug * Npg > mp
            Paging_ratio_plug = mp/Npg;
        end
    
       C_prob_rd_analytic = (1 - (1/mp))^(Nrd-1) * (1 - (p/mp))^(Npg);
       C_prob_pg_analytic = p * (1 - (1/mp))^Nrd * (1 - (p/mp))^(Npg-1);
    
       N_prob_rd_analytic = (1 - (1/mp))^(Nrd-1) * (1 - Paging_ratio_plug*Npg*p / mp );
       N_prob_pg_analytic = Paging_ratio_plug * p * (1 - (1/mp))^Nrd;
    
       
       if mp-Npg*Paging_ratio_plug == 0
           M_prob_rd_analytic = 0;
       else
           M_prob_rd_analytic = (1- 1/(mp-Npg*Paging_ratio_plug))^(Nrd-1);
       end
       M_prob_pg_analytic = Paging_ratio_plug*p;
       
       
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

a = (1- (1/mp))^(Npg+Nrd-1);
b = (  mp - (    1 / ( 1-  ( 1 - (1/mp))^( 1+  Npg/(Nrd-1) ) ) )     )   /  Npg;
   % ( mp -  (    1 / (1 -  ( 1 - (1/mp))^( 1+  Npg/(Nrd-1) ) ) )      ) / Npg;


%{
figure1 = figure(1);

h = plot(0:0.05:1, A_SuccessProb_C_rd, 'b', 0:0.05:1, SuccessProb_C_rd, 'b*', 0:0.05:1, A_SuccessProb_C_pg, 'g', 0:0.05:1, SuccessProb_C_pg, 'g*', 0:0.05:1, A_SuccessProb_M_rd, 'r', 0:0.05:1, SuccessProb_M_rd, 'r*', 0:0.05:1, A_SuccessProb_M_pg, 'c', 0.:0.05:1, SuccessProb_M_pg, 'c*',  0:0.05:1, A_SuccessProb_N_rd, 'k--',  0.:0.05:1, SuccessProb_N_rd, 'k*', 0:0.05:1, A_SuccessProb_N_pg, 'y',  0:0.05:1, SuccessProb_N_pg, 'y*');
%h = plot(0.1:0.1:1, A_SuccessProb_C_rd, 'b', 0.1:0.1:1, A_SuccessProb_C_pg, 'b', 0.1:0.1:1, SuccessProb_C_rd, 'b*', 0.1:0.1:1, SuccessProb_C_pg, 'b+');

%set( h , 'linewidth' , 1.2 );
h1 = legend('Theoretical Spec_{rd}', 'Simulation Spec_{rd}', 'Theoretical Spec_{pg}', 'Simulation Spec_{pg}', 'Theoretical YiNing_{rd}', 'Simulation YiNing_{rd}', 'Theoretical YiNing_{pg}', 'Simulation YiNing_{pg}', 'Theoretical New_{rd}', 'Simulation New_{rd}', 'Theoretical New_{pg}', 'Simulation New_{pg}');
xlabel(' Probability of paging UE (N_{pg} = N_{rd} = 100, m_p = 54)');  
ylabel('Success Probbability');  

set(figure1, 'PaperUnits', 'inches');
set(figure1, 'PaperPosition', [0 0 10 8]);
set(figure1, 'Units', 'inches');
set(figure1, 'Position', [0 0 10 8]);


print(figure1, '-depsc', 'P_prob_succes.eps');
%}
save('pratio_75.mat','A_C_total', 'A_M_total', 'A_N_total');
