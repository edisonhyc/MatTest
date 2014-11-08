%Usage: argv1 is the time point you want its K&D value; 
%       argv2(9) is the short movavg time span, argv3(15) is the long
%       movavg span
function [K_short,D_short,K_long,D_long]=Index_KD(argv1,argv2,argv3)
global Close Low High RSV Kshort Klong
if isempty(RSV) %Initialize RSV when first use it.
    for i=0:2*argv3-1
        temp1=Close(argv1-i)-min(Low(argv1-argv2+1-i:argv1-i));
        temp2=max(High(argv1-argv2+1-i:argv1-i))-min(Low(argv1-argv2+1-i:argv1-i));
        RSV(argv1-i)=temp1/temp2*100;
    end
    for i=0:argv3-1
        Kshort(argv1-i)=sum(RSV(argv1-argv2+1-i:argv1-i))/argv2;
        Klong(argv1-i)=sum(RSV(argv1-argv3+1-i:argv1-i))/argv3;
    end
    K_short=0; K_long=0;      
    D_short=0; D_long=0;
else
    temp1=Close(argv1)-min(Low(argv1-argv2+1:argv1));
    temp2=max(High(argv1-argv2+1:argv1))-min(Low(argv1-argv2+1:argv1));
    RSV(argv1)=temp1/temp2*100;
    K_short=sum(RSV(argv1-argv2+1:argv1))/argv2;     Kshort(argv1)=K_short;
    K_long=sum(RSV(argv1-argv3+1:argv1))/argv3;      Klong(argv1)=K_long;
    D_short=sum(Kshort(argv1-argv2+1:argv1))/argv2;
    D_long=sum(Klong(argv1-argv3+1:argv1))/argv3; 
end

end