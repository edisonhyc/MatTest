%Usage: argv1 is the time point you want its moving average value; 
%       argv2 is the time span
function MA=Index_MA(argv1,argv2)

global Close

MA=sum(Close(argv1-argv2+1:argv1))/argv2;

end