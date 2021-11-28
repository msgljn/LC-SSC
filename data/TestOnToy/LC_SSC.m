function LC_SSC(data,t,L,L_t)
%% LC-SSC Framework
clc
clear all
close all
%%
load data data
load t t
pos1=find(t==1);
pos2=find(t==2);
Number_L=5;
L=[data(pos1(1:Number_L),:);data(pos2(1:Number_L),:)];
L_t=[t(pos1(1:Number_L));t(pos2(1:Number_L))];
U=[data(pos1(Number_L+1:end),:);data(pos2(Number_L+1:end),:)];
U_t=[t(pos1(Number_L+1:end));t(pos2(Number_L+1:end))];
Plot_data( L,L_t,1,'a')
hold on
plot(U(:,1),U(:,2),'o','color','black','markersize',2);
%% (1) NaN_Search
[NaNs,NaNE,nb]=NaN_Search(data);
%% (2) Find local cores
localcore=LocalRepresentatives(data,max(nb));
L_idx=[1:1:length(L_t)]; %有标记样本的序号
%% (3)去重复: 前面是有标记样本，如果Core的指数有在有标记样本里面的，就不要
NC=unique(localcore(L_idx));
NC
core=unique(localcore);
hold on
plot(data(core,1),data(core,2),'p','color','red','markersize',5,'markerfacecolor','red');
size(core)
% 核心点：只需要保留无标记样本簇中的代表点； 改进的有标记样本就是L+core
core=unique(setdiff(core,NC));
size(core)
% 改进的无标记样本就是非核心点，且是无标记样本
Non_core=setdiff([1:1:size(data,1)],core);
Non_core=setdiff(Non_core,L_idx);
%% (4)合并
core=unique(core);
core_data=data(core,:);
core_t=t(core);
size(core_data)
Plot_data( L,L_t,2,'b')
hold on
plot(U(:,1),U(:,2),'o','color','black','markersize',2);
hold on
plot(core_data(:,1),core_data(:,2),'p','color','red','markersize',5,'markerfacecolor','red');
%%
Improved_L=[L;core_data];
Improved_L_t=[L_t;core_t];
Improved_U=data(Non_core,:);
Improved_U_t=t(Non_core);

Plot_data( Improved_L,Improved_L_t,3,'c')
hold on
plot(Improved_U(:,1),Improved_U(:,2),'o','color','black','markersize',2);
end

