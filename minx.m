function xm=minx(A,B)
Ind=min(find(B==min(B)));
xm=A(Ind);
end