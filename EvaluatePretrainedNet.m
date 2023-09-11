function [confVal,cm,YPTest,YPTestValue,AUCValue,STDError,MAEerror]=EvaluatePretrainedNet(netfTrained,XTest,YTest,thr)

        YPTestValue = netfTrained(XTest');
        YPTest=0;
        for i=1:length(YPTestValue)
            if YPTestValue(i)>thr
                YPTest(i,1)=1;
            else
                YPTest(i,1)=0;
            end
        end
        [c,cm,ind,per] = confusion(YTest(:,1)',YPTest');
        confVal=ConfusionResult(cm');%Specificity, Sensitivity and Accuracy
        AUCValue = AUC(YTest(:,1),YPTestValue);
        STDError=std(YPTestValue-YPTest');
        MAEerror=mae(YPTestValue-YPTest');
end