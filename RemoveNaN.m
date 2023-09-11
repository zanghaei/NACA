function [Xp,Yp]=RemoveNaN(varargin)
% Xp x pure which has no NaN
 %[Xp,Yp]=RemoveNaN(X,Y)
Xp=NaN;
Yp=NaN;
if nargin==1
    X=varargin{1};
    Xp=X(~isnan(X));
return
%     Y=MatIn(:,end);
elseif nargin==0
    disp('Not enogh arguments(No Inputs) in RemoveNaN');
elseif nargin==2
        X=varargin{1};
        Y=varargin{2};
end

[mx  nx]=size(X);
mxnew=mx*nx/length(X);
X=reshape(X,length(X),mxnew);
[my ny]=size(Y);
mynew=my*ny/length(Y);
Y=reshape(Y,length(Y),mynew);
mx=mxnew;
my=mynew;

XY=[X,Y];
k=1;
for i=1:length(XY)
    if sum(isnan(XY(i,:)))==0
        Xp(k,1:mxnew)=X(i,:);
        Yp(k,1:mynew)=Y(i,:);
        k=k+1;
    end
end