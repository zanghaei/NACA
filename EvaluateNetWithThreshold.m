function [confVal,cm,YPTest,YPTestValue,AUCValue,STDError,MAEerror]=EvaluateNetWithThreshold(netf,XTrain,YTrain,XTest,YTest,thr)
%global GlobalCounter;        
netfTrained = train(netf,XTrain',YTrain(:,1)');
        YPTestValue = netfTrained(XTest');
        %save(['TrainedNet', num2str(GlobalCounter)],'netfTrained')
        %GlobalCounter=GlobalCounter+1;
        YPTest=0;
        for i=1:length(YPTestValue)
            if YPTestValue(i)>thr
                YPTest(i,1)=1;
            else
                YPTest(i,1)=0;
            end
        end
        [c,cm,ind,per] = confusion(YTest(:,1)',YPTest');
        %plotconfusion(YTest(:,1)',YPTest');
%         plotroc(YTest(:,1)',YPTestValue);
        confVal=ConfusionResult(cm');%Specificity, Sensitivity and Accuracy
        AUCValue = AUC(YTest(:,1),YPTestValue);
        %plotroc(YTest(:,1)',YPTestValue);
        %title(['AUC=',num2str(AUCValue)])
        STDError=std(YPTestValue-YPTest');
        MAEerror=mae(YPTestValue-YPTest');
end