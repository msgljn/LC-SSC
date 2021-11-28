function  CompareOnRealdata( )
%% clear screen
clc
clear all
close all
%% load dataset
load data\SomeRealData\Wine\data
load data\SomeRealData\Wine\t
%%
ratio=0.01; % percentage of labeled sample in training set，通常为百分之1
indices = crossvalind('Kfold',size(data,1),10); % 10-fold cross-validatiob
%% 
D=sort(pdist2(data,data),'ascend');
NTr=round(length(t)*(1-ratio)); % NTr is the number of samples in the training set 
index=floor(NTr*2);
Dc=D(index);
for i=1:10
    [ labeled_x,labeled_x_t,unlabeled_x,unlabeled_x_t,TestSet,TestSet_Label,TrainingSet,TrainingSet_Label ] = Produce_SSL_DataSet( data,t,indices,i,ratio);
    fprintf('----------%gth experiment----------\n',i)
    fprintf('-----The sample number of employed real data set：%g\n',length(t))
    fprintf('-----The sample number of L：%g\n-----the sample number of U：%g\n-----the sample number of test：%g\n',length(labeled_x_t),length(unlabeled_x_t),length(TestSet_Label))
    %% STSFCM
    [L,L_t]=ST_SFCM(labeled_x,labeled_x_t,unlabeled_x,1/length(unique(labeled_x_t)));
    index=KNNC(L,L_t,TestSet,3);
    Test_Accuracy1(i)=sum(TestSet_Label==index)/size(TestSet_Label,1);
    %% STDP
    [L,L_t]=STDP(labeled_x,labeled_x_t,unlabeled_x,unlabeled_x_t,Dc);
    index=KNNC(L,L_t,TestSet,3);
    Test_Accuracy2(i)=sum(TestSet_Label==index)/size(TestSet_Label,1);
    %% LC-SSC
    [Improved_L,Improved_L_t,Improved_U,Improved_U_t,localcore]=LC_SSC([labeled_x;unlabeled_x],[labeled_x_t;unlabeled_x_t],labeled_x,labeled_x_t);
    %% STSFCM with LC-SSC
    [L,L_t]=ST_SFCM(Improved_L,Improved_L_t,Improved_U,1/length(unique(labeled_x_t)));
    index=KNNC(L,L_t,TestSet,3);
    Test_Accuracy3(i)=sum(TestSet_Label==index)/size(TestSet_Label,1);
    %% STDP with LC-SSC
    [L,L_t]=STDP(Improved_L,Improved_L_t,Improved_U,Improved_U_t,Dc);
    index=KNNC(L,L_t,TestSet,3);
    Test_Accuracy4(i)=sum(TestSet_Label==index)/size(TestSet_Label,1);
end
fprintf('----------------------------------------Experimental Result----------------------------------------\n')
fprintf('Average Accuracy of STSFCN:\t%g\n',mean(Test_Accuracy1)*100)
fprintf('Average Accuracy of STDP:\t%g\n',mean(Test_Accuracy2)*100)
fprintf('Average Accuracy of STSFCN:\t%g\n',mean(Test_Accuracy3)*100)
fprintf('Average Accuracy of STDP:\t%g\n',mean(Test_Accuracy4)*100)


end

