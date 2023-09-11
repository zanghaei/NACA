function [SsaAucStdMae,MeanSsaAucStdMae]=NeuralNetworksPrediction2(XR,YR,hiddenLayerSize1,threshold,NtryMain)
%SsaAucStdMae = Spedificity Sensitivity Accuracy
%hiddenLayerSize1 = length(EssVar)-1-0;
%[x,t] = simplefit_dataset;
netf = fitnet(hiddenLayerSize1-0,'trainbr');%trainlm%trainbr%traingdx%trainbfg
netf.divideParam.trainRatio = 90/100;
netf.divideParam.valRatio = 10/100;
netf.divideParam.testRatio = 0/100;
netf.trainParam.epochs=70;
% netf.layers{1}.transferFcn='logsig';
% netf.layers{2}.transferFcn='logsig';
netf.trainParam.goal=1e-200;
netf.trainParam.max_fail=70;
netf.trainParam.min_grad=1e-50;
netf.trainParam.showWindow=0;
TrainRatio=.8;

XRC=XR;
for k=1:NtryMain%10
    disp(['NeuralNetworksPrediction ',num2str(k),' of ',' ',num2str(NtryMain)]);
    %[XRTain1,YRTain1,XRTest1,YRTest1]=ChooseTestNoRandom(XRC,YR,TrainRatio);
    [XTrain,YTrain,XTest,YTest]=ChooseTest(XRC,YR,TrainRatio);
%     confValMatrix=0;
% 
%     netf1 = train(netf,XRTain1',YRTain1(:,1)'); %This the ipmortatn step train the network
%     ypf1 = netf1(XRTest1');
%     for i=1:length(ypf1)
%         if ypf1(i)<threshold
%             YPTest1(i,1)=0;
%         else
%             YPTest1(i,1)=1;
%         end
%     end
%     [c1,cm1,ind1,per1] = confusion(YRTest1(:,1)',YPTest1');
%     icm1=cm1';%inverse_cm;
%     confVal1=ConfusionResult(icm1);
%     confValMatrix(i,1:3)=confVal1;
%     %meanFitResult(k,:)=[thr,mean(confValMatrix)];
%     [confVal,cm,YPTest,YPTestValue,AUCValue]=EvaluateNetWithThreshold(netf,XRTain1,YRTain1,XRTest1,YRTest1,threshold);
%     %AUCValue = AUC(YRTest1(:,1)',YPTestValue);
%     %PridicPowerMain(k,1:6)=[k,mean(confValMatrix,1),std(ypf1-YPTest1'), mae(ypf1-YPTest1')];
%     PridicPowerMain(k,1:6)=[k,mean(confValMatrix,1),std(ypf1-YPTest1'), mae(ypf1-YPTest1')];
    [confVal,cm,YPTest,YPTestValue,AUCValue,STDError,MAEerror]=EvaluateNetWithThreshold(netf,XTrain,YTrain,XTest,YTest,threshold);
    SsaAucStdMae(k,1:7)=[k,confVal,AUCValue,STDError,MAEerror];

end
MeanSsaAucStdMae=mean(SsaAucStdMae,1);
%return 14020520
% clear confValMatrix1;
% clear meanFitResult1;
% clear FitResult1;
% L=size(XR,2);
% YPTest1=0;
% PridicPower=0;
% for c=1:L
%     disp(['Feature  ',num2str(c),' of ',num2str(L)]);
%     %c/L
%     %TrainPercent=.8;
%     %Phase one effect of regression
%     XRC=RemoveColumn(XR,c);
%     %XRC=XR;
%     [XRTain1,YRTain1,XRTest1,YRTest1]=ChooseTest(XRC,YR,TrainRatio);
%     confValMatrix=0;
%     for ii=1:NtryFeature%10
%         netf1 = train(netf,XRTain1',YRTain1(:,1)');
%         ypf1 = netf1(XRTest1');
%         for i=1:length(ypf1)
%             if ypf1(i)<threshold
%                 YPTest1(i,1)=0;
%             else
%                 YPTest1(i,1)=1;
%             end
%         end
%         
%         [c1,cm1,ind1,per1] = confusion(YRTest1(:,1)',YPTest1');
%         icm1=cm1';%inverse_cm;
%         confVal1=ConfusionResult(icm1);
%         confValMatrix(ii,1:3)=confVal1;
%     end
%     %meanFitResult(k,:)=[thr,mean(confValMatrix)];
%     PridicPower(c,1:4)=[c,mean(confValMatrix,1)];
% end
% %PridicPower
end
