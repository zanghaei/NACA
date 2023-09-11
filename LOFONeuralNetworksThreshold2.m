function [PridicPowerRed]=LOFONeuralNetworksThreshold2(X,Y,hiddenLayerSize1,NtryMain,VarNames,threshold)
% This function is LOFO Method By Neural Networkd
Ind=0;
% thrStart=.15;
% thrstep=0.02;
% thrEnd=0.25;
%NtryFeature
VarNames0=VarNames;
% [meanFitResult,CellRes,ThresholdOptimom]=ThresholdOptimomFitting(XR,YR,thrStart,thrstep,thrEnd,NtryFeature);
% threshold=ThresholdOptimom;

% [PridicPowerMain0,PridicPower,MeanPridicPowerMain]=PredictionPower(XR,YR,hiddenLayerSize1,threshold,NtryMain,NtryFeature);
[SsaAucStdMae,MeanSsaAucStdMae]=NeuralNetworksPrediction2(X,Y,hiddenLayerSize1,threshold,NtryMain);

k=1;
PridicPowerRed{k,1}=k;
PridicPowerRed{k,2}='All';
PridicPowerRed{k,3}=MeanSsaAucStdMae;
% PridicPowerRed{k,5}=MeanPridicPowerMain(3);
% PridicPowerRed{k,6}=MeanPridicPowerMain(4);
L=size(X,2);
for ind=1:L
    disp(['Feature ',num2str(ind),' of ',' ',num2str(L)]);
    k=k+1;
    [XR,YR]=RandomizeXY(X,Y);
    XR=RemoveColumn(XR,ind);
    [SsaAucStdMae,MeanSsaAucStdMae]=NeuralNetworksPrediction2(XR,YR,size(XR,2),threshold,NtryMain);%??????
    PridicPowerRed{k,1}=k;
    PridicPowerRed{k,2}=VarNames{ind};
    PridicPowerRed{k,3}=MeanSsaAucStdMae;

%     if k>=3
%         [meanFitResult,CellRes,ThresholdOptimom]=ThresholdOptimomFitting(XR,YR,thrStart,thrstep,thrEnd,NtryFeature);
%         threshold=ThresholdOptimom;
%         [PridicPowerMain,PridicPower,MeanPridicPowerMain]=PredictionPower(XR,YR,hiddenLayerSize1,threshold,0,NtryFeature);
%     end
%     ind=min(find(PridicPower(:,5)==min(PridicPower(:,5))));
%     PridicPowerRed{k,1}=k;
% %     try
%         PridicPowerRed{k,2}=VarNames{ind};
% %     catch
% %         jj=212
% %     end
%     PridicPowerRed{k,3}=IndexFinder(VarNames0,VarNames{ind});
%     PridicPowerRed{k,4}=PridicPower(ind,2);
%     PridicPowerRed{k,5}=PridicPower(ind,3);
%     PridicPowerRed{k,6}=PridicPower(ind,4);
%     PridicPowerRed{k,7}=min(PridicPower(:,5));
%     XR=RemoveColumn(XR,ind);
%     VarNamesTem=VarNames;
%     VarNames=[];
%     m=1;
%     for j=1:length(VarNamesTem)
%         if j~=ind
%             VarNames{m}=VarNamesTem{j};
%             m=m+1;
%         end
%     end
end


end
