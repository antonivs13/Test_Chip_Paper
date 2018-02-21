clear all;
clc

mixed = csvread('lcv_b17_50k.csv');
design_name= 'lcv\_b17\_50k';
xtick = 10;

% order: SSL, IP, wired-and, wired-or, dominant, open-stem, open-branch
% b17
% all_faults = [105412 164734 94192 94192 188384 14591 1805];
% detected = [105398 102523 ];

% b17_TPI_50PI
% all_faults = [113466 169878 82768 82769 165538 15927 6576];
% detected = [113466 132191 ];

% b17_TPI_100PI
% all_faults = [113548 169878 85239 85239 170478 15968 6596];
% detected = [113548 132518 ];

% lcv_b17_10k
% all_faults = [58992 50112 19549 19549 39098 9579 3419];
% detected = [58911 40564 19526 19533 32205 9519 3361];

% lcv_b17_20k
% all_faults = [64754 57118 23666 23666 47332 10279 4024];
% detected = [64727 44891 23646 23652 40303 10216 3961];

% lcv_b17_50k
all_faults = [65086 61296 16629 16629 37865 9996 4504];
detected = [65074 44857 16613 16613 32482 9936 4444];

% l2b
% all_faults = [69420 62860 67485 67485 134970 12465 1467];
% detected = [69420 49334 50504 51229 131473 7678 1218];

signature_sum = zeros(size(mixed,1),1);
signature_proportion = zeros(size(mixed,1),1);

groups = mixed(:,1);
undetected = sum(all_faults) - sum(detected);
fault_count = mixed(:,size(mixed,2));
fault_sum = sum(all_faults);
fault_proportion = fault_count ./ fault_sum;

% new plots
figure
subplot(1,2,1)
fig1_1 = bar(0, undetected);
hold on
fig1_2 = bar(groups, fault_count);

set(fig1_1, 'facecolor', 'r');
set(fig1_2, 'facecolor', 'y');

set(gca, 'YScale', 'log');
% xlim([-1,max(groups)+1]);
xticks = [0:fix(max(groups)/xtick)+1]'*xtick;

% set(gca,'XLim',[-1 max(groups)+1])
set(gca,'XLim',[-1 ceil(max(groups)/xtick)*xtick])
set(gca, 'XTick', xticks)
xlabel('Fault Signature Group Size', 'FontSize', 15)
ylabel('Number of Faults', 'FontSize', 15)
sub_title1 = title('Number of Faults vs. Fault Signature Group Size');
sub_title1.FontSize = 15;

subplot(1,2,2)
fig2_1 = bar(0, undetected/sum(all_faults));
hold on
fig2_2 = bar(groups, fault_proportion);

% set(gca, 'YScale', 'log');
set(fig2_1, 'facecolor', 'r');
set(fig2_2, 'facecolor', 'y');

% xticks = [0:fix(max(groups)/10)+1]'*10;

% set(gca,'XLim',[-1 max(groups)+1])
set(gca,'XLim',[-1 ceil(max(groups)/xtick)*xtick])
set(gca, 'XTick', xticks)

xlabel('Fault Signature Group Size', 'FontSize', 15);
ylabel('Proportion of Faults', 'FontSize', 15);
sub_title2 = title('Proportion of Faults vs. Fault Signature Group Size');

sub_title2.FontSize = 15;


title1 = sprintf('Fault Distribution of %s', design_name);
master_title = suptitle(title1);
master_title.FontSize = 25;

figure
fig3_1 = bar(0, undetected/sum(all_faults));
hold on
fig3_2 = bar(groups, fault_proportion);

% set(gca, 'YScale', 'log');
set(fig3_1, 'facecolor', 'r');
set(fig3_2, 'facecolor', 'y');

% xticks = [0:fix(max(groups)/10)+1]'*10;

% set(gca,'XLim',[-1 max(groups)+1])
set(gca,'XLim',[-1 ceil(max(groups)/xtick)*xtick])
set(gca, 'XTick', xticks)

xlabel('Fault Signature Group Size', 'FontSize', 15);
ylabel('Proportion of Faults', 'FontSize', 15);
title2 = sprintf('Proportion of Faults vs. Fault Signature Group Size for %s', design_name);
master_title2 = title(title2);
master_title2.FontSize = 15;



% figure
% subplot(1,2,1)
% myFig1_1 = bar(0, sum(all_faults)-sum(detected));
% hold on
% 
% for i = 1:size(mixed,1)
%     signature_sum(i,1) = sum(mixed(i,2:size(mixed,2)-1));
% end
% myFig1_2 = bar(mixed(:,1), signature_sum, 'stacked');
% 
% set(myFig1_1, 'facecolor', 'r');
% set(myFig1_2, 'facecolor', 'y');
% 
% % % % set(gca,'YScale','log');
% xlim([-1,80]);
% set(gca,'YScale','log');
% % set(gca, 'yticklabel',{'0'; '1'; '10'; '10^2'; '10^3'; '10^4'; '10^5'});
% % set(gca, 'yticklabel', exp(signature_log_sum));
% xlabel('Fault Signature Group Size')
% ylabel('Proportion of Fault Signatures (Log Scale)')
% title1 = sprintf('Fault Signature Distribution of %s', design_name);
% title(title1);
% 
% 
% subplot(1,2,2)
% for i = 1:size(mixed,1)
%     signature_proportion(i,1) = log(sum(mixed(i,2:size(mixed,2)-1)))+1;
% end
% mixed_proportion = zeros(size(mixed,1),size(mixed,2)-2);
% 
% for i = 1:size(mixed,1)
%     mixed_proportion(i,:) = mixed(i,2:size(mixed,2)-1) ./ sum(mixed(i,2:size(mixed,2)-1)) .* signature_proportion(i,1);
% end
% 
% myFig2 = bar(mixed(:,1), mixed_proportion, 'stacked');
% set(myFig2(1), 'facecolor', 'r');
% set(myFig2(2), 'facecolor', 'b');
% set(myFig2(3), 'facecolor', 'g');
% set(myFig2(4), 'facecolor', 'm');
% set(myFig2(5), 'facecolor', 'c');
% set(myFig2(6), 'facecolor', 'k');
% set(myFig2(7), 'facecolor', [0.5 0.3 0]);
% set(myFig2(8), 'facecolor', 'y');
% 
% % % % set(gca,'YScale','log');
% xlim([0,80]);
% set(gca,'YTickLabel',{' '})
% % set(gca, 'yticklabel',{' '; '1'; '10'; '10^2'; '10^3'; '10^4'; '10^5'});
% % set(gca, 'yticklabel', exp(signature_log_sum));
% lgd = legend('SSL', 'IP', 'Wired Or', 'Wired And', 'Dominant', 'Open Stem', 'Open Branch', 'Mixed');
% lgd.FontSize = 25;
% xlabel('Fault Signature Group Size')
% ylabel('Proportion of Fault Signatures (Log Scale)')
% title2 = sprintf('Fault Signature Distribution of %s', design_name);
% title(title2);
% 
% 
% suptitle('Fault Signature Distribution of CM-LCV Array 10k')
