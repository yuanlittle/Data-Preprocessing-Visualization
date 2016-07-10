load('matlab_object.mat');
load('matlab_xCase.mat');
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
Ocolor(t+1)=cellstr('No activity');
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

%motify the "no activity"
for i=1:a
   for j=1:b
       if M(i,j)==0
           M(i,j)=20;
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
for ColorNum=1:20
%%%%%
%ColorNum=19;
%%%%%
l=1;
for i=1:a
	for j=1:b
		if M(i,j)==ColorNum
		H(l)=j;
        l=l+1;
		end
	end
end
subplot(4,5,ColorNum);
if (l==1)
    H(1)=0;
end
hist(H);
xlabel('Location');
ylabel('Number');
title(Ocolor(ColorNum));
clear H;
end