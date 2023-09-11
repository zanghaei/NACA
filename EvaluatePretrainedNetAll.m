function [SsaAucStdMae,MeanSsaAucStdMae]=EvaluatePretrainedNetAll(XTest,YTest,threshold,NtryMain,PreTrainPath)
%SsaAucStdMae = Spedificity Sensitivity Accuracy


for k=1:NtryMain%10
    %disp(['Counter ',num2str(k),' of ',' ',num2str(NtryMain)]);
    load([PreTrainPath,'\TrainedNet', num2str(k)],'netfTrained');

    [confVal,cm,YPTest,YPTestValue,AUCValue,STDError,MAEerror]=EvaluatePretrainedNet(netfTrained,XTest,YTest,threshold);
    SsaAucStdMae(k,1:7)=[k,confVal,AUCValue,STDError,MAEerror];

end
MeanSsaAucStdMae=mean(SsaAucStdMae,1);

end
