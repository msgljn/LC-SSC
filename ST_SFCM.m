function [L,t]=ST_SFCM(label_x,label_x_t,unlabel_x,th1)
%% The input paramters of the alogrithm
L=label_x;                 %�ѱ������
U=unlabel_x;               %δ�������
t=label_x_t;              %�ѱ�����ݵ����
count=1;                   %��������
%% run the alogrithm
record_size_U(count)=size(U,1);  % ��¼��ǰ�ޱ�ǳ��е�������Ŀ
while 1  
    %%
    newU=[];
    newU=U;             %׼��������ޱ�ǩ���ݼ�����newU����
    %%
    if size(U,1)==0
        break;
    end
    %% SSFCmeans
    Pro1=[];label1=[];
    Pro2=[];label2=[];
    [Pro1,Pro2,label1,label2]=SSFCmeans(newU,L,t,2);
    %�����ѡ�����Ŷȸߵ�
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
    %% 3) �ж���������Ƿ�ɿ�
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