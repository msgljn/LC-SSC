function [Improved_L,Improved_L_t,Improved_U,Improved_U_t,localcore]=LC_SSC(data,t,L,L_t)
%% LC-SSC Framework with Active labeling
%% (1) NaN_Search
[NaNs,NaNE,nb]=NaN_Search(data);
%% (2) Find local cores
localcore=LocalRepresentatives(data,max(nb));
L_idx=[1:1:length(L_t)]; %有标记样本的序号
%% (3) 只保留无标记样本簇中的局部核心
NC=unique(localcore(L_idx));
core=unique(localcore);
% 核心点：只需要保留无标记样本簇中的代表点； 改进的有标记样本就是L+core
core=unique(setdiff(core,NC));
% 改进的无标记样本就是非核心点，且是无标记样本
Non_core=setdiff([1:1:size(data,1)],core);
Non_core=setdiff(Non_core,L_idx);
%% (4)合并
core=unique(core);
core_data=data(core,:);
%%  注意，这里采取主动标记去预测Core的类标签，如果是协同标记，可以用KNN,Cart，Neural Network，SVM去预测它的类标签
core_t=t(core);
%%
Improved_L=[L;core_data];
Improved_L_t=[L_t;core_t];
Improved_U=data(Non_core,:);
Improved_U_t=t(Non_core);
end

