%Cname = unique(C);
count=zeros(1,length(Cname));
for i=1:length(C)
    for j=1:length(Cname)
        if isequal(C(i),Cname(j))
            count(j)=count(j)+1;
        end
    end
end
bar(count);
xlabel('Classification');
ylabel('Number');
title('Distribution of NRE based on classification');
set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23]);
set(gca, 'XTickLabel',{char(Cname)});
h=gca;
th=rotateticklabel(h,90);