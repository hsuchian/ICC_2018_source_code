clear;
load('pratio_n100_p3.mat');
close all;
figure1 = figure;
hold on;
h = plot(0:0.05:1, A_C_total , 'b-.');
plot(0:0.05:1, C_total , 'b*');
xl = ceil(a / 0.05) * 0.05
xh = floor(b / 0.05) * 0.05
plot(xl:0.05:xh, A_M_total(xl/0.05+1:xh/0.05+1), 'Color',[0,.6,0]);
plot(xl:0.05:xh, M_total(xl/0.05+1:xh/0.05+1), '^','Color',[0,.6,0]);
%plot(0:0.05:1, A_M_total, 'Color',[0,.6,0]);
%plot(0:0.05:1, M_total, '^','Color',[0,.6,0]);
a1 = (1-(p/mp))^(Npg-1);
b1 = mp*(1 - ((1-(p/mp))^(Npg)) )/(Npg*p);
xl = ceil(a1 / 0.05) * 0.05
xh = floor(b1 / 0.05) * 0.05
plot(xl:0.05:xh, A_N_total(round(xl/0.05+1:xh/0.05+1)), 'r--');
plot(xl:0.05:xh, N_total(round(xl/0.05+1:xh/0.05+1)), 'ro');
%plot(0:0.05:1, A_N_total, 'r--');
%plot(0:0.05:1, N_total, 'ro');

%Yining r(x,y)
p = 0.3;
x = min( [0.54  ((  mp - (    1 / ( 1-  ( 1 - (1/mp))^( 1+  Npg/(Nrd-1) ) ) )     )   /  Npg) ]);
y = (1- 1/(mp-Npg*x))^(Nrd-1) * Nrd    +     x * p * Npg;

xl = floor(x/0.05)
xh = ceil(x/0.05)
wrongy = A_M_total(xl) +  (A_M_total(xh) - A_M_total(xl)) * (x/0.05 - xl) / (xh / xl)
plot(x,y, '^', 'MarkerEdgeColor', [0,0,0], 'MarkerFaceColor',[0 0.8 0]);
annotation('textarrow',[0.26 0.36],[0.6 0.65],'String','r^F')

% my r(x,y)

p = 0.3;
x1 = min(  [0.54   ((1-(p/mp))^(Npg-1))     ]  );
y1 = (1 - (1/mp))^(Nrd-1) * (1 - x1*Npg*p / mp ) * Nrd    +    x1 * p * (1 - (1/mp))^Nrd * Npg;

plot(x1,y1, 'o', 'MarkerEdgeColor', [0,0,0], 'MarkerFaceColor','m');
annotation('textarrow',[0.46 0.56],[0.86 0.81],'String','r^A')

%plot([a,a],[0,16], 'k:',  [b,b],[0,16],'k:', 'LineWidth', 1.2);
ylim([0, 16]);
xlim([0, 1]);
set(gca, 'YTick',[0:4:16]);
set(gca, 'XTick',[0:.2:1]);
hl = legend('LTE', 'LTE (ana)', 'C-Free', 'C-Free (ana)', 'C-Avoid', 'C-Avoid (ana)', 'Location', 'SouthEast');
legend boxoff;
%xlabel(' Paging ratio (N_{pg} = 100, N_{rd} = 100, m_p = 54, p = 0.75)');  
xlabel('paging ratio (r)');  
ylabel('number of successful UEs');   


set(figure1, 'PaperUnits', 'inches');
set(figure1, 'PaperPosition', [0 0 2.5 2.5]);
set(figure1, 'Units', 'inches');
set(figure1, 'Position', [0 0 2.5 2.5]);

pos = get(hl, 'position');
loci = get(gca, 'position');
set(hl, 'position', [loci(1)+.18 pos(2)-0.02 pos(3) pos(4)]);

print(figure1, '-depsc', 'pratio_n100_p3.eps');
hold off;

