function [X,Y]=RandomizeXY(X,Y)
XY=Randomize([X,Y]);
X=XY(:,1:size(X,2));
Y=XY(:,size(X,2)+1:size(XY,2));
end