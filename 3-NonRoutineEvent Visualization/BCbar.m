load('matlab_object.mat');
load('matlab_xCase.mat');
%name of different cases
Cname = unique(xCase);
count=zeros(1,8);
for i=1:length(BC)
    for j=1:8
        if isequal(BC(i),Cname(j))
            count(j)=count(j)+1;
        end
    end
end
bar(count);
xlabel('Burd code');
ylabel('Number');
title('Occurrence of the NRE in "Burd code"');
set(gca,'XTick',[1 2 3 4 5 6 7 8]);
set(gca, 'XTickLabel',{char(Cname)});
h=gca;
th=rotateticklabel(h,90);
