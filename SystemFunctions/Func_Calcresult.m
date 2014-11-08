%argv2=[Multiplier,Comissionfee,Slippoint]
%argv3=Startbar, argv4=Endbar


%TradeResult=[Total Trade Times, Wining Rate, Period Return Rate, 
%             Annually Return rate, Maximum Draw Down, P&L: Profit, P&L: Loss, Sharpe Ratio]

function [Returncode,TradeResult,Drawdown]=Func_Calcresult(Tradelog,argv2,argv3,argv4)
global Equity EquityDynamic Close Time
Position=0;
Enterprice=0;
WinTimes=0;
TradeResult=[0,0,0,0,0,0,0,0];
%% Calculate Equity & EquityDynamic
for i=1:argv4-argv3+1
    if i~=1
        Equity(i)=Equity(i-1); %init equity for time i
        EquityDynamic(i)=EquityDynamic(i-1);
    end
    Tlog=Tradelog(i+argv3-1);
    CurrentPrice=Close(i+argv3-1);
    EquityDynamic(i)=EquityDynamic(i)+Position*(CurrentPrice-Close(i-1+argv3-1))*argv2(1);
    if Position==0 && Tlog~=0 % position 0--->x
        %Calc Result       
        TradeResult(1)=TradeResult(1)+1;
        %Clear
        Equity(i)=Equity(i)-argv2(2)*abs(Tlog); %Open contract, minus comissionfee.
        EquityDynamic(i)=EquityDynamic(i)-argv2(2)*abs(Tlog);
        Position=Tlog;
        Enterprice=CurrentPrice;
    elseif Position~=0 && Tlog==0 % position x--->0
        %Calc Result
        if Position*(CurrentPrice-Enterprice)>0
            WinTimes=WinTimes+1;
            TradeResult(6)=TradeResult(6)+Position*(CurrentPrice-Enterprice)*argv2(1);
        else
            TradeResult(7)=TradeResult(7)-Position*(CurrentPrice-Enterprice)*argv2(1);
        end
        %Clear
        Equity(i)=Equity(i)+Position*(CurrentPrice-Enterprice)*argv2(1); %Close contract, clear the P&L
        Position=0;
    elseif Position~=0 && Tlog~=Position % position x--->y
        %Calc Result
        TradeResult(1)=TradeResult(1)+1;
        if Position*(CurrentPrice-Enterprice)>0
            WinTimes=WinTimes+1;
            TradeResult(6)=TradeResult(6)+Position*(CurrentPrice-Enterprice)*argv2(1);
        else
            TradeResult(7)=TradeResult(7)-Position*(CurrentPrice-Enterprice)*argv2(1);
        end
        %Clear
        Equity(i)=Equity(i)+Position*(CurrentPrice-Enterprice)*argv2(1); %Close contract, clear the P&L
        Equity(i)=Equity(i)-argv2(2)*abs(Tlog);
        Position=Tlog;
        Enterprice=CurrentPrice;
    end
    
end

TradeResult(2)=WinTimes/TradeResult(1);
TradeResult(3)=(Equity(argv4-argv3+1)-Equity(1))/Equity(1);
Days=datenum(Time(argv4))-datenum(Time(argv3));
TradeResult(4)=(1+TradeResult(3))^(365/Days)-1;

%% Calculate Draw Down
Recall=zeros(length(Equity),1);
maxrecall=100;
recallaxis=0;
maxaxistemp=2;
maxaxis=0;
maxpoint=Equity(2);
for i=2:argv4-argv3+1
    if Equity(i)>maxpoint
        maxpoint=Equity(i);
        maxaxistemp=i;
    else
        if Equity(i)>Equity(i-1)
            Recall(i)=0;
        else
            Recall(i)=(Equity(i)-maxpoint)/maxpoint;
        end
    end
    if Recall(i)<maxrecall
        maxrecall=Recall(i);
        recallaxis=i;
        maxaxis=maxaxistemp;
    end
end
Drawdown=[maxrecall recallaxis maxaxis];

TradeResult(5)=maxrecall;

% r=Equity(2:argv4-argv3+1)-Equity(1:argv4-argv3);
% rinc=0;
% for i=1:argv4-argv3
%     r(i)=r(i)/Equity(i);
%     if r(i)~=0
%         rinc=rinc+1;
%         rr(rinc)=r(i);
%     end
% end
% TradeResult(8)=mean(rr)/std(rr);
%% Calculate Sharpe
ttemp=1; rinc=0;
for i=2:argv4-argv3+1
if strcmp(Time{i}(1:strfind(Time{i},' ')),Time{i-1}(1:strfind(Time{i-1},' ')))==0
    rinc=rinc+1;
    r(rinc)=(EquityDynamic(i)-EquityDynamic(ttemp))/EquityDynamic(ttemp);
end
end
TradeResult(8)=sqrt(252)*mean(r)/std(r);
Returncode=0;
end