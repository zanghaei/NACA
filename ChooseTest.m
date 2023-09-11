function [Xtrain,Ytrain,Xtest,Ytest]=ChooseTest(X,Y,TrainPercent)
%X and Y Must Be VollumnWise
[X,Y]=RandomizeXY(X,Y);
LTrain=ceil(TrainPercent*size(X,1));
LTest=size(X,1)-LTrain;
Half_LTest=ceil(.5*LTest);
YtestN=[];YtestP=[];
Xtest=[];XtestN=[];
k=1;
j=1;
f=0;
for i=1:size(X,1)
    f=0;
    if Y(i,1)==1 && k<=Half_LTest
        XtestP(k,:)=X(i,:);
        YtestP(k,:)=Y(i,:);
        FlagX(i)=1;
        f=1;
        k=k+1;
    end
    if Y(i,1)==0 && j<=Half_LTest
        XtestN(j,:)=X(i,:);
        YtestN(j,:)=Y(i,:);
        FlagX(i)=1;
        f=1;
        j=j+1;
    end
    if f==0
        FlagX(i)=0;
    end
end
Ytest=[YtestN;YtestP];
Xtest=[XtestN;XtestP];
% sum(FlagX)
% sum(Ytest)
k=1;
for i=1:size(X,1)
    if FlagX(i)==0
        Xtrain(k,:)=X(i,:);
        Ytrain(k,:)=Y(i,:);
        k=k+1;
    end
end
[Xtest,Ytest]=RandomizeXY(Xtest,Ytest);
[Xtrain,Ytrain]=RandomizeXY(Xtrain,Ytrain);

% sum(Ytrain)
end
