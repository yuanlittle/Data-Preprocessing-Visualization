%name of different cases
Cname = unique(xCase);
%amount of total different cases
a=length(Cname);
%objects amount in each case
for i=1:length(Cname)
    Onum(i)=length(find(xCase==Cname(i)));
end
b=max(Onum);
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
%motify the matix
j=0;
for i=1:a
		for l=1:Onum(i)
            j=j+1;
			for k=1:length(Ocolor)
				if isequal(Ocolor(1,k),object(j,1))
				 M(i,l)=k;
				 break;
				 end
			end
        end
end
%make every case has the same length
for i=1:a
        Mrow=M(i:i,1:Onum(i));
        Mrow=round(imresize(Mrow,[1,b]));
        for j=1:b
            M(i,j)=Mrow(1,j);
        end
end

l=1;
for ColorNum=1:length(Ocolor)
for i=1:a
	for j=1:b
		if M(i,j)==ColorNum
		H(l)=j;
        l=l+1;
		end
	end
end
Hnum(ColorNum)=l-1;
end

before=0;
for i=1:length(Ocolor)
Hcount(i)=Hnum(i)-before;
before=Hnum(i);
end

% index=1;
% for j=1:length(Ocolor)
% for i=1:Hcount(j)
%    G(index)=j;
%    index=index+1;
% end
% end
%Hnew=H(1:1,1:68);
% T=bplot(H(1:1,1:68),1);hold on;
% T=bplot(H(1:1,69:68),2);
begin=1;
for i=1:length(Ocolor)
   T=bplot(H(1:1,begin:Hnum(i)),i,'outliers');
   begin=Hnum(i)+1;
   hold on;
end
legend(T,'location','eastoutside');
xlabel('Activity');
ylabel('Order Number');
title('Distribution of different activity');
set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19]);%在X轴上设置刻度
set(gca, 'XTickLabel',{char(Ocolor)});
h=gca;
th=rotateticklabel(h,90);