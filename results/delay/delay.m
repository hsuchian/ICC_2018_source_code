
% initialization
clear 
clc
test_round = 1000;   %iteration time


delay_conventional1 = [];
delay_ourMethod1 = [];
delay_Mid1 = [];

delay_conventional2 = [];
delay_ourMethod2 = [];
delay_Mid2 = [];

%Fixed preamble, Random UE = 50, Paging = 50, preamble = 54

delay_conventional1 = [];
delay_ourMethod1 = [];
delay_Mid1 = [];

delay_conventional2 = [];
delay_ourMethod2 = [];
delay_Mid2 = [];

%Delay time/ fixed preambles = 54, fixed Random/paging UE = 50
for p_prob  = 0.1:0.1:1,
    delay_temp1 = [];
    delay_temp2 = [];
    delay_temp3 = [];
    for Iteration = 1:test_round,
       [d_temp1, left] = conventional(50, 50, 54, p_prob );
       delay_temp1 = [delay_temp1, d_temp1];
       [d_temp2, left] = ourMethod(50, 50, 54, p_prob );
       delay_temp2 = [delay_temp2, d_temp2];
       [d_temp3, left] = Mid(50, 50, 54, p_prob );
       delay_temp3 = [delay_temp3, d_temp3];
    end
    delay_conventional1 = [delay_conventional1, mean(delay_temp1)];
    delay_ourMethod1 = [delay_ourMethod1, mean(delay_temp2)];
    delay_Mid1 = [delay_Mid1, mean(delay_temp3)];
end



%Delay time/ fixed preambles = 54, fixed Random/paging  UE =100
for p_prob  = 0.1:0.1:1,
    delay_temp1 = [];
    delay_temp2 = [];
    delay_temp3 = [];
    for Iteration = 1:test_round,
       [d_temp1, left] = conventional(100, 100, 54, p_prob );
       delay_temp1 = [delay_temp1, d_temp1];
       [d_temp2, left] = ourMethod(100, 100, 54, p_prob );
       delay_temp2 = [delay_temp2, d_temp2];
       [d_temp3, left] = Mid(100, 100, 54, p_prob );
       delay_temp3 = [delay_temp3, d_temp3];
    end
    delay_conventional2 = [delay_conventional2, mean(delay_temp1)];
    delay_ourMethod2 = [delay_ourMethod2, mean(delay_temp2)];
    delay_Mid2 = [delay_Mid2, mean(delay_temp3)];
end

