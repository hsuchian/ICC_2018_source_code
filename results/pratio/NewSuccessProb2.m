function [average_success_prob_rd, average_success_prob_pg, total_success] = NewSuccessProb2(Npg, Nrd, mp ,p, APaging_ratio)

    success_prob_pg_round = [];
    success_prob_rd_round = [];
    
    N = Npg + Nrd;
    Npg1 = round(Npg * (1-p));                %Not under this eNB
    
    test_round = 1000;
    Preamble_state = zeros(1, mp);
    UE_state = zeros(1, N);                   % 1 means access success, 0 not success yet, -1 not under this eNB
    UE_preamble = zeros(1, N);                % preamble for each UE
    Not_under_eNB_paged = zeros(1, Npg1);      %This kind of UE can only be choosed one time since we assume that it will success at other eNB
    
    total_success = 0;
    
    %set first Npg1 UE to be the UE that are not under this eNB
    for i = 1:Npg1,
        UE_state(i) = -1;
    end 
    
    
    for i = 1:test_round
        
        % For Random UEs, if not success yet, choose preamble
        for i = Npg + 1:N,
            if (UE_state(i) == 0)
                UE_preamble(i) = unidrnd(mp);
                Preamble_state(UE_preamble(i)) = Preamble_state(UE_preamble(i)) + 1;
            end
        end
        
        %Calculate Paging_ratio
        %{
        if mp > Nrd+1,
            Paging_ratio = mp*(1 - ((1-(p/mp))^(Npg)) )/(Npg*p);
        else
            Paging_ratio = (1-(p/mp))^(Npg-1);
        end
        
        if Paging_ratio > 1
            Paging_ratio = 1;
        elseif Paging_ratio < 0
            Paging_ratio = 0;
        end
        %}
        %-------------------------------------------------------------
        
        Paging_ratio = APaging_ratio;
        
        if Paging_ratio * Npg > mp
            Paging_ratio = mp/Npg;
        end
        
        %fprintf('Newpaging = %d\n', Paging_ratio);
        
        %Choose Paging UE
        temp_count = 0;
        Chosen = [];                            % UEs that had been chosen in this round
        
        
        while (temp_count < Npg * Paging_ratio)
            failed = 0;                         %Check if this round fail
            UE = unidrnd(Npg);
            if (UE_state(UE) == 0 )             %not success yet and under this eNB(!=1, != -1) 
                for i = 1:length(Chosen),       %Check if UE is already chosen in this round
                    if (Chosen(i) == UE) 
                        failed = 1;
                        break;
                    end
                end
                if (failed == 1)                %failed(Already chosen), Continue and choose again
                    continue;
                end
                
                %Success
                Chosen = [Chosen, UE];          %add UE into set 'Chosen'
                temp_count = temp_count + 1;
                UE_preamble(UE) = temp_count;   %Assign preamble
                Preamble_state(UE_preamble(UE)) = Preamble_state(UE_preamble(UE)) + 1;
                
            elseif (UE_state(UE) == -1)          
                if (Not_under_eNB_paged(UE) == 1)
                    continue;
                end
                
                %success
                Chosen = [Chosen, UE];   %add UE into set 'Chosen'
                temp_count = temp_count + 1;
                UE_preamble(UE) = temp_count;   %Assign preamble
                Not_under_eNB_paged(UE) = 1;               %Assume that this UE will success at other eNB
                
                %Need not increase Preamble_state(UE_preamble(UE))
            end
        end
        
        %-------------------------------------------------------------
        
        for i = Npg1+1:N,                          % check preamble_state to see success or not
            if (UE_state(i) == 0)
                if (UE_preamble(i) > 0)
                    if (Preamble_state(UE_preamble(i)) == 1)
                        UE_state(i) = 1;           % Success
                    end
                end
            end
        end
        
        total_success = total_success + sum(UE_state( Npg1+1:Npg ) ) + sum(UE_state( Npg+1:N ) );
        
        temp_prob_pg = sum(UE_state( Npg1+1:Npg ) ) / Npg;
        temp_prob_rd = sum(UE_state( Npg+1:N ) ) / Nrd;
        
        success_prob_pg_round = [success_prob_pg_round, temp_prob_pg];
        success_prob_rd_round = [success_prob_rd_round, temp_prob_rd];
       
        %Initialize
        
        Preamble_state = zeros(1, mp);
        UE_state = zeros(1, N);
        UE_preamble = zeros(1, N); 
        Not_under_eNB_paged = zeros(1, Npg1);      %This kind of UE can only be choosed one time since we assume that it will success at other eNB
        
        %set first Npg1 UE to be the UE that are not under this eNB
        for i = 1:Npg1,
            UE_state(i) = -1;
        end 
    end
    
    total_success = total_success/test_round;
    average_success_prob_pg = sum(success_prob_pg_round) / test_round;
    average_success_prob_rd = sum(success_prob_rd_round) / test_round;
    
end