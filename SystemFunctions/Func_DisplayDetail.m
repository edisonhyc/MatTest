function Returncode=Func_DisplayDetail(Startbar,Endbar)
figure(2)
close Figure 2;
figure(2)
hold on;
grid on;
global Tradelog Close;
global Time;
%% Plot Algo Performance Curve
Ticklabel=Time(Startbar:round((Endbar-Startbar)/7):Endbar);
plot(Close(Startbar:Endbar),'b');
for i=Startbar:Endbar
    if Tradelog(i-1)~=Tradelog(i)
        if Tradelog(i-1)~=0
            plot(i-Startbar+1,Close(i),'rx','markersize',8);
        end
        if Tradelog(i)==1 
            plot(i-Startbar+1,Close(i),'mo','markersize',8);
        elseif Tradelog(i)==-1
            plot(i-Startbar+1,Close(i),'gs','markersize',8);
        end
    end
end
set(gca,'XTickLabel', Ticklabel);


Returncode=0;
end