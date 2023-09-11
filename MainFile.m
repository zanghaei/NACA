%                         In the name of God
% Dear user
% If you find my paper suitable, please, use the following citation:
% Please for any question contact me (please email both the address):
% zanghaei@sbmu.ac.ir
% a-zanghaei@alumnus.tums.ac.ir
%% loading your data file
clc
clear all
close all
%Pot your own path and file name here
PathStr='E:\RenalSurvival2023\GitHub\';
FileName='Example.xlsx';
cd(PathStr);
FullPathStr=[PathStr,FileName];
[XAll,YAll,VarNames,BestStepSize,TypeValue,X0,Y0,XYpairs,TargetVar]=ReadData2(FullPathStr,'Exist',3,'Default',2,'BestStepSize',4,'Type',5);

% if you are not familiar with the template you can use the following
% simple code to upload your data
% [mdata,VarNames,alldata]=xlsread(FullPathStr);
% X=mdata(2:end, 1:21);
% Y=mdata(2:end, 22);

VarNamesT=VarNames';
X=X0;
Y=Y0;



%The following line is arbitrary
% [X,Y]=MakeTwoClassesSameSizeNew(X,(Y));


%% ============================ Find Optimum Threshold
% ThrStart=0.1;
% ThrStep=.05;
% ThrEnd=0.9;
%nUMBER OF Runs=3
[meanFitResultFigure,CellResFigure,ThresholdOptimomFigure]=ThresholdOptimomFitting(X,Y,0.1,.05,0.9,3);


%% ============================== Train your own network
threshold=0.25;

NeuralNetworksPredictionCrossValidationCell={};
NCrossValidation=20;
for i=1:NCrossValidation
disp(['Cross validation=',num2str(i),' of ',num2str(NCrossValidation)])
[X1,Y1]=RandomizeXY(X,Y);
    [NNPerformance,NNPerformanceMean]=NeuralNetworksPrediction2(X1,Y1,length(VarNames)-1,threshold,3);
    NeuralNetworksPredictionCrossValidationCell{i,1}=NNPerformance;
    NeuralNetworksPredictionCrossValidationCell{i,2}=NNPerformanceMean;
    NeuralNetworksPredictionCrossValidationMat(i,:)=NNPerformanceMean;
end
NeuralNetworksPredictionCrossValidationMat(i+1,:)=mean(NeuralNetworksPredictionCrossValidationMat);

%% ====================== Use Pretrained ANN Network and test it
%E:\RenalSurvival2023\GitHub\TrainedNets
%load '14020518temp'
NCrossValidation=20;
TrainRatio=0.8;
threshold=0.25;
PreTrainPath=[PathStr,'TrainedNets'];
for i=1:NCrossValidation
    disp(['Cross validation=',num2str(i),' of ',num2str(NCrossValidation)])
    [X1,Y1]=RandomizeXY(X,Y);
    [XTrain,YTrain,XTest,YTest]=ChooseTest(X1,Y1,TrainRatio);
    [SsaAucStdMae,MeanSsaAucStdMae]=EvaluatePretrainedNetAll(XTest,YTest,threshold,300,PreTrainPath);
    NeuralNetworksPredictionCrossValidationCell{i,1}=SsaAucStdMae;
    NeuralNetworksPredictionCrossValidationCell{i,2}=MeanSsaAucStdMae;
    NeuralNetworksPredictionCrossValidationMat(i,:)=MeanSsaAucStdMae;
end
NeuralNetworksPredictionCrossValidationMat(i+1,:)=mean(NeuralNetworksPredictionCrossValidationMat);


%% =========================================  LOFO Method 
[PridicPowerRed1]=LOFONeuralNetworksThreshold2(X,Y,length(VarNames)-1,20,VarNames,0.25);

