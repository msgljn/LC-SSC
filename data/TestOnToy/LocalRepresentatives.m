function locdatal_core=LocdatalRepresentdatatives( data,NaNE )
[N,dim]=size(data);
% ��������
dist=pdist2(data,data);
% �Ծ����������
[sdist,index]=sort(dist,2);%��dist���н�������
%��ʼ����������
rho=zeros(N,1);
for i=1:N
    d=0;
    for j=1:NaNE+1
        d=d+sdist(i,j);
    end
    rho(i)=(NaNE/d);
end
 [rho_sorted,ordrho]=sort(rho,'descend');%ordrho�����ܶȴӴ�С��˳��
locdatal_core=zeros(N,1);%���n����ľֲ����ĵ�
deltdata=zeros(N,1);%���n����ĵ�deltdata����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�����ܶȴӴ�С��˳��ȥ�������ݵ�׼���ĵ�
for i=1:N
% %         if locdatal_core(ordrho(i))==0
%          mdataxrho=rho(ordrho(i));
%          mdataxindex=ordrho(i);
%          for j=1:Non+1%���k�������ܶ����ĵ���Ϊi����k���ڵĺ��ĵ�
%               if(mdataxrho<rho(index(ordrho(i),j)))
%                    mdataxrho=rho(index(ordrho(i),j));
%                    mdataxindex=index(ordrho(i),j);
%               end
%          end
%     for j=1:Non+1
%         if locdatal_core(index(ordrho(i),j))==0||(locdatal_core(index(ordrho(i),j))~=0&&rho(locdatal_core(index(ordrho(i),j)))<rho(mdataxindex))%dist(index(ordrho(i),j),locdatal_core(index(ordrho(i),j))>dist(index(ordrho(i),j),mdataxindex)))%������㻹û�з�����ĵ�����Ѿ�������ĵ㣬�Ƚ����������ĵ��ĸ��ȽϽ��ͷ��䵽�ĸ����ĵ���
%             locdatal_core(index(ordrho(i),j))=mdataxindex;
%             deltdata(index(ordrho(i),j))=dist(index(ordrho(i),j),mdataxindex);
%             if locdatal_core(mdataxindex)==0%�������ܶȽϴ�ĵ㻹û�з�����ĵ㣬��Ϊ�������ĵ�Ϊ���Լ�
%                 locdatal_core(mdataxindex)=mdataxindex;
%            else%���������Ѿ�������ĵ㣬�Ƚ��������ĵ���ܶȣ�ȡ�ϴ��ܶȵĺ��ĵ���Ϊ���ĵ�
%                if rho(locdatal_core(index(ordrho(i),j)))<rho(mdataxindex)
%            locdatal_core(index(ordrho(i),j))=locdatal_core(mdataxindex);
%            deltdata(index(ordrho(i),j))=dist(index(ordrho(i),j),locdatal_core(mdataxindex));
%                end
%             end
%         end 
%         for m=1:N
%              if locdatal_core(m)==index(ordrho(i),j)
%                  locdatal_core(m)=locdatal_core(index(ordrho(i),j));
%              end
%         end
%          
%     end
% %        end  
% NaNE=1;
         p=ordrho(i);
         mdataxrho=rho(p);
         mdataxindex=p;
         for j=1:NaNE+1%���k�������ܶ����ĵ���Ϊi����k���ڵĺ��ĵ�
             x=index(p,j);
             if mdataxrho<rho(x)
                 mdataxrho=rho(x);
                 mdataxindex=x;
             end
         end
         %�Ծ�������ܶȵĵ����ֲ������
         if locdatal_core(mdataxindex)==0%���������ܶȵ�Ҳû�з�����ĵ�
             locdatal_core(mdataxindex)=mdataxindex; 
         end
         %�õ���p��k���ڵľֲ������
         for j=1:NaNE+1
             if locdatal_core(index(p,j))==0%�����j�����ڻ�û�д����
                 locdatal_core(index(p,j))=locdatal_core(mdataxindex);
             else%�����j�������Ѿ��д�����ˣ�ѡ�����Ͻ���һ���������Ϊ�µĴ����
                 q=locdatal_core(index(p,j));
                 if dist(index(p,j),q)>dist(index(p,j),locdatal_core(mdataxindex))%rho(locdatal_core(mdataxindex))>=rho(q)%
                     locdatal_core(index(p,j))=locdatal_core(mdataxindex);
                 end
             end 
             for m=1:N
                 if locdatal_core(m)==index(p,j)
                     locdatal_core(m)=locdatal_core(index(p,j));
                 end
             end
         end
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�õ�׼���ĵ㣬׼���ĵ���������Ϊ���ĵ�
 cluster_number=0;
 cl=zeros(N,1);
for i=1:N
    if locdatal_core(i)==i;
       cluster_number=cluster_number+1;
       cores(cluster_number)=i;
       cl(i)=cluster_number;
    end
end
disp('��ʼ�Ӵظ���Ϊ��');disp(cluster_number);
% �����ǵó�׼����ֱ�ӵõ����Ӵ�
for i=1:N
    cl(i)=cl(locdatal_core(i));
end

end

