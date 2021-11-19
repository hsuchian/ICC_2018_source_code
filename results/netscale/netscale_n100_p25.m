% initialization
clear 
clc

test_round = 1;

mp = 54;
Npg = 100;
Nrd = 100;
p = 0.25;

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


%-----------------------------------Npg------------------------------------------------------------------------------------

%Initialize
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

for NPG  = 100:100:500,
   
       [C_prob_rd, C_prob_pg, ctotal] = CovenSuccessProb(NPG, Nrd, mp, p);
       [N_prob_rd, N_prob_pg, ntotal] = NewSuccessProb(NPG, Nrd, mp, p);
       [M_prob_rd, M_prob_pg, mtotal] = MidSuccessProb(NPG, Nrd, mp, p);
       
       
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
          R_N = mp*(1 - ((1-(p/mp))^(NPG)) )/(NPG*p);
       else
          R_N = (1-(p/mp))^(NPG-1);
       end
    
       if R_N > 1
          R_N = 1;
       elseif R_N < 0
          R_N = 0;
       end
       
       
       R_M =  (  mp - (    1 / ( 1-  ( 1 - (1/mp))^( 1+  NPG/(Nrd-1) ) ) )     )   /  NPG;
        
       if R_M > 1
          R_M = 1;
       elseif R_M < 0
          R_M = 0;
       end
       
       
       if R_N * NPG > mp
            R_N = mp/NPG;
       end
        
       if R_M * NPG > mp
            R_M = mp/NPG;
       end
       %------------------------------------------Calculate paging ratio------------------------------------------------
    
       C_prob_rd_analytic = (1 - (1/mp))^(Nrd-1) * (1 - (p/mp))^(NPG);
       C_prob_pg_analytic = p * (1 - (1/mp))^Nrd * (1 - (p/mp))^(NPG-1);
    
       N_prob_rd_analytic = (1 - (1/mp))^(Nrd-1) * (1 - R_N*NPG*p / mp );
       N_prob_pg_analytic = R_N * p * (1 - (1/mp))^Nrd;
    
       if mp-NPG*R_M == 0
            M_prob_rd_analytic = 0;    
       else
           M_prob_rd_analytic = (1- 1/(mp-NPG*R_M))^(Nrd-1);
       end
       
       M_prob_pg_analytic = R_M*p;
       
       
       A_SuccessProb_C_rd = [A_SuccessProb_C_rd, C_prob_rd_analytic];
       A_SuccessProb_C_pg = [A_SuccessProb_C_pg, C_prob_pg_analytic];
       A_SuccessProb_M_rd = [A_SuccessProb_M_rd, M_prob_rd_analytic];
       A_SuccessProb_M_pg = [A_SuccessProb_M_pg, M_prob_pg_analytic];
       A_SuccessProb_N_rd = [A_SuccessProb_N_rd, N_prob_rd_analytic];
       A_SuccessProb_N_pg = [A_SuccessProb_N_pg, N_prob_pg_analytic];
       A_C_total = [A_C_total, C_prob_rd_analytic*Nrd + C_prob_pg_analytic*NPG];
       A_M_total = [A_M_total, M_prob_rd_analytic*Nrd + M_prob_pg_analytic*NPG];
       A_N_total = [A_N_total, N_prob_rd_analytic*Nrd + N_prob_pg_analytic*NPG];

end 
%{
figure1 = figure(5);

h = plot(10:5:50, A_SuccessProb_C_rd, 'b', 10:5:50, SuccessProb_C_rd, 'b*', 10:5:50, A_SuccessProb_C_pg, 'g', 10:5:50, SuccessProb_C_pg, 'g+', 10:5:50, A_SuccessProb_M_rd, 'r', 10:5:50, SuccessProb_M_rd, 'r^', 10:5:50, A_SuccessProb_M_pg, 'c', 10:5:50, SuccessProb_M_pg, 'cv',  10:5:50, A_SuccessProb_N_rd, 'k--',  10:5:50, SuccessProb_N_rd, 'kx', 10:5:50, A_SuccessProb_N_pg, 'y',  10:5:50, SuccessProb_N_pg, 'yd');
%h = plot(0.1:0.1:1, A_SuccessProb_C_rd, 'b', 0.1:0.1:1, A_SuccessProb_C_pg, 'b', 0.1:0.1:1, SuccessProb_C_rd, 'b*', 0.1:0.1:1, SuccessProb_C_pg, 'b+');
%set( h , 'linewidth' , 1.2 );
h1 = legend('Theoretical Spec_{rd}', 'Simulation Spec_{rd}', 'Theoretical Spec_{pg}', 'Simulation Spec_{pg}', 'Theoretical YiNing_{rd}', 'Simulation YiNing_{rd}', 'Theoretical YiNing_{pg}', 'Simulation YiNing_{pg}', 'Theoretical New_{rd}', 'Simulation New_{rd}', 'Theoretical New_{pg}', 'Simulation New_{pg}');

xlabel(' Npg (N_{rd} = 100, m_p = 54, p = 0.75)');  
ylabel('Success Probbability');  
%axis([-inf, inf, 0.02, 0.25]);


set(figure1, 'PaperUnits', 'inches');
set(figure1, 'PaperPosition', [0 0 10 8]);
set(figure1, 'Units', 'inches');
set(figure1, 'Position', [0 0 10 8]);


print(figure1, '-depsc', 'fig_3-1.eps');
%}
