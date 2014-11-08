function [Returncode,Log]=Func_Backtest(i)
global Positionhold
[Returncode,Ordertarget]=Strategy_MA(i);%Strategy_Momentum(i); 
if Returncode~=0
    display(Returncode);
    return;
end

Positionhold=Ordertarget;

Log=Ordertarget; %Tradelog:[Ordertarget]

Returncode=0;

end