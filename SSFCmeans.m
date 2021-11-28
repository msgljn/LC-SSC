function [Pro1,Pro2,label1,label2]=SSFCmeans(data,L,t,m)
%% setup parameters
if nargin==0
    load data1;load t t;load L L;
    L=L;
    data=data1;
    m=2;
end
c=length(unique(t));
% running the algorithm
%% 1)initialize the L_u && v
% initialize L_u
nL=size(L,1);
tempdata=[L;data];
[n,dim]=size(tempdata);
L_u=zeros(size(tempdata,1),c);
for i=1:c
    pos=[];
    pos=find(i==t);
    L_u(pos,i)=1;
end
% initialize v
for i=1:c
    v(i,:)=sum( tempdata.* (repmat(L_u(:,i),1,dim)) )/sum( L_u(:,i) );
end
v=rand(c,dim)*400;
% initialize iteration
it=2;
itera=30;
u=zeros(n,c);
while it<itera
    %% 2)initialize the uik
    for i=1:c
        dist1=[];
        dist1=sqrt(sum((tempdata-repmat(v(i,:),n,1)).^2,2));
        numerator=[];
        numerator=(1./dist1).^(1/(m-1));
        denominator=zeros(n,1);
        for j=1:c
            dist=[];
            dist=sqrt(sum((tempdata-repmat(v(j,:),n,1)).^2,2));
            temp=[];
            temp=(1./dist).^(1/(m-1));
            denominator=denominator+temp;
        end
        right=[];
        right=numerator./denominator;
        u(:,i)= L_u(:,i)+(1-sum(L_u,2)).*right;
    end
    %% 3)initialize the v
    for i=1:c
        v(i,:)=sum((repmat((( abs( u(:,i)-L_u(:,i) ) ).^m),1,dim).*tempdata))./sum((abs(u(:,i)-L_u(:,i)).^m));
    end
    it=it+1;
end
[Pro,label]=max(u,[],2);
Pro1=Pro(1:nL);
Pro2=Pro(nL+1:end);
label1=label(1:nL);
label2=label(nL+1:end);
end