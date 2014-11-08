function Price=Position_Enterprice(argv1)
global Tradelog Close;
Price=Close(argv1);
for i=argv1-2:-1:1
    if Tradelog(i)~=Tradelog(argv1-1) 
        Price=Close(i+1);
        break;
    end
end
end