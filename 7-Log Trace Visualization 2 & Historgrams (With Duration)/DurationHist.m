load('matlab_object.mat');
load('matlab_xCase.mat');
load('startTime.mat');
load('endTime.mat');
%calculate duration
Duration=int16((endTime-startTime)*100000);
%name of different cases
Cname = unique(xCase);
%amount of total different cases
a=length(Cname);
%objects amount in each case
for i=1:length(Cname)
    Onum(i)=length(find(xCase==Cname(i)));
end
%length in each case
old=0;
for i=1:length(Onum)
    old=old+Onum(i);
    endofcase(i)=old;
end
casebegin=1;
caseend=endofcase(1);
for i=1:length(Cname)
    caseend=endofcase(i);
    sumLength(i)=sum(Duration(casebegin:caseend,1:1));
    casebegin=caseend+1;
end
b=max(sumLength);
%create matrix
M=zeros(a,b);
%number of color
t=1;
Ocolor(t)=object(1,1);
for i=1:length(xCase)
    j=1;
    while j<i
        if isequal(object(i,1),object(j,1))
            break;
        end
        if j==i-1
        t=t+1;
        Ocolor(t)=object(i,1);
        end
        j=j+1;
    end
end

for ColorNum=1:19
l=1;
for i=1:length(Duration)
   if isequal(object(i,1),Ocolor(1,ColorNum))
       H(l)=double(Duration(i,1));
       l=l+1;
   end
end
subplot(4,5,ColorNum);
hist(H);
xlabel('Duration(second)');
ylabel('Number');
title(Ocolor(ColorNum));
clear H;
end
