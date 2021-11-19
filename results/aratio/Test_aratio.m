clear;
load('aratio.mat');
close all;
figure1 = figure(1);
hold on;
% for legend
h = plot(2:3,2:3, 'bs-.');
plot(2:3,2:3, 'b*-.');
plot(2:3,2:3, 's-', 'Color', [0, 0.6, 0]);
plot(2:3,2:3, '*-',  'Color', [0, 0.6, 0]);
plot(2:3,2:3, 'r--s', 2:3,2:3, 'r*--');
% real data
plot(0.1:0.1:1, A_SuccessProb_C_rd, 'b-.');
plot(0.1:0.1:1, SuccessProb_C_rd, 'bs');
plot(0.1:0.1:1, A_SuccessProb_C_pg, 'b-.');
plot(0.1:0.1:1, SuccessProb_C_pg, 'b*');
plot(0.1:0.1:1, A_SuccessProb_M_rd, '-', 'Color', [0, 0.6, 0]);
plot(0.1:0.1:1, SuccessProb_M_rd, 's', 'Color', [0, 0.6, 0]);
plot(0.1:0.1:1, A_SuccessProb_M_pg, '-', 'Color', [0, 0.6, 0]);
plot(0.1:0.1:1, SuccessProb_M_pg, '*', 'Color', [0, 0.6, 0]);
plot(0.1:0.1:1, A_SuccessProb_N_rd, 'r--');
plot(0.1:0.1:1, SuccessProb_N_rd, 'rs');
plot(0.1:0.1:1, A_SuccessProb_N_pg, 'r--');
plot(0.1:0.1:1, SuccessProb_N_pg, 'r*');
%h = plot(0.1:0.1:1, A_SuccessProb_C_rd, 'b', 0.1:0.1:1, A_SuccessProb_C_pg, 'b', 0.1:0.1:1, SuccessProb_C_rd, 'b*', 0.1:0.1:1, SuccessProb_C_pg, 'b+');
%set( h , 'linewidth' , 1.2 );
hl = legend('LTE random', 'LTE page', 'C-Free random','C-Free page', 'C-avoid random', 'C-avoid page', 'FontSize',18);
l = legend('show');
l.FontSize = 13;
legend boxoff;

set(gca, 'YTick',[0:.1:.5]);
ylim([0,0.42]);
set(gca, 'XTick',[0:.2:1]);
xlim([.1,1]);
xlabel('active probability (\alpha)');  
ylabel('success probbability');  

set(figure1, 'PaperUnits', 'inches');
set(figure1, 'PaperPosition', [0 0 8 7]);
set(figure1, 'Units', 'inches');
set(figure1, 'Position', [0 0 8 7]);

%pos = get(hl, 'position');
%loci = get(gca, 'position');
%set(hl, 'position', [loci(1) pos(2)+0.05 pos(3) pos(4)]);
print(figure1, '-dpng', 'aratio_prob1.png');
hold off;



figure1 = figure(2);
hold on;
h = plot(0.1:0.1:1, A_C_total , 'b-.');
plot(0.1:0.1:1, C_total , 'b*');
plot(0.1:0.1:1, A_M_total, '-', 'Color',[0,.6,0]);
plot(0.1:0.1:1, M_total, '^', 'Color',[0,.6,0]);
plot(0.1:0.1:1, A_N_total, 'r--');
plot(0.1:0.1:1, N_total, 'ro');
hl = legend('LTE', 'LTE (ana)', 'C-Free', 'C-Free (ana)', 'C-Avoid', 'C-Avoid (ana)', 'Location', 'SouthEast', 'FontSize',18);
 
l = legend('show');
l.FontSize = 13;

legend boxoff;
xlabel('active probabiltiy (\alpha)');  
ylabel('number of successful UEs'); 
set(gca, 'YTick',[0:5:35]);
ylim([0,35]);
set(gca, 'XTick',[0:.2:1]);
xlim([.1,1]);

set(figure1, 'PaperUnits', 'inches');
set(figure1, 'PaperPosition', [0 0 8 7]);
set(figure1, 'Units', 'inches');
set(figure1, 'Position', [0 0 8 7]);
pos = get(hl, 'position');
loci = get(gca, 'position');

print(figure1, '-dpng', 'aratio_UE1.png');
