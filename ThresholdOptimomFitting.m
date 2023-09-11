function [meanFitResult,CellRes,ThresholdOptimom]=ThresholdOptimomFitting(X,Y,TheStart,ThrStep,ThrEnd,Ntry)
TrainPercent=.8;
% ThrStart=0.5;
% ThrStep=.02;
% ThrEnd=0.9;

hiddenLayerSize=size(X,2);
netf = fitnet(hiddenLayerSize-0,'trainbr');%Training function name:Bayesian Regularization
netf.divideParam.trainRatio = 90/100;
netf.divideParam.valRatio = 10/100;
netf.divideParam.testRatio = 0/100;
netf.trainParam.epochs=70;
% net.layers{1}.transferFcn='logsig';
% net.layers{2}.transferFcn='logsig';
netf.trainParam.goal=1e-200;
netf.trainParam.max_fail=200;
netf.trainParam.min_grad=1e-50;
netf.trainParam.showWindow=0;
clear confValMatrix;
clear meanFitResult;
clear FitResult;
%Phase one effect of regression 
[XTrain,YTrain,XTest,YTest]=ChooseTest(X,Y,TrainPercent);
netf1 = train(netf,X',Y(:,1)');
ypf = netf1(X');
figure;
hist(ypf(1,:),200)
title('Histogram of Neural Network Output of Total Data');
xlabel('Output Value')
ylabel('Number')

k=1;
Sold=newline;
disp(['ThresholdOptimomFitting Started',newline])
for thr=TheStart:ThrStep:ThrEnd
    Snew=['ThresholdOptimomFitting=>>',num2str(thr/ThrEnd)];
    Sold=PrintInOneLine(Sold,Snew);
    FitResult=[];
    confValMatrix=[];
    AUCMatrix=[];
    for ii=1:Ntry
        [XTrain,YTrain,XTest,YTest]=ChooseTest(X,Y,TrainPercent);%ChooseTestAll
        [confVal,cm,YPTest,~,AUCValue]=EvaluateNetWithThreshold(netf,XTrain,YTrain,XTest,YTest,thr);
        %confVal=ConfusionResult(cm);
        FitResult(ii,:)=[thr,confVal];
        confValMatrix(ii,:)=confVal;
        AUCMatrix(ii)=AUCValue;
    end
    meanFitResult(k,:)=[thr,mean(confValMatrix,1),mean(AUCMatrix)];%mean of columns of confValMatrix
    CellRes{k}=FitResult;
    k=k+1;
end

meanFitResult;
B=abs(meanFitResult(:,3)'-meanFitResult(:,2)');
A=meanFitResult(:,1)';
ThresholdOptimom=minx(A,B);
[confVal,cm,YPTest,YPTestValue,AUCValue]=EvaluateNetWithThreshold(netf,XTrain,YTrain,XTest,YTest,ThresholdOptimom);
figure
plotroc(YTest',YPTestValue);
% [tpr,fpr,thresholds] = roc(YTest',YPTestValue);
% % figure
% % plot(tpr,1-fpr)
% AUC = trapz(tpr,1-fpr);
%AUCValue = AUC(YTest,YPTestValue);
title(['ROC Cureve on Test Data, AUC=',num2str(AUCValue)]);
axis equal
figure;

hist(YPTestValue(1,:),100)
title('Histogram of Neural Network Output of Test Data');
xlabel('Output Value')
ylabel('Number')

figure
plot(meanFitResult(:,1),100*meanFitResult(:,2:4),'linewidth',4)
title('Specificity and sensitivity versus threshold','fontsize',18);
xlabel('Threshold','fontsize',20);
ylabel('percentage','fontsize',20);
legend('Specificity','Sensitivity','Accuracy','fontsize',18);
%disp(['ThresholdOptimomFitting Completed',newline])

figure
plot(meanFitResult(:,1),meanFitResult(:,5),'linewidth',4)
title('Plot of AUC','fontsize',18);
xlabel('Threshold','fontsize',20);
ylabel('AUC Value','fontsize',20);
%legend('Specificity','Sensitivity','Accuracy','fontsize',18);

disp(['ThresholdOptimomFitting Completed',newline])
end