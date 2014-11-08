%Usage: argv1 is the time point you want its ATR; 
%       argv2 is the time span
function ATR=Index_ATR(argv1,argv2)

global Close High Low ATR_TR

if isempty(ATR_TR) %Initialize ATR_TR when first use it.
    for i=argv1-argv2+1:argv1
         ATR_TR(i)=max([High(i)-Low(i), abs(Close(i-1)-High(i)), abs(Close(i-1)-Low(i))]);
    end
else
    ATR_TR(argv1)=max([High(argv1)-Low(argv1), abs(Close(argv1-1)-High(argv1)), abs(Close(argv1-1)-Low(argv1))]);
end

ATR=sum(ATR_TR(argv1-argv2+1:argv1))/argv2;

end