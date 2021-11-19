function [average_success_prob_rd, average_success_prob_pg, total_success] = CovenSuccessProb(Npg, Nrd, mp ,p)

    success_prob_pg_round = [];
    success_prob_rd_round = [];
    N = Npg + Nrd;
    Npg1 = round(Npg * (1-p));                %Not under this eNB
    
    test_round = 1000;
    Preamble_state = zeros(1, mp);
    UE_state = zeros(1, N);                   % 1 means access success, 0 not success yet, -1 not under this eNB
    UE_preamble = zeros(1, N);                % preamble for each UE
    total_success =0;
    
    %set first Npg1 UE to be the UE that are not under this eNB
    for i = 1:Npg1,
        UE_state(i) = -1;
    end 
    
    for i = 1:test_round
        
        for j = Npg1+1:N,                     % choose preamble if UE are under this eNB
            if (UE_state(j) == 0)
                UE_preamble(j) = unidrnd(mp);
                Preamble_state(UE_preamble(j)) = Preamble_state(UE_preamble(j)) + 1;
            end
        end
       
        
        for i = Npg1+1:N,                          % check preamble_state to see success or not
            if (UE_state(i) == 0)
                if (UE_preamble(i) > 0)
                    if (Preamble_state(UE_preamble(i)) == 1)
                        UE_state(i) = 1;           % Success
                    end
                end
            end
        end
        
        temp_prob_pg = sum(UE_state( Npg1+1:Npg ) ) / Npg;
        temp_prob_rd = sum(UE_state( Npg+1:N ) ) / Nrd;
        
        success_prob_pg_round = [success_prob_pg_round, temp_prob_pg];
        success_prob_rd_round = [success_prob_rd_round, temp_prob_rd];
        
        total_success = total_success + sum(UE_state( Npg1+1:Npg ) ) + sum(UE_state( Npg+1:N ) );
       
        %Initialize
        Preamble_state = zeros(1, mp);
        UE_state = zeros(1, N);
        UE_preamble = zeros(1, N); 
        %set first Npg1 UE to be the UE that are not under this eNB
        for i = 1:Npg1,
            UE_state(i) = -1;
        end 
    end
    total_success = total_success/test_round;
    average_success_prob_pg = sum(success_prob_pg_round) / test_round;
    average_success_prob_rd = sum(success_prob_rd_round) / test_round;
    
end

