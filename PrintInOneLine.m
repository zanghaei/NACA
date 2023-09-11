function S2=PrintInOneLine(Sold,Snew)
% Example:
%        Snew=sprintf([DispString, ' Variable Stage - ', num2str(v)  ,' of ',num2str(L_Vars),' ', ' Rands ',num2str(i),' Of ',num2str(N),' Lentgth=', num2str(length(Yr))]);
%         Sold=PrintInOneLine(Sold,Snew);
        
LS=length(Sold);
if LS>0
    for l=1:LS
        fprintf('\b');
    end
end
S2=sprintf(Snew);
fprintf(S2);
% pause(.5);
end
% name='\n';
% fprintf(name)
% Sold=name;
% %fprintf([name,'\n'])
% for i=1:10:100000
%     Snew=sprintf(['Ali',num2str(i),' yyyy']);
% Sold=PrintInOneLine(Sold,Snew);
% 
% % disp([char([10]),S,'jj',char([10])]);
% end
% fprintf([ '\nEnd\n'])

