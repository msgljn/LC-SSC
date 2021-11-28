function [L,t]=ST_SFCM(label_x,label_x_t,unlabel_x,th1)
%% The input paramters of the alogrithm
L=label_x;                 %已标记数据
U=unlabel_x;               %未标记数据
t=label_x_t;              %已标记数据的类别
count=1;                   %迭代次数
%% run the alogrithm
record_size_U(count)=size(U,1);  % 记录当前无标记池中的样本数目
while 1  
    %%
    newU=[];
    newU=U;             %准备分类的无标签数据集放入newU池中
    %%
    if size(U,1)==0
        break;
    end
    %% SSFCmeans
    Pro1=[];label1=[];
    Pro2=[];label2=[];
    [Pro1,Pro2,label1,label2]=SSFCmeans(newU,L,t,2);
    %聚类后选出置信度高的
    choose_index=find(Pro2>=th1);
    otherIndex=find(Pro2<th1);
    classifyU=newU(choose_index,:);
    temp_th1=th1;
    while length(choose_index)==0
        temp_th1=temp_th1-0.1;
        choose_index=find(Pro2>=temp_th1);
        otherIndex=find(Pro2<temp_th1);
        classifyU=newU(choose_index,:);
        if temp_th1<=0
            classifyU=newU;
            otherIndex=[];
            break;
        end
    end
    KNN_index=KNNC(L,t,classifyU,3);
    %% 3) 判断这个分类是否可靠
    pos1=[1:1:size(classifyU,1)];
    addU=classifyU(pos1,:);
    pos2=[];
    % 5)adding the new datasets wiht new labels, promoting the classification
    L=[L;addU];
    t=[t;KNN_index(pos1)];
    U=[];
    U=[U;classifyU(pos2,:);newU(otherIndex,:)];
    count=count+1;
    record_size_U(count)=size(U,1);
    if count>2
        if record_size_U(count)==record_size_U(count-1) && record_size_U(count)==record_size_U(count-2)
           break;
        end
    end
end
end