function [B,Ind]=Randomize(A)
L=size(A,1);
Ind=randsample(1:L,L);
B=A(Ind,:);
end

% load('fisheriris');
% CVO = cvpartition(species,'k',10);
% err = zeros(CVO.NumTestSets,1);
% for i = 1:CVO.NumTestSets
%     trIdx = CVO.training(i);
%     teIdx = CVO.test(i);
%     ytest = classify(meas(teIdx,:),meas(trIdx,:),...
% 		 species(trIdx,:));
%     err(i) = sum(~strcmp(ytest,species(teIdx)));
% end
% cvErr = sum(err)/sum(CVO.TestSize);
% CVO.display
% CVO.disp
% CVO.repartition
% n=100
% y = randsample(1:n,n)
% ys=sort(y)
% plot(ys)
% 
% A = randn(5,5)
% Y = datasample(A,5,2,'Replace',false)
% 
