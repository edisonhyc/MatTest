%
%argv1==[Multiplier Leverage Validbar]
%argv2={Datestart Dateend}
%argv3==Close
%argv4==Time
%
%%
function [Returncode,Startbar,Endbar,Equity]=Func_Init(argv1,argv2,argv3,argv4)

Equity=0;

[Returncode,Startbar,Endbar]=Func_Finddate(argv2,argv4);

if Returncode~=0 % Cant Find Datebar
    return;
end

Startbar=max(argv1(3),Startbar);

if Endbar-Startbar<=0 
    Returncode=4;% Insufficient Data Sample
    return;
end

Equity=zeros(Endbar-Startbar+1,1);

Equity(1)=argv3(Startbar)*argv1(1)/argv1(2);

Returncode=0;
end