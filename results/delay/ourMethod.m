function [Average_delay, Number_per_round] = ourMethod(Npg, Nrd, mp ,p)
    N = Npg + Nrd;
    Npg1 = round(Npg * (1-p));                 %Not under this eNB
    
    %initialized one time
    Not_under_eNB_paged = zeros(1, Npg1);      %This kind of UE can only be choosed one time since we assume that it will success at other eNB
    Count = 0;                                 %Count delay
    UE_delay = zeros(1, N);
    UE_state = zeros(1, N);                    % 1 means access success, -1:not under this eNB, 0:not success yet
    
    %update in eaach round 
    Paging_ratio = 0;   
    Preamble_state = zeros(1, mp);
    UE_preamble = zeros(1, N);
    UE_left = [N];
    Random_left = [Nrd];
    Paging_left = [Npg];
   
    
    for i = 1:Npg1,
        UE_state(i) = -1;
    end 
    
    
    while (UE_left(end) > 0)
        
        %Initialization
        UE_preamble = zeros(1, N);
        Preamble_state = zeros(1, mp);
        
        %For Random UEs, if not success yet, choose preamble
        for i = Npg + 1:N,
            if (UE_state(i) == 0)
                UE_preamble(i) = unidrnd(mp);
                Preamble_state(UE_preamble(i)) = Preamble_state(UE_preamble(i)) + 1;
            end
        end
        
        %Calculate Paging_ratio
        if mp > Random_left(end)+1,
            Paging_ratio = mp*(1 - ((1-(p/mp))^(Paging_left(end))) )/(Paging_left(end)*p);
        else
            Paging_ratio = (1-(p/mp))^(Paging_left(end)-1);
        end
        
        if Paging_ratio > 1
            Paging_ratio = 1;
        elseif Paging_ratio < 0
            Paging_ratio = 0;
        end
        
        if Paging_ratio * Paging_left(end) > mp
            Paging_ratio = mp/Paging_left(end);
        end
            
        %Choose Paging UE
        temp_count = 0;
        Chosen = [];                            % UEs that had been chosen in this round
        
        
        while (temp_count < round(Paging_left(end) * Paging_ratio))
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
                %for i = 1:length(Chosen), %Check if UE is already chosen in this round
                %    if (Chosen(i) == UE) 
                %        failed = 1;
                %        break;
                %    end
                %end
                %if (failed == 1)   %failed(Already chosen), Continue and choose again
                %    continue;
                %end
               
                %success
                Chosen = [Chosen, UE];   %add UE into set 'Chosen'
                temp_count = temp_count + 1;
                UE_preamble(UE) = temp_count;   %Assign preamble
                Not_under_eNB_paged(UE) = 1;               %Assume that this UE will success at other eNB
                %Need not increase Preamble_state(UE_preamble(UE))
             
            end
        end
      
        %check preamble_state to see success or not
        for i = Npg1+1:N,  %1~Npg1 always failed
            if (UE_state(i) == 0)
                if (UE_preamble(i) > 0)
                    if ( Preamble_state( UE_preamble(i) ) == 1)
                        UE_state(i) = 1;  %Success
                        UE_delay(i) = Count;
                    end
                end
            end
        end
        
        %claculate number of success UEs
        
        temp = 0;
        for i = Npg+1:N                                %count random left
            if (UE_state(i) == 0)
                temp = temp +1;
            end
        end
        Random_left = [Random_left, temp];
        temp = 0;
        for i = 1:Npg1                                 %count paging left
            if (Not_under_eNB_paged(i) == 0)
                temp = temp +1;
            end
        end
        
        UE_left = [UE_left, N - sum(UE_state) - Npg1 - (Npg1-temp)]; %append new round
        
        for i = Npg1+1:Npg                             %count paging left
            if (UE_state(i) == 0)
                temp = temp +1;
            end
        end
       
        Paging_left = [Paging_left, temp];
        
        
        if (UE_left(end) ~= Paging_left(end) + Random_left(end))
            fprintf('UE_left(end) = %d\n', UE_left(end));
            fprintf('%d + %d = %d\n', Paging_left(end) , Random_left(end), Paging_left(end) + Random_left(end));
            fprintf('ERROR\n');
            return ;
        end
        Count = Count +1;
        
        %fprintf('UR_left(end) = %d\n', UE_left(end));
    end
    Number_per_round = UE_left;
    Average_delay = sum(UE_delay)/(N-Npg1);
end