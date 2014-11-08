clc;
clear variables;
clear global;
close all;
format compact;
addpath(genpath(pwd));
%% Declaration Global Variable Table
global Time Open High Low Close Volume Position Multiplier Positionhold Equity EquityDynamic Tradelog 
%% Setting Contract Relevant
%
%Future Contract Multiplier
%
Multiplier=300;
%
%Future Contract Leverage Ratio/ Test Leverage Ratio
%
Leverage=1;
%
%Commission Fee Ratio
%
Commissionfee=28.7568;

%% Setting Back-Test Relevant
%
%Testing Period
%
Datestart='2011/1/6';
Dateend='2011/10/27';
%
%All Index Become Valid Bar
%
Validbar=100;
%
%Slip Point Used in Back Test
%
Slippoint=0;
%%  Load Data
[Returncode,Time,Open,High,Low,Close,Volume,Position]=Func_Loaddata('IFall.csv');
if Returncode~=0
    display(Returncode);
    return;
end
%% Init
[Returncode,Startbar,Endbar,Equity]=Func_Init([Multiplier Leverage Validbar],{Datestart Dateend},Close,Time);
EquityDynamic=Equity;
Tradelog=zeros(Endbar,1);
Positionhold=0;
if Returncode~=0
    display(Returncode);
    return;
end
display(Returncode);
%% Back Test
% Startbar=400;
% Endbar=5000;
for i=Startbar:Endbar%Startbar+200 %Endbar
    i
    [Returncode,Log]=Func_Backtest(i);
    if Returncode~=0
        display(Returncode);
        return;
    end
    Tradelog(i)=Log; %Write Trading Log 
end
%% Display Result
[Returncode,TradeResult,Drawdown]=Func_Calcresult(Tradelog,[Multiplier,Commissionfee,Slippoint],Startbar,Endbar);
if Returncode~=0
    display(Returncode);
    return;
end
Returncode=Func_DisplayOverall(Startbar,Endbar,Drawdown,TradeResult);
if Returncode~=0
    display(Returncode);
    return;
end
% Returncode=Func_DisplayDetail(Startbar,Startbar+100);
% if Returncode~=0
%     display(Returncode);
%     return;
% end




