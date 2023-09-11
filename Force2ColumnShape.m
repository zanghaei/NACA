function Xc=Force2ColumnShape(X)
%force Force a matrix ColumnShape
[m n]=size(X);
if n==1
    Xc=X;
    return
end
if m==1
    Xc=reshape(X,n,1);
return
end
if m<n
     Xc=reshape(X,n,m);
else
    Xc=X;
end
