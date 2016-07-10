%name of different cases
Cname = unique(CaseID);
%amount of total different cases
a=length(Cname);
%objects amount in each case
for i=1:length(Cname)
    Onum(i)=length(find(CaseID==Cname(i)));
end
%number of color
t=1;
Ocolor(t)=Activity(1,1);
for i=1:length(CaseID)
    j=1;
    while j<i
        if isequal(Activity(i,1),Activity(j,1))
            break;
        end
        if j==i-1
        t=t+1;
        Ocolor(t)=Activity(i,1);
        end
        j=j+1;
    end
end




for i=1:length(Ocolor)
    t=1;
    for j=1:length(CaseID)
    if isequal(Activity(j),Ocolor(i))
        H(t)=Occurrence(j);
        t=t+1;
    end
    end

   T=bplot(H,i,'outliers');
   hold on;
   clear H;
end
legend(T,'location','eastoutside');
xlabel('Activity');
ylabel('Occurrence Number');
title('Distribution of different activity');
set(gca,'XTick',[1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	21	22	23	24	25	26	27	28	29	30	31	32	33	34	35	36	37	38	39	40	41	42]);%在X轴上设置刻度
set(gca, 'XTickLabel',{char(Ocolor)});
h=gca;
th=rotateticklabel(h,90);