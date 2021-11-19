clear;
load('delay.mat');
close all;
figure1 = figure;
hold on;

plot(0.1:0.1:1, delay_conventional2, 'b-.*')
plot(0.1:0.1:1, delay_Mid2, '-^', 'Color', [0, 0.6, 0]);
plot(0.1:0.1:1, delay_ourMethod2, 'r--o');
plot(0.1:0.1:1, delay_conventional1, 'b-.x')
plot(0.1:0.1:1, delay_Mid1, '-v', 'Color', [0, 0.6, 0]);
plot(0.1:0.1:1, delay_ourMethod1, 'r--p');
hl = legend('LTE (|P|=|R|=100', 'C-Free (|P|=|R|=100','C-Avoid (|P|=|R|=100', ...
	'LTE (|P|=|R|=50', 'C-Free (|P|=|R|=50','C-Avoid (|P|=|R|=50', 'Location', 'NorthWest' );
legend boxoff;
xlabel('active probability (\alpha)');  
ylabel('number of paging rounds'); 
%set(gca, 'YTick',[0:.1:.5]);
%ylim([0,0.42]);
set(gca, 'XTick',[0:.2:1]);
xlim([.1,1]);


set(figure1, 'PaperUnits', 'inches');
set(figure1, 'PaperPosition', [0 0 4.5 2.5]);
set(figure1, 'Units', 'inches');
set(figure1, 'Position', [0 0 4.5 2.5]);
pos = get(hl, 'position');
loci = get(gca, 'position');
set(hl, 'position', [loci(1)-0.01 pos(2)+0.05 pos(3) pos(4)]);


print(figure1, '-depsc', 'delay.eps');