function [confVal,PrevalenceRatio]=ConfusionResult(icm)
%confVal Result in : Specificity, Sensitivity and Accuracy
%onfVal [Specificity, Sensitivity , Accuracy]
%Assumes the First Column is Healthy or 0 and Second Column is Sick or 1
%PrevalenceRatio=[RealPrevalenceRatio,EstimatedPrevalenceRatio];
confVal=[icm(1,1)/sum(icm(:,1)),icm(2,2)/sum(icm(:,2)),(icm(1,1)+icm(2,2))/sum(sum(icm))];

RealPrevalenceRatio=sum(icm(:,2))/sum(sum(icm));
EstimatedPrevalenceRatio=sum(icm(2,:))/sum(sum(icm));
PrevalenceRatio=[RealPrevalenceRatio,EstimatedPrevalenceRatio];

end