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

b=zeros(length(Ocolor),length(Ocolor));
%write
for i=1:a
    for j=1:(Onum(i)-1)
        b(M(i,j),M(i,j+1))=b(M(i,j),M(i,j+1))+1; 
    end
end
%possibility
S=sum(b,2);
for i=1:length(S)
   for j=1:length(S)
      b(i,j)=b(i,j)/S(i,1); 
   end
end
xlswrite('1stoderNumber.xls',b);
% His=cell(length(Ocolor)*length(Ocolor),3);
% k=1;
% for i=1:length(Ocolor)
%    for j=1:length(Ocolor)
%        if b(i,j)~=0
%       His(k,1)=Ocolor(i);
%       His(k,2)=Ocolor(j);
%       His(k,3)=num2cell(b(i,j));
%       k=k+1;
%        end
%    end
% end
%  xlswrite('1stoderARRAY_NEW.xls',His);
% count=0;
% for i=1:a
%    for j=1:max(Onum)-1
%    if (M(i,j)==18)&(M(i,j+1)==18)
%       count=count+1; 
%    end
%    end
% end

%Initilization probability
% s=1;
% j=1;
% A=zeros(1,length(Ocolor));
% for i=1:length(CASE)
%     while i==s
%     for k=1:length(Ocolor)
%         if isequal(Ocolor(1,k),ACTICITY(i,1))
%            A(1,k)=A(1,k)+1; 
%            break;
%         end
%     end
%     s=s+Onum(1,j);
%     j=j+1;
%     end
% end
% S=sum(A);
% A=A/S;
%xlswrite('1stoderInitilizationProbability.xls',A);
