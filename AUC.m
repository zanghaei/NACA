function AUCValue = AUC(YTest,YPTestValue)
YTest=Force2ColumnShape(YTest);
YPTestValue=Force2ColumnShape(YPTestValue);
[tpr,fpr,thresholds] = roc(YTest',YPTestValue');
AUCValue = trapz(fpr,tpr);
%AUCValue = AUCValue/(max(fpr)*max(tpr));
% AUC = trapz(fpr,tpr)
% plot(fpr,tpr)
% AUC = trapz(fpr,tpr);
% if AUCValue<0.8
%     plot(fpr,tpr,'*')
% end
