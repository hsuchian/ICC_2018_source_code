clear;
load('netscale_n100_p3.mat');
close all;
figure1 = figure;

hold on;
h = plot(100:100:500, A_C_total , 'b-.');
plot(100:100:500, C_total , 'b*');
plot(100:100:500, A_M_total, '-', 'Color',[0,.6, 0]);
plot(100:100:500, M_total, '^', 'Color',[0,.6,0]);
plot(100:100:500, A_N_total, 'r--');
plot(100:100:500, N_total, 'ro');
hold off;
hl = legend('LTE', 'LTE (ana)', 'C-Free', 'C-Free (ana)', 'C-Avoid', 'C-Avoid (ana)', 'Location', 'SouthEast');
legend boxoff;

xlabel('number of UEs to be paged');  
ylabel('number of successful UEs'); 

%axis([-inf, inf, 10, 20]);

set(figure1, 'PaperUnits', 'inches');
set(figure1, 'PaperPosition', [0 0 2.5 2.5]);
set(figure1, 'Units', 'inches');
set(figure1, 'Position', [0 0 2.5 2.5]);

pos = get(hl, 'position');
loci = get(gca, 'position');
set(hl, 'position', [loci(1)-.02 pos(2)-0.06 pos(3) pos(4)]);
print(figure1, '-depsc', 'netscale_n100_p3.eps');


% p = 0.8
clear;
load('netscale_n100_p8.mat');
close all;
figure1 = figure;
hold on;
h = plot(100:100:500, A_C_total , 'b-.');
plot(100:100:500, C_total , 'b*');
plot(100:100:500, A_M_total, '-', 'Color',[0,.6, 0]);
plot(100:100:500, M_total, '^', 'Color',[0,.6,0]);
plot(100:100:500, A_N_total, 'r--');
plot(100:100:500, N_total, 'ro');
hold off;
hl = legend('LTE', 'LTE (ana)', 'C-Free', 'C-Free (ana)', 'C-Avoid', 'C-Avoid (ana)', 'Location', 'SouthEast');
legend boxoff;

xlabel('number of UEs to be paged');  
ylabel('number of successful UEs'); 

ylim([0, 38]);
set(gca, 'YTick',[0:5:40]);
set(figure1, 'PaperUnits', 'inches');
set(figure1, 'PaperPosition', [0 0 2.5 2.5]);
set(figure1, 'Units', 'inches');
set(figure1, 'Position', [0 0 2.5 2.5]);

pos = get(hl, 'position');
loci = get(gca, 'position');
set(hl, 'position', [loci(1)+.22 pos(2)+.25 pos(3) pos(4)]);

print(figure1, '-depsc', 'netscale_n100_p8.eps');