function locdatal_core=LocdatalRepresentdatatives( data,NaNE )
[N,dim]=size(data);
% 求距离矩阵
dist=pdist2(data,data);
% 对距离进行排序
[sdist,index]=sort(dist,2);%对dist按行进行排序
%初始化基本数据
rho=zeros(N,1);
for i=1:N
    d=0;
    for j=1:NaNE+1
        d=d+sdist(i,j);
    end
    rho(i)=(NaNE/d);
end
 [rho_sorted,ordrho]=sort(rho,'descend');%ordrho就是密度从大到小的顺序
locdatal_core=zeros(N,1);%存放n个点的局部核心点
deltdata=zeros(N,1);%存放n个点的的deltdata距离
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%按照密度从大到小的顺序去发现数据的准核心点
for i=1:N
% %         if locdatal_core(ordrho(i))==0
%          mdataxrho=rho(ordrho(i));
%          mdataxindex=ordrho(i);
%          for j=1:Non+1%求出k近邻中密度最大的点作为i及其k近邻的核心点
%               if(mdataxrho<rho(index(ordrho(i),j)))
%                    mdataxrho=rho(index(ordrho(i),j));
%                    mdataxindex=index(ordrho(i),j);
%               end
%          end
%     for j=1:Non+1
%         if locdatal_core(index(ordrho(i),j))==0||(locdatal_core(index(ordrho(i),j))~=0&&rho(locdatal_core(index(ordrho(i),j)))<rho(mdataxindex))%dist(index(ordrho(i),j),locdatal_core(index(ordrho(i),j))>dist(index(ordrho(i),j),mdataxindex)))%当这个点还没有分配核心点或者已经分配核心点，比较这两个核心点哪个比较近就分配到哪个核心点中
%             locdatal_core(index(ordrho(i),j))=mdataxindex;
%             deltdata(index(ordrho(i),j))=dist(index(ordrho(i),j),mdataxindex);
%             if locdatal_core(mdataxindex)==0%如果这个密度较大的点还没有分配核心点，就为其分配核心点为它自己
%                 locdatal_core(mdataxindex)=mdataxindex;
%            else%如果这个点已经分配核心点，比较两个核心点的密度，取较大密度的核心点作为核心点
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
         for j=1:NaNE+1%求出k近邻中密度最大的点作为i及其k近邻的核心点
             x=index(p,j);
             if mdataxrho<rho(x)
                 mdataxrho=rho(x);
                 mdataxindex=x;
             end
         end
         %对具有最大密度的点分配局部代表点
         if locdatal_core(mdataxindex)==0%如果该最大密度点也没有分配核心点
             locdatal_core(mdataxindex)=mdataxindex; 
         end
         %得到点p的k近邻的局部代表点
         for j=1:NaNE+1
             if locdatal_core(index(p,j))==0%如果第j个近邻还没有代表点
                 locdatal_core(index(p,j))=locdatal_core(mdataxindex);
             else%如果第j个近邻已经有代表点了，选择距离较近的一个代表点作为新的代表点
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
%得到准核心点，准核心点以其自身为核心点
 cluster_number=0;
 cl=zeros(N,1);
for i=1:N
    if locdatal_core(i)==i;
       cluster_number=cluster_number+1;
       cores(cluster_number)=i;
       cl(i)=cluster_number;
    end
end
disp('初始子簇个数为：');disp(cluster_number);
% 以下是得出准核心直接得到的子簇
for i=1:N
    cl(i)=cl(locdatal_core(i));
end

end

