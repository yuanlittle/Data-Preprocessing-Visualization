T=bplot(log1,1,'outliers');hold on;
T=bplot(log2,2,'outliers');
xlabel('Case ID');
ylabel('LogProb(Current --> Next)');
title('Distribution of the LogProb');
set(gca,'XTick',[1 2]);%在X轴上设置刻度
set(gca, 'XTickLabel',{140831 140832});
legend(T,'location','eastoutside');