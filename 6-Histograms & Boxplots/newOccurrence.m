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

k=1;
for ColorNum=1:12
t=1;
for i=1:length(CaseID)
    if isequal(Activity(i),Ocolor(ColorNum))
        H(t)=Occurrence(i);
        t=t+1;
    end
end
subplot(3,4,k);
k=k+1;
hist(H);
xlabel('Occurrence');
ylabel('Number');
title(Ocolor(ColorNum));
clear H;
end