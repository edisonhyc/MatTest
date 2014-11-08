%argv3=[maxrecall, recallaxis, maxaxis]
%argv4=Traderesult
%TradeResult=[Total Trade Times, Wining Rate, Period Return Rate, 
%             Annually Return rate, Maximum Draw Down, P&L: Profit, P&L: Loss, Sharpe Ratio]
function Returncode=Func_DisplayOverall(Startbar,Endbar,argv3,argv4)
close all;
figure(1);
hold on;
grid on;
global Equity Close Multiplier;
global Time;
%% Plot Algo Performance Curve
Ticklabel=Time(Startbar:round((Endbar-Startbar)/7):Endbar);
plot(Equity(1:Endbar-Startbar+1),'r');
plot(Equity(1)+Multiplier*(Close(Startbar:Endbar)-Close(Startbar)),'b');
legend('Portfolio Value','IF-Dominant')
set(gca,'XTickLabel', Ticklabel);
maxaxis=argv3(3);
recallaxis=argv3(2);
plot(recallaxis,Equity(recallaxis),'om','markersize',8);
text(recallaxis,Equity(recallaxis),[' \leftarrow ','Maximum Drawdown=',num2str(argv3(1)*100),'%'],'FontSize',10);
plot(maxaxis,Equity(maxaxis),'om','markersize',8);

disp('Total Trade Times:');
disp(argv4(1));
disp('Wining Rate:');
disp(argv4(2));
disp('Period Return Rate:');
disp(argv4(3));
disp('Annually Return rate:');
disp(argv4(4));
disp('Maximum Draw Down:');
disp(argv4(5));
disp('P&L: Profit,:');
disp(argv4(6));
disp('P&L: Loss:');
disp(argv4(7));
disp(' Sharpe Ratio:');
disp(argv4(8));
Returncode=0;
end