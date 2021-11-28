function [Improved_L,Improved_L_t,Improved_U,Improved_U_t,localcore]=LC_SSC(data,t,L,L_t)
%% LC-SSC Framework with Active labeling
%% (1) NaN_Search
[NaNs,NaNE,nb]=NaN_Search(data);
%% (2) Find local cores
localcore=LocalRepresentatives(data,max(nb));
L_idx=[1:1:length(L_t)]; %�б�����������
%% (3) ֻ�����ޱ���������еľֲ�����
NC=unique(localcore(L_idx));
core=unique(localcore);
% ���ĵ㣺ֻ��Ҫ�����ޱ���������еĴ���㣻 �Ľ����б����������L+core
core=unique(setdiff(core,NC));
% �Ľ����ޱ���������ǷǺ��ĵ㣬�����ޱ������
Non_core=setdiff([1:1:size(data,1)],core);
Non_core=setdiff(Non_core,L_idx);
%% (4)�ϲ�
core=unique(core);
core_data=data(core,:);
%%  ע�⣬�����ȡ�������ȥԤ��Core�����ǩ�������Эͬ��ǣ�������KNN,Cart��Neural Network��SVMȥԤ���������ǩ
core_t=t(core);
%%
Improved_L=[L;core_data];
Improved_L_t=[L_t;core_t];
Improved_U=data(Non_core,:);
Improved_U_t=t(Non_core);
end

