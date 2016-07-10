%name of different cases
Cname = unique(CASE);
%amount of total different cases
a=length(Cname);
%objects amount in each case
for i=1:a
    Onum(i)=length(find(CASE==Cname(i)));
end
b=max(Onum);
%create matrix
M=zeros(a,b);

%number of color
t=1;
Ocolor(t)=ACTICITY(1,1);
for i=1:length(CASE)
    j=1;
    while j<i
        if isequal(ACTICITY(i,1),ACTICITY(j,1))
            break;
        end
        if j==i-1
        t=t+1;
        Ocolor(t)=ACTICITY(i,1);
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
				if isequal(Ocolor(1,k),ACTICITY(j,1))
				 M(i,l)=k;
				 break;
				 end
			end
        end
end

b=zeros(length(Ocolor)*length(Ocolor),length(Ocolor));
%write
for i=1:a
    for j=1:Onum(i)-2
        b(M(i,j+1)+(M(i,j)-1)*length(Ocolor),M(i,j+2))=b(M(i,j+1)+(M(i,j)-1)*length(Ocolor),M(i,j+2))+1; 
    end
end
%possibility
% S=sum(b,2);
% for i=1:length(S)
%    for j=1:length(Ocolor)
%        if S(i,1)~=0
%          b(i,j)=b(i,j)/S(i,1); 
%        end
%    end
% end
% xlswrite('2ndorderNumber.xls',b);
His=cell(length(Ocolor)*length(Ocolor)*length(Ocolor),4);
k=1;
for i=1:length(Ocolor)*length(Ocolor)
   for j=1:length(Ocolor)
       if b(i,j)~=0
      His(k,1)=Ocolor(ceil(i/length(Ocolor)));
      if rem(i,length(Ocolor))~=0
          His(k,2)=Ocolor(rem(i,length(Ocolor)));
      else
          His(k,2)=Ocolor(length(Ocolor));
      end
      His(k,3)=Ocolor(j);
      His(k,4)=num2cell(b(i,j));
      k=k+1;
       end
   end
end
xlswrite('2ndorderARRAY_NEW.xlsx',His);