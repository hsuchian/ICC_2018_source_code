function [Average_delay, Number_per_round] = conventional(Npg, Nrd, mp ,p)
    N = Npg + Nrd;
    Npg1 = round(Npg * (1-p));                %Not under this eNB
    %fprintf('Npg1 = %d \n', Npg1 );

    Preamble_state = zeros(1, mp);
    UE_state = zeros(1, N);                   % 1 means access success, 0 not success yet, -1 not under this eNB
    UE_preamble = zeros(1, N);                %preamble state for each round
    UE_delay = zeros(1, N);
    Count = 0;                                %Counter for delay
    
    %set first Npg1 UE to be the UE that are not under this eNB
    for i = 1:Npg1,
        UE_state(i) = -1;
    end 
    
    UE_left = [N];                            %UE left in each round
    
    while (UE_left(end) > Npg1)
        UE_preamble = zeros(1, N);
        Preamble_state = zeros(1, mp);
        
        for i = Npg1+1:N,                    % if not success yet, choose preamble
            if (UE_state(i) == 0)
                UE_preamble(i) = unidrnd(mp);
                Preamble_state(UE_preamble(i)) = Preamble_state(UE_preamble(i)) + 1;
            end
        end
        
        %debug
        %for k = 1:mp
        %            fprintf('%d   ', Preamble_state(k));
        %end
        %fprintf('\n'); 
        
        
        for i = Npg1+1:N,                          %check preamble_state to see success or not
            if (UE_state(i) == 0)
                if (UE_preamble(i) > 0)
                    if (Preamble_state(UE_preamble(i)) == 1)
                        UE_state(i) = 1;  %Success
                        UE_delay(i) = Count;
                    end
                end
            end
        end
        
        %claculate number of success UEs
        UE_left = [UE_left, N - sum(UE_state) - Npg1]; %append new round
        Count = Count +1;
        %fprintf('UR_state sum = %d\n', sum(UE_state) + Npg1);
        %fprintf('UR_left(end) = %d\n', UE_left(end));
    end
    Number_per_round = UE_left;
    Average_delay = sum(UE_delay)/(N-Npg1);
end

