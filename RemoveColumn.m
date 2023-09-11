function B=RemoveColumn(A,c)
if c==1
    B=A(:,2:end);
    return;
end
if c==size(A,2)
    B=A(:,1:c-1);
    return;
end
B=[A(:,1:c-1),A(:,c+1:end)];
end