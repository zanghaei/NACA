function [XAll,YAll,VarNames,BestStepSize,Type,Xdef,Ydef,XYpairs,TargetVar,IndVarNames,TypeInd]=ReadData(varargin)
%990516
%Important Just Xdef and Ydef Replaces NAN by default
%[X,Y,VarNames,BestStepSize,TypeValue,Xdef,Ydef,XYpairs,TargetVar]=ReadData(FullPathStr,'Exist',3,'Default',2,'BesStepSize',4,'Type',5);
% [X,Y,VarNames,TargetVar]=ReadData(FullPathStr)
% [X,Y,VarNames,TargetVar]=ReadData(FullPathStr,'Exist',ExistRow,'Default,DefaultRow')
%first row: VarName
%second row: Default Value
%Third row:Existans Value
%Exist Default
TargetVar='';
IsInMatrixFalag=0;
DefaultFlag=0;
JustDataFalag=0;
BestStepSizeFalag=0;
BestStepSizeRow=0;
DefaultRow=0;
ExistRow=0;
NumberOfBiasRow=0;
TypeFalag=0;
% if nargin==1
FullPathStr=varargin{1};
i=1;
while i<=nargin
    if strcmp(varargin{i},'Default')
        DefaultFlag=1;
        DefaultRow=varargin{i+1};
        %         NumberOfBiasRow=2;%minuse on
    end
    if strcmp(varargin{i},'Exist')
        IsInMatrixFalag=1;
        ExistRow=varargin{i+1};
        %          NumberOfBiasRow=2;%minuse on
    end
    if strcmp(varargin{i},'BesStepSize')
        BestStepSizeFalag=1;
        BestStepSizeRow=varargin{i+1};
        %          NumberOfBiasRow=2;%minuse on
    end
    if strcmp(varargin{i},'Type')
        TypeFalag=1;
        TypeRow=varargin{i+1};
        %          NumberOfBiasRow=2;%minuse on
    end
    
    if strcmp(varargin{i},'JustData')
        JustDataFalag=1;
    end
    i=i+1;
end
if JustDataFalag==1 &&(IsInMatrixFalag+DefaultFlag)>=1
    error('With JustData you cannot input any arguments.')
end
if JustDataFalag==1 || nargin==1
    if JustDataFalag==1
        [mdata,VarNames,alldata]=xlsread(FullPathStr);
        N_EssVar=length(VarNames);
        for i=1:N_EssVar
            X(:,i)=alldata(2:end,i);
        end
        Y=alldata(2:end,N_EssVar);
        return
        
    end
    [mdata,VarNames,alldata]=xlsread(FullPathStr);
    N_EssVar=length(VarNames);
    for i=1:N_EssVar
        VarNames{i}=alldata{1,i};
        X(:,i)=mdata(2:end,i);
    end
    Y=mdata(2:end,N_EssVar);
    return
end
% NumberOfBiasRow=BestStepSizeFalag+IsInMatrixFalag+DefaultFlag+TypeFalag;
NumberOfBiasRow=max([DefaultRow,ExistRow,BestStepSizeRow,TypeRow]);
%990123
[mdata,VarNamesTotal,alldata]=xlsread(FullPathStr);
if (size(alldata,1)-size(mdata,1))~=1
    warning('Please See the ReadData function. Your first Row MUST Be Just Names and No Number. Other Wase Change The i in This Function');
    %uiwait(mi);
    %close(mi);
    %return
end
TotalVar=alldata(1,:);
num_var=length(TotalVar);
IsInMatrix(1:num_var)=NaN;
if IsInMatrixFalag==1
    IsInMatrix=alldata(ExistRow,:);
end
%BestStepSize(1:num_var)=NaN;

disp('Loading Data...');
clear Y0
k=1;
kt=1;%target
kf=1;%feature;
TargetVarIndex=0;%Matrix of Target Inices
FeatureVarIndex=0;%Matrix of Feutre Inices
XYAll=0;
for  j=1:num_var
    j/num_var;
    VarNamesTotal{1,j};
    if(IsInMatrix{j}==1) || IsInMatrix{j}==2 || IsInMatrixFalag==0
        VarNames{k}=VarNamesTotal{1,j};
        if BestStepSizeFalag==1 %&& (IsInMatrix{j}==1) || IsInMatrix{j}==2
            BestStepSize(k)=mdata(BestStepSizeRow-1,j);
        else
            BestStepSize(k)=NaN;
        end
        
        if TypeFalag==1 && IsInMatrix{j}~=2%&& (IsInMatrix{j}==1) Must non be target
            Type(k)=mdata(TypeRow-1,j);
        else
            Type(k)=NaN;
        end
       
        if IsInMatrix{j}==2
            TargetVarIndex(kt)=k;
            TargetVar{kt}= VarNames{k};
            kt=kt+1;
        else
            FeatureVarIndex(kf)=k;
            kf=kf+1;
        end
        counter=1;
        for i=NumberOfBiasRow+1-1:size(mdata,1)%umberOfBiasRow+1
            XYAll(counter,k)=mdata(i,j);
            if(isnan(mdata(i,j))==0)
                XY(counter,k)=mdata(i,j);
%                 counter=counter+1;
            else
                if DefaultFlag==1
                    XY(counter,k)=mdata(DefaultRow-1,j);%defualt Value
%                     counter=counter+1;
                else
                    XY(counter,k)=mdata(i,j);
%                     counter=counter+1;
                end
            end
            counter=counter+1;
        end
        k=k+1;%Variable COUNTER
        
    end
end
% %remove NaNs
% k=1;
% for i=1:size(XY,1)
%     if sum(isnan(XY(i,:)))==0
%         XYnoNaN(k,:)=XY(i,:);
%         k=k+1;
%     end
% end
% try
%     Y=XYnoNaN(:,TargetVarIndex);
%     X=XYnoNaN(:,FeatureVarIndex);
% catch
%     X=NaN;
%     Y=NaN;
% end
YAll=XYAll(:,TargetVarIndex);
XAll=XYAll(:,FeatureVarIndex);

Ydef=XY(:,TargetVarIndex);%Replace by default
Xdef=XY(:,FeatureVarIndex);%Replace by default

for i=1:size(XY,2)
    [Xp,Yp]=RemoveNaN(XY(:,i),XY(:,TargetVarIndex));
    XYpairs{i,1}=Xp;
    XYpairs{i,2}=Yp;
    XYpairs{i,3}=VarNames{i};
end

k=1;
IndVarNames={};
for i=1:length(VarNames)
    if strcmp(VarNames{i},TargetVar)==0
        IndVarNames{k}=VarNames{i};
        k=k+1;
    end
end
TypeInd=Type(isnan(Type)==0);
fprintf('Completed\n');