%%  figure p=0.8
clear
load('pratio_n100_p8.mat');
close all;
figure1 = figure;
hold on;
h = plot(0:0.05:1, A_C_total , 'b-.');
plot(0:0.05:1, C_total , 'b*');
xl = ceil(a / 0.05) * 0.05
xh = floor(b / 0.05) * 0.05
plot(xl:0.05:xh, A_M_total(xl/0.05+1:xh/0.05+1), 'Color',[0,.6,0]);
plot(xl:0.05:xh, M_total(xl/0.05+1:xh/0.05+1), '^','Color',[0,.6,0]);
%plot(0:0.05:1, A_M_total, 'Color',[0,.6,0]);
%plot(0:0.05:1, M_total, '^','Color',[0,.6,0]);
a1 = (1-(p/mp))^(Npg-1);
b1 = mp*(1 - ((1-(p/mp))^(Npg)) )/(Npg*p);
xl = ceil(a1 / 0.05) * 0.05
xh = floor(b1 / 0.05) * 0.05
plot(xl:0.05:xh, A_N_total(round(xl/0.05+1:xh/0.05+1)), 'r--');
plot(xl:0.05:xh, N_total(round(xl/0.05+1:xh/0.05+1)), 'ro');
%plot(0:0.05:1, A_N_total, 'r--');
%plot(0:0.05:1, N_total, 'ro');
%plot([a,a],[0,41], 'k:',  [b,b],[0,41],'k:', 'LineWidth', 1.2);
%annotation('doublearrow',[0.2 0.37],[.8 .8])

p = 0.8;
x = min( [0.54  ((  mp - (    1 / ( 1-  ( 1 - (1/mp))^( 1+  Npg/(Nrd-1) ) ) )     )   /  Npg) ]);
y = (1- 1/(mp-Npg*x))^(Nrd-1) * Nrd    +     x * p * Npg;

xl = floor(x/0.05)
xh = ceil(x/0.05)
wrongy = A_M_total(xl) +  (A_M_total(xh) - A_M_total(xl)) * (x/0.05 - xl) / (xh / xl)
plot(x,y, '^', 'MarkerEdgeColor', [0,0,0], 'MarkerFaceColor',[0 0.8 0]);

annotation('textarrow',[0.25 0.36],[0.88 0.9],'String','r^F')
% my r(x,y)
p = 0.8;
x1 = min(  [0.54   ((1-(p/mp))^(Npg-1))     ]  );
y1 = (1 - (1/mp))^(Nrd-1) * (1 - x1*Npg*p / mp ) * Nrd    +    x1 * p * (1 - (1/mp))^Nrd * Npg;

plot(x1,y1, 'o', 'MarkerEdgeColor', [0,0,0], 'MarkerFaceColor','m');
annotation('textarrow',[0.25 0.33],[0.5 0.56],'String','r^A')

ylim([0, 25]);
set(gca, 'YTick',[0:5:25]);
set(gca, 'XTick',[0:.2:1]);
hl = legend('LTE', 'LTE (ana)', 'C-Free', 'C-Free (ana)', 'C-Avoid', 'C-Avoid (ana)', 'Location', 'NorthEast');
legend boxoff;
%xlabel(' Paging ratio (N_{pg} = 100, N_{rd} = 100, m_p = 54, p = 0.75)');  
xlabel('paging ratio (r)');  
ylabel('number of successful UEs');   


set(figure1, 'PaperUnits', 'inches');
set(figure1, 'PaperPosition', [0 0 2.5 2.5]);
set(figure1, 'Units', 'inches');
set(figure1, 'Position', [0 0 2.5 2.5]);

pos = get(hl, 'position');
loci = get(gca, 'position');
set(hl, 'position', [loci(1)+.22 pos(2)+.06 pos(3) pos(4)]);

print(figure1, '-depsc', 'pratio_n100_p8.eps');
hold off;